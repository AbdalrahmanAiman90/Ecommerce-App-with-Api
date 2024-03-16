import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_api/screens/layoutscreen/layoutcubit/layout._cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BannerWidget extends StatelessWidget {
  final PageController controller;
  final LayoutCubit cubit;
  const BannerWidget(
      {super.key, required this.controller, required this.cubit});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 160,
          width: double.infinity,
          child: PageView.builder(
            controller: controller,
            physics: const BouncingScrollPhysics(),
            itemCount: 4,
            itemBuilder: (context, index) {
              return Container(
                padding: const EdgeInsets.only(right: 12),
                child: CachedNetworkImage(
                  maxHeightDiskCache: 160,
                  imageUrl: cubit.bannerdata[index].url!,
                  placeholder: (context, url) =>
                      Center(child: CircularProgressIndicator()),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              );
            },
          ),
        ),
        const SizedBox(
          height: 12,
        ),
        Center(
          child: SmoothPageIndicator(
            controller: controller,
            count: 4,
            axisDirection: Axis.horizontal,
            effect: const SlideEffect(
                spacing: 8.0,
                radius: 25,
                dotWidth: 14,
                dotHeight: 10,
                paintStyle: PaintingStyle.stroke,
                strokeWidth: 1.5,
                dotColor: Colors.grey,
                activeDotColor: Colors.indigo),
          ),
        ),
      ],
    );
  }
}
