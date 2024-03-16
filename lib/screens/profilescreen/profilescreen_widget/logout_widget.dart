import 'package:ecommerce_api/main.dart';
import 'package:ecommerce_api/screens/authscreen/login_screen.dart';
import 'package:ecommerce_api/screens/homescreen/home_screen.dart';
import 'package:ecommerce_api/screens/layoutscreen/layout_screen.dart';
import 'package:ecommerce_api/screens/layoutscreen/layoutcubit/layout_state.dart';
import 'package:ecommerce_api/shard/const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../layoutscreen/layoutcubit/layout._cubit.dart';

class LogOut extends StatelessWidget {
  const LogOut({Key? key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Show the alert dialog
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              backgroundColor: maincolor,
              title: const Text(
                'Warn!',
                style: TextStyle(fontSize: 22, color: Colors.amber),
              ),
              content: const Text(
                'You Will Lose All Data',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
              actions: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.amber,
                  ),
                  child: BlocConsumer<LayoutCubit, LayoutState>(
                    listener: (context, state) async {
                      if (state is LogoutSuccsessState) {
                        // Replace the current screen with the login screen
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LayoutScreen()),
                          (route) =>
                              false, // This line ensures that there are no routes in the stack
                        );
                      }
                    },
                    builder: (context, state) {
                      return TextButton(
                        onPressed: () async {
                          await BlocProvider.of<LayoutCubit>(context).logOut();
                        },
                        child: state is LogoutLodingState
                            ? const Text(
                                "Logout...",
                                style:
                                    TextStyle(color: Colors.red, fontSize: 19),
                              )
                            : const Text(
                                'OK',
                                style: TextStyle(fontSize: 18),
                              ),
                      );
                    },
                  ),
                ),
              ],
            );
          },
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
              Icons.logout,
              size: 30,
              color: Colors.white,
            ),
          ),
          title: const Text(
            "Logout",
            style: TextStyle(
                color: Color.fromARGB(255, 190, 63, 54),
                fontSize: 22,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
