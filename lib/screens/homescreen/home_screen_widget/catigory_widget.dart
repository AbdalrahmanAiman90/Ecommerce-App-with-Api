import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_api/screens/layoutscreen/layoutcubit/layout._cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CatigoryWidget extends StatelessWidget {
  final LayoutCubit cubit;

  const CatigoryWidget({super.key, required this.cubit});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Column(
            children: [
              CircleAvatar(
                radius: 35,
                child: CachedNetworkImage(
                  maxHeightDiskCache: 100,
                  fit: BoxFit.cover,
                  imageUrl: cubit.catigorydata[index].url!,
                  placeholder: (context, url) =>
                      const Center(child: CircularProgressIndicator()),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
              Text(
                cubit.catigorydata[index].name!,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          );
        },
        separatorBuilder: (context, index) => const SizedBox(
              width: 15,
            ),
        itemCount: cubit.catigorydata.length);
  }
}
