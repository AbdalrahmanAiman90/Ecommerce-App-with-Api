import 'package:ecommerce_api/screens/layoutscreen/layoutcubit/layout._cubit.dart';
import 'package:ecommerce_api/screens/layoutscreen/layoutcubit/layout_state.dart';
import 'package:ecommerce_api/screens/profilescreen/chang_pass_screen.dart';
import 'package:ecommerce_api/shard/const.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UpdateUserData extends StatelessWidget {
  UpdateUserData({super.key});
  final userName = TextEditingController();
  final userPone = TextEditingController();

  final userEmail = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Update Profile")),
        backgroundColor: logincolor,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        child: ListView(
          children: [
            TextField(
              controller: userName,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Name",
                  labelStyle: TextStyle(fontSize: 22)),
            ),
            SizedBox(
              height: 15,
            ),
            TextField(
              controller: userEmail,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Email",
                  labelStyle: TextStyle(fontSize: 22)),
            ),
            SizedBox(
              height: 15,
            ),
            TextField(
              controller: userPone,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Phone",
                  labelStyle: TextStyle(fontSize: 22)),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              decoration: BoxDecoration(
                color: maincolor,
                borderRadius: BorderRadius.circular(20),
              ),
              width: double.infinity,
              child: BlocConsumer<LayoutCubit, LayoutState>(
                listener: (context, state) {
                  if (state is UpdateUserDataSuccsessState) {
                    showSnack(context, "Update Succsess", true);
                    Future.delayed(Duration(seconds: 2), () {
                      Navigator.pop(context);
                    });
                  }
                  if (state is UpdateUserDataFalurState) {
                    showSnack(context, state.error, false);
                  }
                },
                builder: (context, state) {
                  return TextButton(
                    onPressed: () {
                      if (userName.text.isNotEmpty &&
                          userEmail.text.isNotEmpty &&
                          userPone.text.isNotEmpty) {
                        BlocProvider.of<LayoutCubit>(context).UpdateUserData(
                            name: userName.text,
                            phone: userPone.text,
                            email: userEmail.text);
                      } else {
                        showSnack(context, "please wnter field", false);
                      }
                    },
                    child: state is UpdateUserDataLodingState
                        ? CircularProgressIndicator()
                        : Text(
                            "Update",
                            style: TextStyle(fontSize: 22, color: Colors.white),
                          ),
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
