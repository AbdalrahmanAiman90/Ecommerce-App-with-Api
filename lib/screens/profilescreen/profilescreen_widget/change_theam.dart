import 'package:ecommerce_api/screens/layoutscreen/layoutcubit/layout._cubit.dart';
import 'package:ecommerce_api/screens/layoutscreen/layoutcubit/layout_state.dart';
import 'package:ecommerce_api/shard/const.dart';
import 'package:ecommerce_api/shard/local_network.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChangTheam extends StatefulWidget {
  ChangTheam({super.key});

  @override
  State<ChangTheam> createState() => _ChangTheamState();
}

class _ChangTheamState extends State<ChangTheam> {
  bool stut = Currenttheam();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LayoutCubit, LayoutState>(
      listener: (context, state) {
        if (state is AppLightTheamState ||
            CashNetwork.GetFromCash(key: 'theam') == 'light') {
          stut = false;
        } else if (state is AppDarkTheamState) {
          stut = true;
        }
      },
      builder: (context, state) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.grey,
          ),
          child: SwitchListTile(
            inactiveTrackColor: Colors.white,
            activeTrackColor: maincolor,
            title: const Text("Change Color"),
            value: stut,
            onChanged: (value) {
              if (stut == false) {
                BlocProvider.of<LayoutCubit>(context)
                    .ChangeTheam(TheamState.dark);
              } else if (stut == true) {
                BlocProvider.of<LayoutCubit>(context)
                    .ChangeTheam(TheamState.light);
              }
            },
            secondary: Container(
              decoration: BoxDecoration(
                color: maincolor,
                borderRadius: BorderRadius.circular(100),
              ),
              width: 40,
              height: 40,
              child: const Icon(
                CupertinoIcons.moon_stars,
                color: Colors.white,
              ),
            ),
          ),
        );
      },
    );
  }
}
