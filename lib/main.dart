import 'dart:developer';

import 'package:ecommerce_api/screens/layoutscreen/layoutcubit/layout_state.dart';
import 'package:ecommerce_api/shard/const.dart';
import 'package:ecommerce_api/screens/authscreen/auth_cubit/auth_cubit.dart';
import 'package:ecommerce_api/screens/authscreen/login_screen.dart';
import 'package:ecommerce_api/screens/authscreen/register_screen.dart';
import 'package:ecommerce_api/screens/homescreen/home_screen.dart';
import 'package:ecommerce_api/screens/layoutscreen/layout_screen.dart';
import 'package:ecommerce_api/screens/layoutscreen/layoutcubit/layout._cubit.dart';
import 'package:ecommerce_api/screens/profilescreen/profile_screen.dart';
import 'package:ecommerce_api/screens/splash_screen.dart';
import 'package:ecommerce_api/shard/local_network.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() async {
  debugInvertOversizedImages = true;
  WidgetsFlutterBinding
      .ensureInitialized(); //مش هتنفذ حاجه غسر لما الي تحتك يكمل الاول
  await CashNetwork.cashInitialization(); //اول ما يفتح  التطبيق هيستدعيها علطول
  token = CashNetwork.GetFromCash(key: 'token');
  CurrentPassword = CashNetwork.GetFromCash(key: 'password');
  log("Token--> ${token}");
  log("Password--> ${CurrentPassword}");

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
        BlocProvider(
          create: (context) => LayoutCubit()
            ..GetCatigoryData()
            ..GetBannerData()
            ..GetfavoritProduct()
            ..getcarts()
            ..GetProductData()
            ..ChangeTheam(TheamState.initial)
            ..GetUserDate(),
        ),
      ],
      child: BlocBuilder<LayoutCubit, LayoutState>(builder: (context, state) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: CashNetwork.GetFromCash(key: 'theam') == "dark"
              ? ThemeData.dark()
              : ThemeData.light(),
          home: token != null &&
                  token != "" &&
                  CurrentPassword != null &&
                  CurrentPassword != ""
              ? SplashScreen()
              : LoginScreen(),
        );
      }),
    );
  }
}
