import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/constants.dart';
import 'package:todoapp/manager/cubit/todo_cubit.dart';
import 'package:todoapp/model/todo_model.dart';

class ShowDialogDeleteWidget extends StatelessWidget {
  const ShowDialogDeleteWidget({super.key, required this.todo});
  final TodoModel todo;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Constants.textFiledbackGround,
      title: const Text('Delete Todo', style: TextStyle(color: Colors.white)),
      content: Text(
        'Are you sure you want to delete "${todo.title}"?',
        style: const TextStyle(color: Colors.white),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel', style: TextStyle(color: Colors.grey)),
        ),
        TextButton(
          onPressed: () {
            context.read<TodoCubit>().deleteTodo(todo.id);
            Navigator.pop(context);
          },
          child: const Text('Delete', style: TextStyle(color: Colors.red)),
        ),
      ],
    );
  }
}
