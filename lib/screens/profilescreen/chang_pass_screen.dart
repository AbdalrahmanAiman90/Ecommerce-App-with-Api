import 'package:ecommerce_api/screens/layoutscreen/layoutcubit/layout._cubit.dart';
import 'package:ecommerce_api/screens/layoutscreen/layoutcubit/layout_state.dart';
import 'package:ecommerce_api/shard/const.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChangePasswordScreen extends StatelessWidget {
  ChangePasswordScreen({super.key});
  final currentPasswordcuntrooler = TextEditingController();
  final newPasswordcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chang Password"),
        backgroundColor: logincolor,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 30),
        child: Column(
          children: [
            TextField(
              controller: currentPasswordcuntrooler,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), labelText: "Current Password"),
            ),
            SizedBox(
              height: 15,
            ),
            TextField(
              controller: newPasswordcontroller,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), labelText: "NewPassword"),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  color: maincolor, borderRadius: BorderRadius.circular(18)),
              child: BlocConsumer<LayoutCubit, LayoutState>(
                listener: (context, state) {
                  if (state is ChangePasswordSucssesState) {
                    showSnack(context, "Change Succsess", true);
                    Future.delayed(Duration(seconds: 2), () {
                      // After 3 seconds, pop the current route
                      Navigator.pop(context);
                    });
                  }
                  if (state is ChangePasswordFaluirState) {
                    showSnack(context, state.error, false);
                  }
                },
                builder: (context, state) {
                  return TextButton(
                    child: state is ChangePasswordLoadingState
                        ? Center(child: CircularProgressIndicator())
                        : const Text(
                            'Change',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                    onPressed: () {
                      if (currentPasswordcuntrooler.text.trim() ==
                          CurrentPassword) {
                        if (newPasswordcontroller.text.length > 3) {
                          BlocProvider.of<LayoutCubit>(context).changePassword(
                              currentPassword: currentPasswordcuntrooler.text,
                              newPassword: newPasswordcontroller.text);
                        }
                      } else {
                        showSnack(context, "please, verifay current Password ",
                            false);
                      }
                    },
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

void showSnack(BuildContext context, String massage, bool status) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text("${massage}"),
    backgroundColor: status ? Colors.green : Colors.red,
  ));
}
