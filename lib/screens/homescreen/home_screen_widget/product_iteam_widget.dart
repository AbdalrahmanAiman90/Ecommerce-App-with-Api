import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_api/model/product_model.dart';
import 'package:ecommerce_api/screens/layoutscreen/layoutcubit/layout._cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductIteam extends StatelessWidget {
  final LayoutCubit cubit;
  final ProducrModel model;
  const ProductIteam({
    super.key,
    required this.model,
    required this.cubit,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topLeft,
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: const Color.fromARGB(255, 84, 121, 160).withOpacity(0.2),
          ),
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Align(
                alignment: Alignment.topRight,
                child: GestureDetector(
                  child: Icon(
                    Icons.favorite,
                    color: cubit.FavId.contains(model.id.toString())
                        ? const Color.fromARGB(255, 252, 2, 2)
                        : const Color.fromARGB(255, 0, 0, 0),
                  ),
                  onTap: () async {
                    await cubit.AddOrRemoveFavoritList(id: model.id.toString());
                  },
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: CachedNetworkImage(
                  maxHeightDiskCache: 160,
                  imageUrl: model.image!,
                  placeholder: (context, url) =>
                      const Center(child: CircularProgressIndicator()),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                model.name!,
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    overflow: TextOverflow.ellipsis),
              ),
              const SizedBox(
                height: 2,
              ),
              Row(
                children: [
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              "${model.price!} \$",
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Color.fromARGB(255, 2, 200, 9)),
                            )),
                        const SizedBox(
                          width: 5,
                        ),
                        FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            "${model.oldprice!} \$",
                            style: const TextStyle(
                                color: Color.fromARGB(255, 136, 99, 72),
                                fontSize: 16,
                                decoration: TextDecoration.lineThrough),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        CircleAvatar(
          backgroundColor: Colors.transparent,
          child: IconButton(
            color: cubit.cartsId.contains(model.id.toString())
                ? Colors.red
                : Colors.black,
            icon: Icon(
              Icons.shopping_cart,
              size: 30,
            ),
            onPressed: () {
              cubit.AddOrRemoveCarts(id: model.id.toString());
            },
          ),
        ),
      ],
    );
  }
}
