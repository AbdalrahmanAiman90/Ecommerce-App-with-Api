import 'package:ecommerce_api/shard/local_network.dart';
import 'package:flutter/material.dart';

const buttoncolor = Color.fromARGB(226, 4, 103, 7);
const logincolor = Color.fromARGB(255, 156, 185, 205);
const maincolor = Color.fromARGB(255, 3, 86, 142);
String? token;
String? CurrentPassword;

enum TheamState { initial, dark, light }

// Function to current theam
bool Currenttheam() {
  if (CashNetwork.GetFromCash(key: 'theam') == 'dark') {
    return true;
  } else {
    return false;
  }
}
