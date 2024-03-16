import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_api/screens/layoutscreen/layoutcubit/layout._cubit.dart';
import 'package:ecommerce_api/screens/layoutscreen/layoutcubit/layout_state.dart';
import 'package:ecommerce_api/shard/const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var removingIndex = -1;
    final cubit = BlocProvider.of<LayoutCubit>(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 12),
        child: BlocConsumer<LayoutCubit, LayoutState>(
          listener: (context, state) {
            // TODO: implement listener
          },
          builder: (context, state) {
            return Column(
              children: [
                Expanded(
                    child: ListView.separated(
                        separatorBuilder: (context, index) => const SizedBox(
                              height: 12,
                            ),
                        itemCount:
                            cubit.carts.length == 0 ? 1 : cubit.carts.length,
                        itemBuilder: (context, index) {
                          return cubit.carts.isNotEmpty
                              ? Container(
                                  padding: const EdgeInsets.all(5),
                                  decoration: const BoxDecoration(
                                    color: logincolor,
                                  ),
                                  child: Row(
                                    children: [
                                      CachedNetworkImage(
                                        maxHeightDiskCache: 120,
                                        width: 160,
                                        height: 110,
                                        fit: BoxFit.fill,
                                        imageUrl: cubit.carts[index].image!,
                                        placeholder: (context, url) =>
                                            const Center(
                                                child:
                                                    CircularProgressIndicator()),
                                        errorWidget: (context, url, error) =>
                                            const Icon(Icons.error),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              cubit.carts[index].name!,
                                              style: const TextStyle(
                                                  fontSize: 18,
                                                  overflow:
                                                      TextOverflow.ellipsis),
                                            ),
                                            const SizedBox(
                                              height: 8,
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  "${cubit.carts[index].price!} \$",
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Color.fromARGB(
                                                          255, 4, 131, 8)),
                                                ),
                                                const SizedBox(
                                                  width: 5,
                                                ),
                                                if (cubit.carts[index].price !=
                                                    cubit.carts[index].oldprice)
                                                  Text(
                                                    "${cubit.carts[index].oldprice!} \$",
                                                    style: const TextStyle(
                                                        decoration:
                                                            TextDecoration
                                                                .lineThrough),
                                                  ),
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                OutlinedButton(
                                                  onPressed: () {
                                                    removingIndex = index;
                                                    print(
                                                        "[[[[[[[[[[[[[[[[${removingIndex}]]]]]]]]]]]]]]]]");
                                                    cubit
                                                        .AddOrRemoveFavoritList(
                                                            id: cubit
                                                                .carts[index].id
                                                                .toString());
                                                  },
                                                  child: state
                                                              is FavLodinState &&
                                                          removingIndex == index
                                                      ? CircularProgressIndicator()
                                                      : Icon(
                                                          Icons.favorite,
                                                          color: cubit.FavId
                                                                  .contains(cubit
                                                                      .carts[
                                                                          index]
                                                                      .id
                                                                      .toString())
                                                              ? Colors.red
                                                              : Colors.black,
                                                        ),
                                                ),
                                                GestureDetector(
                                                  child: state
                                                              is CarttLodinState &&
                                                          removingIndex == index
                                                      ? CircularProgressIndicator()
                                                      : Icon(
                                                          Icons.delete,
                                                          size: 30,
                                                        ),
                                                  onTap: () {
                                                    removingIndex = index;
                                                    print(
                                                        "[[[[[[[[[[[[[[[[${removingIndex}]]]]]]]]]]]]]]]]");
                                                    cubit.AddOrRemoveCarts(
                                                        id: cubit
                                                            .carts[index].id
                                                            .toString());
                                                  },
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              : const Center(
                                  child: Text(
                                  "Not Found Iteam",
                                  style: TextStyle(
                                    fontSize: 30,
                                  ),
                                ));
                        })),
                Container(
                  color: Color.fromARGB(255, 174, 188, 209),
                  child: Text(
                    "Tootal Price :${cubit.totalPrice}\$",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
