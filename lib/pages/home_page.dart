import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';
import 'package:todoapp/constants.dart';
import 'package:todoapp/helper/show_dialog_delete_widge%20.dart';
import 'package:todoapp/helper/state_card_widget.dart';
import 'package:todoapp/manager/cubit/todo_cubit.dart';
import 'package:todoapp/manager/state/todo_state.dart';
import 'package:todoapp/model/todo_model.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController todoController = TextEditingController();
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          'Todo Page',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back, color: Colors.white),
        ),
        actions: [
          IconButton(
            onPressed: () {
              context.read<TodoCubit>().loadTodosFromFirebase();
            },
            icon: const Icon(Icons.refresh, color: Colors.white),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // TextField for adding todos
            TextField(
              controller: todoController,
              onSubmitted: (value) {
                if (value.isNotEmpty) {
                  context.read<TodoCubit>().addTodo(value);
                  todoController.clear();
                } else {
                  Fluttertoast.showToast(
                    msg: 'Please enter a task',
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                    gravity: ToastGravity.BOTTOM,
                  );
                }
              },
              cursorColor: Colors.white,
              decoration: InputDecoration(
                fillColor: Constants.textFiledbackGround,
                filled: true,
                label: const Text(
                  'Task',
                  style: TextStyle(color: Colors.white),
                ),
                hintText: 'Enter a task',
                hintStyle: TextStyle(color: Constants.textFiledTextColor),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide(color: Constants.textFiledBorderColor),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide(color: Constants.textFiledBorderColor),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: const BorderSide(color: Colors.white),
                ),
              ),
              style: const TextStyle(color: Colors.white),
            ),
            const SizedBox(height: 16),
            BlocBuilder<TodoCubit, TodoState>(
              builder: (context, state) {
                final cubit = context.read<TodoCubit>();
                final totalTodos = cubit.todos.length;
                final completedTodos = cubit.completedCount;
                final pendingTodos = cubit.pendingCount;

                return Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Constants.textFiledbackGround,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Constants.textFiledBorderColor),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      StateCardWidget(
                        label: 'Total',
                        count: totalTodos,
                        color: Colors.blue,
                      ),
                      StateCardWidget(
                        label: 'Completed',
                        count: completedTodos,
                        color: Colors.green,
                      ),
                      StateCardWidget(
                        label: 'Pending',
                        count: pendingTodos,
                        color: Colors.orange,
                      ),
                    ],
                  ),
                );
              },
            ),
            Expanded(
              child: BlocConsumer<TodoCubit, TodoState>(
                listener: (context, state) {
                  if (state is TodoFailure) {
                    Fluttertoast.showToast(
                      msg: state.error,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      gravity: ToastGravity.BOTTOM,
                    );
                  } else if (state is TodoSuccess) {
                    Fluttertoast.showToast(
                      msg: 'Action completed successfully',
                      backgroundColor: Colors.green,
                      textColor: Colors.white,
                      gravity: ToastGravity.BOTTOM,
                    );
                  }
                },
                builder: (context, state) {
                  if (state is TodoLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (state is TodoLoaded) {
                    final List<TodoModel> todos = state.todos;

                    if (todos.isEmpty) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Lottie.asset(
                              Constants.emptyLottie,
                              width: 200,
                              height: 200,
                              fit: BoxFit.fill,
                            ),
                            Text(
                              'No todos yet',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              'Add a task to get started!',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      );
                    }

                    return ListView.builder(
                      itemCount: todos.length,
                      itemBuilder: (context, index) {
                        final todo = todos[index];
                        return ListTile(
                          title: Text(
                            todo.title,
                            style: TextStyle(
                              color: Colors.white,
                              decoration: todo.isCompleted
                                  ? TextDecoration.lineThrough
                                  : TextDecoration.none,
                              decorationColor: Colors.red,
                              decorationThickness: 2.0,
                            ),
                          ),
                          subtitle: Text(
                            "Created at: ${_formatDate(todo.createdAt)}",
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
                            ),
                          ),
                          leading: Checkbox(
                            value: todo.isCompleted,
                            onChanged: (value) {
                              context.read<TodoCubit>().toggleTodo(todo.id);
                            },
                            activeColor: Colors.green,
                            checkColor: Colors.black,
                            side: const BorderSide(color: Colors.white),
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (_) =>
                                        ShowDialogDeleteWidget(todo: todo),
                                  );
                                },
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  }
                  return Column(
                    children: [
                      Lottie.asset(
                        Constants.notFoundLottie,
                        width: 200,
                        height: 200,
                        fit: BoxFit.fill,
                      ),
                      const Center(
                        child: Text(
                          'Tap the refresh icon to load your todos',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return "${date.day} / ${date.month} / ${date.year}";
  }
}
