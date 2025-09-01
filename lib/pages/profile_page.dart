import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/constants.dart';
import 'package:todoapp/manager/cubit/todo_cubit.dart';
import 'package:todoapp/pages/get_started.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final String email = context.read<TodoCubit>().userEmail!;
    final String id = context.read<TodoCubit>().userId!;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Row(
          children: [
            Image.asset(Constants.logo, height: 30),
            SizedBox(width: 10,),
            const Text(
              'Profile Page',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ],
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
        child: Column(
          children: [
            CircleAvatar(
              radius: 70,
              backgroundImage: AssetImage("${Constants.imagepath}"),
            ),
            SizedBox(height: MediaQuery.of(context).size.height / 30),
            Column(
              children: [
                Center(
                  child: Text(
                    '${email}',
                    style: const TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height / 50),
                Center(
                  child: Text(
                    'ID:${id}',
                    style: const TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height / 50),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(Colors.blue),
                      minimumSize: WidgetStatePropertyAll(
                        Size(double.infinity, 40),
                      ),
                    ),
                    onPressed: () {
                      context.read<TodoCubit>().signOut();
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute<void>(
                          builder: (BuildContext context) => const GetStarted(),
                        ),
                        ModalRoute.withName(GetStarted.id),
                      );
                    },
                    child: Text(
                      'Log Out',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
