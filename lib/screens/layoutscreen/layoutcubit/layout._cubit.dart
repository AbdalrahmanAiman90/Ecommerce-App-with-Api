import 'dart:convert';

import 'package:ecommerce_api/model/banner_model.dart';
import 'package:ecommerce_api/model/catigory_model.dart';
import 'package:ecommerce_api/model/product_model.dart';
import 'package:ecommerce_api/screens/cartscreen/cart_screen.dart';
import 'package:ecommerce_api/screens/catigoryscreen/category_screen.dart';
import 'package:ecommerce_api/screens/favoritscreen/favorit_screen.dart';
import 'package:ecommerce_api/screens/homescreen/home_screen.dart';
import 'package:ecommerce_api/screens/profilescreen/profile_screen.dart';
import 'package:ecommerce_api/shard/const.dart';
import 'package:ecommerce_api/screens/layoutscreen/layoutcubit/layout_state.dart';
import 'package:ecommerce_api/model/user_model.dart';
import 'package:ecommerce_api/shard/local_network.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class LayoutCubit extends Cubit<LayoutState> {
  LayoutCubit() : super(LayoutInitial());
  UserModel? usermodel;
  //Get User Date
  Future<void> GetUserDate() async {
    emit(LayoutLodinState());
    // do requst

    Response responce = await http.get(
        Uri.parse('https://student.valuxapps.com/api/profile'),
        headers: {'lang': 'eng', 'Authorization': token!});
    //do decode for requst

    var ResponseDate = jsonDecode(responce.body);
    //do logic
    if (ResponseDate['status'] == true) {
      usermodel = UserModel.fromjeson(data: ResponseDate['data']);
      print(ResponseDate);
      emit(LayoutSucsessState());
    } else {
      emit(LayoutFaluerState(ErrorMassege: ResponseDate['message']));
    }
  }

//change index
  int buttomindex = 0;
  List<Widget> LayoutScreen = [
    HomeScreen(),
    CatigoryScreen(),
    FavoritScreen(),
    CartScreen(),
    ProfileScreen(),
  ];
  void ChangeCutrentIndex({required int index}) {
    buttomindex = index;
    emit(ChangCurrentIndexState());
  }

//get banner
  List<BannerModel> bannerdata = [];
  GetBannerData() async {
    // do requst
    try {
      Response response = await http
          .get(Uri.parse("https://student.valuxapps.com/api/banners"));

      //decode data

      var ResponceData = jsonDecode(response.body);
      //logic
      if (response.statusCode == 200) {
        if (ResponceData['status'] == true) {
          for (var i in ResponceData['data']) {
            bannerdata.add(BannerModel.fromjeson(data: i));
          }
          emit(SucsessBannerState());
        } else {
          emit(FiulerBannerState());
        }
      }
    } on Exception catch (e) {
      print(e.toString());
    }
  }

//git catigory
  List<CatigoryModel> catigorydata = [];
  GetCatigoryData() async {
    // do requst
    try {
      Response response = await http.get(
          Uri.parse("https://student.valuxapps.com/api/categories"),
          headers: {'lang': 'en'});

      //decode data

      var ResponceData = jsonDecode(response.body);
      //logic
      if (response.statusCode == 200) {
        if (ResponceData['status'] == true) {
          for (var i in ResponceData['data']['data']) {
            catigorydata.add(CatigoryModel.fromjeson(data: i));
          }
          emit(SuccsessCatigoryState());
        } else {
          emit(FailuerCatigoryState());
        }
      }
    } on Exception catch (e) {
      print(e.toString());
    }
  }

//git prodict
  List<ProducrModel> productdata = [];
  GetProductData() async {
    try {
      Response response = await http.get(
          Uri.parse("https://student.valuxapps.com/api/home"),
          headers: {'lang': 'en'});

      //decode data

      var ResponceData = jsonDecode(response.body);
      //logic
      if (response.statusCode == 200) {
        if (ResponceData['status'] == true) {
          for (var i in ResponceData['data']['products']) {
            productdata.add(ProducrModel.fromjeson(data: i));
          }
          emit(SuccsessProductState());
        } else {
          emit(FailureProdectState());
        }
      }
    } on Exception catch (e) {
      print(e.toString());
    }
  }

//todo search
  List<ProducrModel> filterproductdata = [];
  void filterproduct({required String input}) {
    filterproductdata = productdata
        .where((element) =>
            element.name!.toLowerCase().startsWith(input.toLowerCase()))
        .toList();
  }

//favorit product
  List<ProducrModel> favorititeam = [];
  Set<String> FavId = {};
  Future<void> GetfavoritProduct() async {
    favorititeam.clear();
    try {
      Response response = await http.get(
          Uri.parse("https://student.valuxapps.com/api/favorites"),
          headers: {"lang": "en", "Authorization": token!});

      var responseData = jsonDecode(response.body);

      if (responseData['status'] == true) {
        for (var i in responseData['data']['data']) {
          favorititeam.add(ProducrModel.fromjeson(data: i['product']));
          FavId.add(i['product']['id'].toString());
        }
        print(favorititeam.length);
        emit(SuccsessFavState());
      } else {
        emit(FailureFavState());
      }
    } on Exception catch (e) {
      emit(FailureFavState());
    }
  }

