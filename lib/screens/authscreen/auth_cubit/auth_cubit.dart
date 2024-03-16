import 'dart:convert';
import 'dart:developer';

import 'package:ecommerce_api/screens/authscreen/auth_cubit/auth_state.dart';
import 'package:ecommerce_api/screens/layoutscreen/layoutcubit/layout._cubit.dart';
import 'package:ecommerce_api/shard/const.dart';
import 'package:ecommerce_api/shard/local_network.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitialState());
//Register function
  Future<void> register(
      {required String name,
      required String email,
      required String password,
      required String phone}) async {
    emit(RegisterLodingState());
    // do requst

    try {
      Response responce = await http.post(
          Uri.parse("https://student.valuxapps.com/api/register"),
          headers: {
            'lang': 'en'
          },
          body: {
            'name': name,
            'email': email,
            'password': password,
            'phone': phone,
          });
//do decode for requst

      if (responce.statusCode == 200) {
        var ResponseData = jsonDecode(responce.body);
//do logic

        if (ResponseData['status'] == true) {
          await CashNetwork.InsertToCash(
              key: 'token', value: ResponseData['data']['token']);
          await CashNetwork.InsertToCash(key: 'password', value: password);

          token = CashNetwork.GetFromCash(key: 'token');
          CurrentPassword = CashNetwork.GetFromCash(key: 'password');
          emit(RegisterSuccsesState());
        } else {
          emit(RegisterFauilerState(ErrorMassege: ResponseData['message']));
        }
      }
    } on Exception catch (e) {
      emit(RegisterFauilerState(ErrorMassege: e.toString()));
    }
  }

//Login Function
  Future<void> Login({required String email, required String password}) async {
    emit(LoginLoadingState());
    // do requst
    try {
      Response responce = await http.post(
          Uri.parse(
            "https://student.valuxapps.com/api/login",
          ),
          body: {'email': email, 'password': password});
//do decode for requst
      if (responce.statusCode == 200) {
        var ResponseData = jsonDecode(responce.body);
//do logic

        if (ResponseData['status'] == true) {
          await CashNetwork.InsertToCash(
            key: 'token',
            value: ResponseData['data']['token'],
          );
          await CashNetwork.InsertToCash(key: 'password', value: password);
          token = CashNetwork.GetFromCash(key: 'token');
          CurrentPassword = CashNetwork.GetFromCash(key: 'password');
          log("${token}");
          emit(LoginSuccessState());
        } else {
          emit(FailedToLoginState(ErrorMassege: ResponseData['message']));
        }
      }
    } on Exception catch (e) {
      emit(FailedToLoginState(ErrorMassege: e.toString()));
    }
  }

  @override
  void onChange(Change<AuthState> change) {
    super.onChange(change);
    print(change);
  }
}
