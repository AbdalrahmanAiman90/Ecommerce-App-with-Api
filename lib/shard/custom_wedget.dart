import 'package:flutter/material.dart';

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

Widget Textbutton(
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
