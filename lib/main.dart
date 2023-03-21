import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pong_game/cubits/game_cubit.dart';
import 'package:pong_game/views/screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GameCubit(),
      child: const MaterialApp(
        title: 'Pong',
        debugShowCheckedModeBanner: false,
        home: HomeScreen(),
      ),
    );
  }
}
