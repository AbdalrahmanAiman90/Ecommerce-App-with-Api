import 'dart:developer';

import 'package:ecommerce_api/const.dart';
import 'package:ecommerce_api/screens/authscreen/auth_cubit/auth_cubit.dart';
import 'package:ecommerce_api/screens/authscreen/login_screen.dart';
import 'package:ecommerce_api/screens/authscreen/register_screen.dart';
import 'package:ecommerce_api/screens/home_screen.dart';
import 'package:ecommerce_api/screens/splash_screen.dart';
import 'package:ecommerce_api/shard/local_network.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CashNetwork.cashInitialization(); //اول ما يفتح  التطبيق هيستدعيها علطول
  token = CashNetwork.GetFromCash(key: 'token');
  log("Token--> ${token}");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthCubit(),
        ),
      ],
      child: MaterialApp(
        home: token != null && token != "" ? HomeScreen() : LoginScreen(),
      ),
    );
  }
}