//Add or remove iteam
  AddOrRemoveFavoritList({required String id}) async {
    emit(FavLodinState());

    try {
      Response response = await http.post(
          Uri.parse("https://student.valuxapps.com/api/favorites"),
          headers: {"lang": "en", "Authorization": token!},
          body: {"product_id": id});
      var ResponseData = jsonDecode(response.body);

      if (ResponseData['status'] == true) {
        if (!FavId.contains(id)) {
          FavId.add(id);
        } else {
          FavId.remove(id);
        }
        await GetfavoritProduct();

        emit(AddOrRemoveStateSucsses());
      } else {
        emit(FRaluerAddOrRemoveState());
      }
    } on Exception catch (e) {
      emit(FRaluerAddOrRemoveState());
    }
  }

//get carts
  List<ProducrModel> carts = [];
  Set<String> cartsId = {};
  int totalPrice = 0;
  Future<void> getcarts() async {
    carts.clear();

    Response response = await http.get(
        Uri.parse("https://student.valuxapps.com/api/carts"),
        headers: {"lang": "en", "Authorization": token!});

    var responseData = jsonDecode(response.body);

    if (responseData['status'] == true) {
      totalPrice = responseData['data']['total'].toInt();
      for (var i in responseData['data']['cart_items']) {
        cartsId.add(i['product']['id'].toString());
        carts.add(ProducrModel.fromjeson(data: i['product']));
      }
      print(carts.length);
      emit(SuccsessCartState());
    } else {
      emit(FailureCartState());
    }
  }

//add or remove carts
  AddOrRemoveCarts({required String id}) async {
    emit(CarttLodinState());

    Response response = await http.post(
        Uri.parse("https://student.valuxapps.com/api/carts"),
        headers: {"lang": "en", "Authorization": token!},
        body: {"product_id": id});
    var ResponseData = jsonDecode(response.body);

    if (ResponseData['status'] == true) {
      if (!cartsId.contains(id)) {
        cartsId.add(id);
      } else {
        cartsId.remove(id);
      }
      await getcarts();

      emit(AddToCartState());
    } else {
      emit(FailureAddtoCart());
    }
  }

//chang password
  Future<void> changePassword(
      {required String currentPassword, required String newPassword}) async {
    emit(ChangePasswordLoadingState());
    Response response = await http.post(
        Uri.parse("https://student.valuxapps.com/api/change-password"),
        headers: {
          'lang': 'en',
          'Authorization': token!
        },
        body: {
          'current_password': currentPassword,
          'new_password': newPassword
        });

    var ResponseData = jsonDecode(response.body);

    if (response.statusCode == 200) {
      if (ResponseData['status'] == true) {
        await CashNetwork.InsertToCash(key: 'password', value: newPassword);
        CurrentPassword = await CashNetwork.GetFromCash(key: "password");
        emit(ChangePasswordSucssesState());
      } else {
        emit(ChangePasswordFaluirState(error: ResponseData['message']));
      }
    } else {
      print("wroong in server");
    }
  }

//update user date
  Future<void> UpdateUserData(
      {required String name,
      required String phone,
      required String email}) async {
    emit(UpdateUserDataLodingState());
    Response response = await http.put(
        Uri.parse("https://student.valuxapps.com/api/update-profile"),
        headers: {'lang': 'en', 'Authorization': token!},
        body: {'name': name, 'email': email, 'phone': phone});

    var ResponseData = jsonDecode(response.body);

    if (response.statusCode == 200) {
      if (ResponseData['status']) {
        await GetUserDate();
        emit(UpdateUserDataSuccsessState());
      } else {
        emit(UpdateUserDataFalurState(error: ResponseData['message']));
      }
    } else {
      print("wrong");
    }
  }

//logout
  Future<void> logOut() async {
    emit(LogoutLodingState());
    Response response = await http.post(
      Uri.parse("https://student.valuxapps.com/api/logout"),
      headers: {'lang': 'en', 'Authorization': token!},
    );
    var ResponseData = jsonDecode(response.body);
    if (response.statusCode == 200) {
      if (ResponseData['status']) {
        await CashNetwork.DeletFromCach(key: 'token');
        await CashNetwork.DeletFromCach(key: 'password');
        await CashNetwork.DeletFromCach(key: 'theam');

        emit(LogoutSuccsessState());
      } else {
        emit(LogoutFaluerState(error: ResponseData['message']));
      }
    } else {
      print("wrong");
    }
  }

//change theam for appliction
  void ChangeTheam(TheamState state) {
    bool stuts;
    switch (state) {
      case TheamState.initial:
        if (CashNetwork.GetFromCash(key: 'theam') == "light") {
          stuts = false;
          emit(AppLightTheamState());
        } else {
          stuts = true;
          emit(AppDarkTheamState());
        }
        break;
      case TheamState.dark:
        CashNetwork.InsertToCash(key: "theam", value: "dark");
        stuts = false;

        emit(AppDarkTheamState());
        break;
      case TheamState.light:
        CashNetwork.InsertToCash(key: "theam", value: "light");
        stuts = true;

        emit(AppLightTheamState());
        break;
    }
    print(
        "============${CashNetwork.GetFromCash(key: 'theam')}================");
  }

  @override
  void onChange(Change<LayoutState> change) {
    // TODO: implement onChange
    super.onChange(change);
    print(change);
  }
}
