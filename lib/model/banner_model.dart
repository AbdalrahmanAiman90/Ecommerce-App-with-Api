class BannerModel {
  int? id;
  String? url;

  BannerModel({required this.id, required this.url});

  //name con
  BannerModel.fromjeson({required Map<String, dynamic> data}) {
    id = data['id'];
    url = data['image'];
  }
}
