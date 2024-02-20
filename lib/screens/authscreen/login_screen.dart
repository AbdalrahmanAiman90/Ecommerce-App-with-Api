import 'package:ecommerce_api/const.dart';
import 'package:ecommerce_api/screens/authscreen/auth_cubit/auth_cubit.dart';
import 'package:ecommerce_api/screens/authscreen/auth_cubit/auth_state.dart';
import 'package:ecommerce_api/screens/authscreen/register_screen.dart';
import 'package:ecommerce_api/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  TextEditingController Email = TextEditingController();
  TextEditingController password = TextEditingController();
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                  'images/auth_background.png',
                ),
                fit: BoxFit.fill)),
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                padding: const EdgeInsets.only(bottom: 40),
                alignment: Alignment.bottomCenter,
                child: const Text(
                  "Login in To Proccess",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: logincolor,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40)),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 40),
                  child: SingleChildScrollView(
                    child: Form(
                      key: formkey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Text(
                            "LOGIN",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 50,
                          ),
                          MyText(controler: Email, hinttext: "Email"),
                          const SizedBox(
                            height: 30,
                          ),
                          MyText(
                              controler: password,
                              hinttext: "Password",
                              isobsert: true),
                          const SizedBox(
                            height: 25,
                          ),
                          BlocConsumer<AuthCubit, AuthState>(
                            listener: (context, state) {
                              if (state is FailedToLoginState) {
                                MySnackBar.showErrorMessage(
                                    context, state.ErrorMassege);
                              } else if (state is LoginSuccessState) {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const HomeScreen()));
                              }
                            },
                            builder: (context, state) {
                              return MaterialButton(
                                height: 50,
                                onPressed: () {
                                  if (formkey.currentState!.validate()) {
                                    BlocProvider.of<AuthCubit>(context).Login(
                                        email: Email.text,
                                        password: password.text);
                                  }
                                },
                                minWidth: double.infinity,
                                color: buttoncolor,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8)),
                                child: state is LoginLoadingState
                                    ? const CircularProgressIndicator()
                                    : const Text(
                                        "Login",
                                        style: TextStyle(fontSize: 20),
                                      ),
                              );
                            },
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Textinbutton(
                              onTap: () {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            RegisterScreen()));
                              },
                              context: context,
                              firsttext: "Dont have account ? ",
                              secondtext: "Create one"),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
