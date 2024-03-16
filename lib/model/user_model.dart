class UserModel {
  String? name;

  String? email;
  String? phone;
  String? token;
  String? image;
//constructor
  UserModel({this.email, this.image, this.name, this.phone, this.token});
//named constructor

  UserModel.fromjeson({required Map<String, dynamic> data}) {
    name = data['name'];
    phone = data['phone'];
    email = data['email'];
    token = data['token'];
    image = data['image'];
  }
  //to map
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'emial': email,
      'phone': phone,
      'image': image,
      'token': token,
    };
  }
}
