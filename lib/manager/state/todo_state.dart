import 'package:todoapp/model/todo_model.dart';

abstract class TodoState {}

class TodoInitial extends TodoState {}
class TodoLoading extends TodoState {}

class TodoLoaded extends TodoState {
  final List<TodoModel> todos;
  TodoLoaded(this.todos);
}

class TodoSuccess extends TodoState {}

class TodoFailure extends TodoState {
  final String error;
  TodoFailure(this.error);
}