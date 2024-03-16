import 'package:ecommerce_api/screens/layoutscreen/layoutcubit/layout._cubit.dart';
import 'package:ecommerce_api/screens/profilescreen/profilescreen_widget/chang_password.dart';
import 'package:ecommerce_api/screens/profilescreen/profilescreen_widget/change_theam.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecommerce_api/screens/layoutscreen/layoutcubit/layout_state.dart';
import 'package:ecommerce_api/screens/profilescreen/profilescreen_widget/logout_widget.dart';
import 'package:ecommerce_api/screens/profilescreen/profilescreen_widget/update_profile.dart';
import 'package:ecommerce_api/shard/const.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    var cubit = BlocProvider.of<LayoutCubit>(context);
    return Scaffold(
      body: BlocConsumer<LayoutCubit, LayoutState>(
        listener: (context, state) {
          if (state is LogoutSuccsessState) {}
        },
        builder: (context, state) {
          return cubit.usermodel != null
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 60.0, // Adjust the size as needed
                      backgroundColor: maincolor, // Border color
                      child: CircleAvatar(
                        radius: 56.0, // Adjust the size as needed
                        backgroundImage:
                            NetworkImage("${cubit.usermodel?.image}"),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "${cubit.usermodel?.name}",
                      style: const TextStyle(
                          fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "${cubit.usermodel?.email}",
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 120),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Text(
                                "${cubit.FavId.length}",
                                style: const TextStyle(
                                    fontSize: 23, fontWeight: FontWeight.bold),
                              ),
                              const Text(
                                "Favorite",
                                style: TextStyle(fontSize: 20),
                              )
                            ],
                          ),
                          Container(
                            height: 50,
                            child: const VerticalDivider(
                              color: Colors.black,
                            ),
                          ),
                          Column(
                            children: [
                              Text(
                                "${cubit.cartsId.length}",
                                style: const TextStyle(
                                    fontSize: 23, fontWeight: FontWeight.bold),
                              ),
                              const Text(
                                "Carts",
                                style: TextStyle(fontSize: 20),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const UpdateProfile(),
                    const SizedBox(
                      height: 40,
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30),
                      child: ChangePassword(),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: ChangTheam(),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30),
                      child: LogOut(),
                    ),
                  ],
                )
              : const Center(
                  child: Text(
                  "Not found data",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ));
        },
      ),
    );
  }
}
