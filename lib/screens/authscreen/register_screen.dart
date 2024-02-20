import 'package:ecommerce_api/screens/authscreen/auth_cubit/auth_cubit.dart';
import 'package:ecommerce_api/screens/authscreen/auth_cubit/auth_state.dart';
import 'package:ecommerce_api/screens/authscreen/login_screen.dart';
import 'package:ecommerce_api/screens/home_screen.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'auth_cubit/auth_state.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});
  final TextEditingController name = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController rpassword = TextEditingController();

  final TextEditingController Email = TextEditingController();

  final TextEditingController phone = TextEditingController();
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthFauilerState) {
          MySnackBar.showErrorMessage(context, state.ErrorMassege);
        } else if (state is AuthSuccsesState) {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const HomeScreen()));
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Form(
              key: formkey,
              child: SingleChildScrollView(
                padding: const EdgeInsets.only(top: 100),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Sign UP",
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    MyText(
                        controler: name,
                        hinttext: "user name",
                        border: const OutlineInputBorder()),
                    const SizedBox(
                      height: 20,
                    ),
                    MyText(
                        controler: Email,
                        hinttext: "Email",
                        border: const OutlineInputBorder()),
                    const SizedBox(
                      height: 20,
                    ),
                    MyText(
                        controler: password,
                        hinttext: "password",
                        border: const OutlineInputBorder(),
                        isobsert: true),
                    const SizedBox(
                      height: 20,
                    ),
                    MyText(
                      controler: rpassword,
                      hinttext: "confirm password",
                      isobsert: true,
                      validator: (value) {
                        if (value != password.text) {
                          return "not matches password";
                        } else {
                          return null;
                        }
                      },
                      border: const OutlineInputBorder(),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    MyText(
                        controler: phone,
                        hinttext: "phone",
                        border: const OutlineInputBorder()),
                    const SizedBox(
                      height: 20,
                    ),
                    MaterialButton(
                      onPressed: () {
                        if (formkey.currentState!.validate()) {
                          BlocProvider.of<AuthCubit>(context).register(
                              name: name.text,
                              email: Email.text,
                              password: password.text,
                              phone: phone.text);
                        }
                      },
                      minWidth: double.infinity,
                      // ignore: sort_child_properties_last
                      child: state is AuthLodingState
                          ? const CircularProgressIndicator()
                          : const Text(
                              "Register",
                              style: TextStyle(fontSize: 20),
                            ),
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      color: const Color.fromARGB(226, 4, 103, 7),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Textinbutton(
                        context: context,
                        onTap: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginScreen()));
                        },
                        firsttext: "Already have account",
                        secondtext: "LoginPage"),
                    SafeArea(
                        child: SizedBox(
                      height: 20,
                    )),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

Widget MyText(
    {bool? isobsert,
    InputBorder? border,
    String? Function(String?)? validator,
    required TextEditingController controler,
    required String hinttext}) {
  return TextFormField(
    obscureText: isobsert ?? false,
    controller: controler,
    decoration: InputDecoration(
      hintText: hinttext,
      border: border,
    ),
    validator: validator ??
        (value) {
          if (value!.isEmpty) {
            return "should enter ${hinttext}";
          } else {
            return null;
          }
        },
  );
}

class MySnackBar {
  static void showErrorMessage(BuildContext context, String errorMessage) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 5),
        dismissDirection: DismissDirection.up,
        behavior: SnackBarBehavior.floating,
        backgroundColor: const Color.fromARGB(209, 194, 7, 1),
        content: Container(
          child: Text(
            errorMessage,
            style: const TextStyle(fontSize: 20),
          ),
        ),
      ),
    );
  }
}

Widget Textinbutton(
    {required String firsttext,
    required String secondtext,
    required BuildContext context,
    required void Function()? onTap}) {
  return Row(
    children: [
      Text(
        firsttext,
        style: const TextStyle(
          fontSize: 18,
          color: Colors.black,
        ),
      ),
      GestureDetector(
        onTap: onTap,
        child: Text(
          secondtext,
          style: const TextStyle(
              fontSize: 20,
              color: Color.fromARGB(255, 4, 74, 131),
              fontWeight: FontWeight.bold),
        ),
      )
    ],
  );
}
