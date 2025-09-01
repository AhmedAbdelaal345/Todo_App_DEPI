import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/firebase_options.dart';
import 'package:todoapp/manager/cubit/todo_cubit.dart';
import 'package:todoapp/pages/get_started.dart';
import 'package:todoapp/pages/login_page.dart';
import 'package:todoapp/pages/register_page.dart';
import 'package:todoapp/pages/slider_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:todoapp/pages/wrapper_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TodoCubit(),
      child: MaterialApp(
        routes: {
          GetStarted.id: (context) => GetStarted(),
          LoginPage.id: (context) => LoginPage(),
          RegisterPage.id: (context) => RegisterPage(),
          WrapperPage.id: (context) => WrapperPage(),
        },
        title: 'Flutter Demo',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: const SliderPage(),
      ),
    );
  }
}
