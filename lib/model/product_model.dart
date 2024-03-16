class ProducrModel {
  int? id;
  int? price;
  int? oldprice;
  String? image;
  String? name;
  String? desc;

  ProducrModel.fromjeson({required Map<String, dynamic> data}) {
    id = data['id'].toInt();
    price = data['price'].toInt();
    oldprice = data['old_price'].toInt();
    image = data['image'];
    name = data['name'];
    desc = data['description'];
  }
}
