import 'dart:developer';

import 'package:ecommerce_api/shard/const.dart';
import 'package:ecommerce_api/screens/layoutscreen/layoutcubit/layout._cubit.dart';
import 'package:ecommerce_api/screens/layoutscreen/layoutcubit/layout_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class LayoutScreen extends StatelessWidget {
  const LayoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = BlocProvider.of<LayoutCubit>(context);
    return BlocConsumer<LayoutCubit, LayoutState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.buttomindex,
            selectedItemColor: maincolor,
            unselectedItemColor: Colors.grey,
            type: BottomNavigationBarType.fixed,
            onTap: (index) {
              cubit.ChangeCutrentIndex(index: index);
            },
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.category), label: 'catigory'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.favorite), label: 'favorit'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.shopify_rounded), label: 'cart'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person), label: 'profile'),
            ],
          ),
          appBar: AppBar(
              backgroundColor: const Color.fromARGB(255, 227, 213, 163),
              elevation: 0,
              title: SvgPicture.asset(
                'images/logo.svg',
                height: 50,
                width: 50,
              )),
          body: cubit.LayoutScreen[cubit.buttomindex],
        );
      },
    );
  }
}
