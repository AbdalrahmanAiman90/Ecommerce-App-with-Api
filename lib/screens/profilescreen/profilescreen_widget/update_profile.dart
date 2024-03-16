import 'package:ecommerce_api/screens/profilescreen/update_user_screen.dart';
import 'package:ecommerce_api/shard/const.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UpdateProfile extends StatelessWidget {
  const UpdateProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 180,
      decoration: BoxDecoration(
          color: maincolor, borderRadius: BorderRadius.circular(18)),
      child: TextButton(
        child: const Text(
          'Update Profile',
          style: TextStyle(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => UpdateUserData(),
            ),
          );
        },
      ),
    );
  }
}
