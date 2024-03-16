import 'dart:developer';

import 'package:ecommerce_api/screens/homescreen/home_screen_widget/banner_widget.dart';
import 'package:ecommerce_api/screens/homescreen/home_screen_widget/catigory_widget.dart';
import 'package:ecommerce_api/screens/homescreen/home_screen_widget/product_iteam_widget.dart';
import 'package:ecommerce_api/screens/homescreen/home_screen_widget/titele_widget.dart';
import 'package:ecommerce_api/screens/layoutscreen/layoutcubit/layout._cubit.dart';
import 'package:ecommerce_api/screens/layoutscreen/layoutcubit/layout_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<Home> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context); // Call super.build to maintain state
    return HomeScreen();
  }
}

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    log("message");
    var cubit = BlocProvider.of<LayoutCubit>(context);
    return BlocConsumer<LayoutCubit, LayoutState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(15),
            child: ListView(
              children: [
                SizedBox(
                  height: 50,
                  child: TextFormField(
                    onChanged: (value) {
                      //todo search here
                    },
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 8),
                      hintText: "search",
                      hintStyle: const TextStyle(fontSize: 20),
                      suffixIcon: const Icon(Icons.clear),
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      filled: true,
                      fillColor: Colors.grey,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                cubit.bannerdata.isEmpty
                    ? const Center(child: CupertinoActivityIndicator())
                    : BannerWidget(
                        controller: PageController(),
                        cubit: cubit,
                      ),
                const SizedBox(
                  height: 15,
                ),
                const TitleWidget(funword: "View All", titelWord: "Catigory"),
                const SizedBox(
                  height: 7,
                ),
                SizedBox(
                  height: 100,
                  child: CatigoryWidget(cubit: cubit),
                ),
                const SizedBox(
                  height: 15,
                ),
                const TitleWidget(funword: "view all", titelWord: "Product"),
                const SizedBox(
                  height: 15,
                ),
                state is FavLodinState || state is CarttLodinState
                    ? const Center(
                        child: LinearProgressIndicator(),
                      )
                    : GridView.builder(
                        itemCount: cubit.filterproductdata.isEmpty
                            ? cubit.productdata.length
                            : cubit.filterproductdata.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 12,
                          crossAxisSpacing: 15,
                          childAspectRatio: 0.6,
                        ),
                        itemBuilder: (context, index) {
                          return ProductIteam(
                              cubit: cubit,
                              model: cubit.filterproductdata.isEmpty
                                  ? cubit.productdata[index]
                                  : cubit.filterproductdata[index]);
                        },
                      ),
              ],
            ),
          ),
        );
      },
    );
  }
}
