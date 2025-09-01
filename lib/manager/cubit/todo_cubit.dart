import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/manager/state/todo_state.dart';
import 'package:todoapp/model/todo_model.dart';

class TodoCubit extends Cubit<TodoState> {
  TodoCubit() : super(TodoInitial());

  final List<TodoModel> _todos = [];

  
  List<TodoModel> get todos => _todos;


  
  String? userId;
  String? userEmail;
  String? userpassword;
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  void setUserData({required String uid,required String email,required String password}) {
    userId = uid;
    userEmail = email;
    userpassword = password;
  }

  
  Future<void> loadTodosFromFirebase() async {
    if (userId == null) return;
    try {
      emit(TodoLoading());
      final doc = await users.doc(userId).get();
      if (doc.exists) {
        final data = doc.data() as Map<String, dynamic>?;
        final todosData = data?['todos'] as List<dynamic>? ?? [];
        _todos.clear();
        _todos.addAll(todosData.map((map) => _todoFromMap(map)));
      }
      // Emit the state WITH the data
      emit(TodoLoaded(List.from(_todos)));
    } catch (e) {
      emit(TodoFailure("Failed to load todos: ${e.toString()}"));
    }
  }

  
  Future<void> addTodo(String title) async {
    if (userId == null) return;

    final newTodo = TodoModel(
      id: DateTime.now().microsecondsSinceEpoch,
      title: title,
      createdAt: DateTime.now(),
    );

    final previousTodos = List<TodoModel>.from(_todos); // Backup for rollback
    
    // 1. Optimistically update local list and UI
    _todos.add(newTodo);
    emit(TodoLoaded(List.from(_todos))); // <-- UI updates immediately!

    try {
      // 2. Sync to Firebase in the background
      await _syncTodosToFirebase();
    } catch (e) {
      // 3. If sync fails, roll back the change and notify user
      _todos.clear();
      _todos.addAll(previousTodos);
      emit(TodoLoaded(List.from(_todos))); // Revert UI
      emit(TodoFailure("Failed to add todo: ${e.toString()}"));
    }
  }

  Future<void> deleteTodo(int id) async {
    if (userId == null) return;

    final previousTodos = List<TodoModel>.from(_todos);
    _todos.removeWhere((todo) => todo.id == id);
    emit(TodoLoaded(List.from(_todos))); 

    try {
      await _syncTodosToFirebase();
    } catch (e) {
      _todos.clear();
      _todos.addAll(previousTodos);
      emit(TodoLoaded(List.from(_todos)));
      emit(TodoFailure("Failed to delete todo: ${e.toString()}"));
    }
  }

  Future<void> toggleTodo(int id) async {
    if (userId == null) return;

    final index = _todos.indexWhere((todo) => todo.id == id);
    if (index == -1) return;

    final previousTodos = List<TodoModel>.from(_todos);
    final originalTodo = _todos[index];
    _todos[index] = originalTodo.copyWith(
      isCompleted: !originalTodo.isCompleted,
      updatedAt: DateTime.now(),
    );
    emit(TodoLoaded(List.from(_todos))); // Update UI immediately

    try {
      await _syncTodosToFirebase();
    } catch (e) {
      _todos.clear();
      _todos.addAll(previousTodos);
      emit(TodoLoaded(List.from(_todos)));
      emit(TodoFailure("Failed to toggle todo: ${e.toString()}"));
    }
  }

  Future<void> _syncTodosToFirebase() async {
    if (userId == null) throw Exception("User is not logged in.");
    
    final todosMap = _todos.map((todo) => _todoToMap(todo)).toList();
    await users.doc(userId).set({
      "todos": todosMap,
    }, SetOptions(merge: true));
  }

  Map<String, dynamic> _todoToMap(TodoModel todo) {
    return {
      'id': todo.id,
      'title': todo.title,
      'isCompleted': todo.isCompleted,
      'createdAt': todo.createdAt.millisecondsSinceEpoch,
      'updatedAt': todo.updatedAt?.millisecondsSinceEpoch,
    };
  }

  TodoModel _todoFromMap(Map<String, dynamic> map) {
    return TodoModel(
      id: map['id'],
      title: map['title'] ?? '',
      isCompleted: map['isCompleted'] ?? false,
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt']),
      updatedAt: map['updatedAt'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['updatedAt'])
          : null,
    );
  }

  int get completedCount => _todos.where((todo) => todo.isCompleted).length;
  int get pendingCount => _todos.where((todo) => !todo.isCompleted).length;

  void signOut() {
    userId = null;
    _todos.clear();
    
    emit(TodoInitial());
  }
}