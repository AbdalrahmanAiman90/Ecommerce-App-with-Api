import 'package:ecommerce_api/screens/profilescreen/chang_pass_screen.dart';
import 'package:ecommerce_api/shard/const.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChangePassword extends StatelessWidget {
  const ChangePassword({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChangePasswordScreen(),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.grey,
        ),
        child: ListTile(
          leading: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: maincolor,
              borderRadius: BorderRadius.circular(100),
            ),
            child: const Icon(
              Icons.password_sharp,
              size: 30,
              color: Colors.white,
            ),
          ),
          title: Text("Change Password"),
        ),
      ),
    );
  }
}
