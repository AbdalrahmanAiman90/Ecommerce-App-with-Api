import 'package:ecommerce_api/shard/const.dart';
import 'package:flutter/cupertino.dart';

class TitleWidget extends StatelessWidget {
  final String titelWord, funword;
  const TitleWidget(
      {super.key, required this.funword, required this.titelWord});

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Text(
        titelWord,
        style: const TextStyle(
            fontSize: 25, color: maincolor, fontWeight: FontWeight.bold),
      ),
      Text(
        funword,
        style: const TextStyle(
            fontSize: 20,
            color: Color.fromARGB(255, 4, 175, 64),
            fontWeight: FontWeight.bold),
      ),
    ]);
  }
}
