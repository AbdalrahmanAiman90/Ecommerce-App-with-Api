class CatigoryModel {
  int? id;
  String? url;
  String? name;
  CatigoryModel.fromjeson({required Map<String, dynamic> data}) {
    id = data['id'];
    name = data['name'];
    url = data['image'];
  }
}
