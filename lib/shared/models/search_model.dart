class SearchModel{
  bool? status;
  Data? data;

  SearchModel.fromJson(Map<String,dynamic>json){
    status=json['status'];
    data=Data.fromJson(json['data']);
  }
}

class Data{
  int? currentPage;
  List<SearchProduct>? data=[];

  Data.fromJson(Map<String,dynamic>json){
    currentPage=json['current_page'];
    json['data'].forEach((e){data!.add(SearchProduct.fromJson(e));});
  }
}


class SearchProduct{
  int? id;
  dynamic price;
  int? discount;
  String? image;
  String? name;
  String? description;

  SearchProduct.fromJson(Map<String,dynamic>json){
    id=json['id'];
    price=json['price'];
    discount=json['discount'];
    image=json['image'];
    name=json['name'];
    description=json['description'];
  }
}