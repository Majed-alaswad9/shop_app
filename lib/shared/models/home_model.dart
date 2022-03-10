class HomeModuel{
  bool? status;
  String? message;
  ShopData? data;
  HomeModuel.fromJson(Map<String,dynamic> json){
    status=json['status'];
    message=json['message'];
    data=ShopData.fromJson(json['data']);
  }
}

class ShopData{
  List<Banners> banners=[];
  List<Products> product=[];

  ShopData.fromJson(Map<String,dynamic> json){
    json['banners'].forEach((element){
      banners.add(Banners.fromJson(element));
    });
    json['products'].forEach((element){
      product.add(Products.fromJson(element));
    });
  }
}

class Banners{
  int? id;
  String? image;

  Banners.fromJson(Map<String,dynamic> json){
    id=json['id'];
    image=json['image'];
  }
}

class Products{
  int? id;
  dynamic price;
  dynamic oldPrice;
  dynamic discount;
  String? image;
  String? name;
  bool? inFavourite;
  bool? inCart;

  Products.fromJson(Map<String,dynamic> json){
    id=json['id'];
    price=json['price'];
    oldPrice=json['old_price'];
    discount=json['discount'];
    image=json['image'];
    name=json['name'];
    inFavourite=json['in_favorites'];
    inCart=json['in_cart'];
  }
}