class FavouriteModuel{
  bool? status;
  String? message;
  
  FavouriteModuel.fromJson(Map<String,dynamic> json){
    status=json['status'];
    message=json['message'];
  }
}

