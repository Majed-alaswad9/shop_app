class Favourite{
  bool? status;
  Data? dataFavourite;
  
  Favourite.fromJson(Map<String,dynamic>json){
    status=json['status'];
    dataFavourite=Data.fromJson(json['data']);
  }
}

class Data{
  int? currentPage;
  List<FavouriteModel>? data=[];

  Data.fromJson(Map<String,dynamic>json){
    currentPage=json['current_page'];
    json['data'].forEach((e){data!.add(FavouriteModel.fromJson(e));});
  }
}

class FavouriteModel{
  int? id;
  Product? dataProduct;

  FavouriteModel.fromJson(Map<String,dynamic> json){
    id=json['id'];
    dataProduct=Product.fromJson(json['product']);
  }
}

class Product{
  int? id;
  dynamic price;
  dynamic oldPrice;
  int? discount;
  String? image;
  String? name;
  String? description;

  Product.fromJson(Map<String,dynamic>json){
    id=json['id'];
    price=json['price'];
    oldPrice=json['old_price'];
    discount=json['discount'];
    image=json['image'];
    name=json['name'];
    description=json['description'];
  }
}