import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_api/model/catigory_model.dart';
import 'package:ecommerce_api/screens/layoutscreen/layoutcubit/layout._cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CatigoryScreen extends StatelessWidget {
  const CatigoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<CatigoryModel> categoriesData =
        BlocProvider.of<LayoutCubit>(context).catigorydata;
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: GridView.builder(
          itemCount: categoriesData.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, mainAxisSpacing: 20, crossAxisSpacing: 15),
          itemBuilder: (context, index) {
            return Container(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 4),
              child: Column(
                children: [
                  Expanded(
                    child: CachedNetworkImage(
                      maxHeightDiskCache: 100,
                      fit: BoxFit.cover,
                      imageUrl: categoriesData[index].url!,
                      placeholder: (context, url) =>
                          const Center(child: CircularProgressIndicator()),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(categoriesData[index].name!)
                ],
              ),
            );
          }),
    ));
  }
}
