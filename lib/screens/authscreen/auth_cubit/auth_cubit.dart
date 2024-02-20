import 'dart:convert';

import 'package:ecommerce_api/screens/authscreen/auth_cubit/auth_state.dart';
import 'package:ecommerce_api/shard/local_network.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitialState());

  Future<void> register(
      {required String name,
      required String email,
      required String password,
      required String phone}) async {
    emit(AuthLodingState());

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

      if (responce.statusCode == 200) {
        var ResponseData = jsonDecode(responce.body);
        if (ResponseData['status'] == true) {
          emit(AuthSuccsesState());
        } else {
          emit(AuthFauilerState(ErrorMassege: ResponseData['message']));
        }
      }
    } on Exception catch (e) {
      emit(AuthFauilerState(ErrorMassege: e.toString()));
    }
  }

  Future<void> Login({required String email, required String password}) async {
    emit(LoginLoadingState());
    try {
      Response responce = await http.post(
          Uri.parse(
            "https://student.valuxapps.com/api/login",
          ),
          body: {'email': email, 'password': password});

      var ResponseData = jsonDecode(responce.body);

      if (responce.statusCode == 200) {
        if (ResponseData['status'] == true) {
          await CashNetwork.InsertToCash(
              value: ResponseData['data']['token'], key: 'token');
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
