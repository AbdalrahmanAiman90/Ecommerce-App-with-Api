import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_api/screens/layoutscreen/layoutcubit/layout._cubit.dart';
import 'package:ecommerce_api/screens/layoutscreen/layoutcubit/layout_state.dart';
import 'package:ecommerce_api/shard/const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoritScreen extends StatelessWidget {
  const FavoritScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cubit = BlocProvider.of<LayoutCubit>(context);
    var removingIndex =
        -1; // Initialize removingIndex with a value that doesn't correspond to any valid index

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: BlocConsumer<LayoutCubit, LayoutState>(
          listener: (context, state) {
            // Handle listener if needed
          },
          builder: (context, state) {
            return Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(
                    hintText: "search",
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: ListView.builder(
                    itemCount: cubit.favorititeam.isEmpty
                        ? 1
                        : cubit.favorititeam.length,
                    itemBuilder: (context, index) {
                      return cubit.favorititeam.isNotEmpty
                          ? Container(
                              padding: const EdgeInsets.all(8),
                              margin: const EdgeInsets.symmetric(
                                  vertical: 13, horizontal: 13),
                              color: logincolor,
                              child: Row(
                                children: [
                                  Expanded(
                                    child: CachedNetworkImage(
                                      maxHeightDiskCache: 120,
                                      width: 150,
                                      height: 110,
                                      fit: BoxFit.fill,
                                      imageUrl:
                                          cubit.favorititeam[index].image!,
                                      placeholder: (context, url) =>
                                          const Center(
                                              child:
                                                  CircularProgressIndicator()),
                                      errorWidget: (context, url, error) =>
                                          const Icon(Icons.error),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          cubit.favorititeam[index].name!,
                                          maxLines: 1,
                                          style: const TextStyle(
                                            fontSize: 17,
                                            color:
                                                Color.fromARGB(255, 2, 51, 92),
                                            fontWeight: FontWeight.bold,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        Text(
                                          "${cubit.favorititeam[index].price!}\$",
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color:
                                                Color.fromARGB(255, 19, 142, 5),
                                            fontSize: 18,
                                          ),
                                        ),
                                        MaterialButton(
                                          color: maincolor,
                                          onPressed: () {
                                            // Set removingIndex to the index of the item being removed
                                            removingIndex = index;
                                            cubit.AddOrRemoveFavoritList(
                                              id: cubit.favorititeam[index].id
                                                  .toString(),
                                            );
                                          },
                                          textColor: Colors.white,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(25),
                                          ),
                                          child: state is FavLodinState &&
                                                  removingIndex == index
                                              ? const Center(
                                                  child: Text(
                                                    "Is Removing...",
                                                    style: TextStyle(
                                                      fontSize: 18,
                                                      color: Color.fromARGB(
                                                          238, 241, 21, 5),
                                                    ),
                                                  ),
                                                )
                                              : const Text("Remove"),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : const Center(
                              child: Text(
                                "Not Found Item",
                                style: TextStyle(
                                  fontSize: 30,
                                ),
                              ),
                            );
                    },
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
