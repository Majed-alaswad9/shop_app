class CategoriesModel{
  bool? status;
  CategoriesDataModel? dataModel;

  CategoriesModel.fromjson(Map<String,dynamic> json){
    status=json['status'];
    dataModel=CategoriesDataModel.fromJSon(json['data']);
  }

}
class CategoriesDataModel{
  int? currentPage;
  List<DataModel> data=[];
  
  CategoriesDataModel.fromJSon(Map<String,dynamic> json){
    json['data'].forEach((element){
      data.add(DataModel.fromJson(element));
    });
  }
}
class DataModel{
  int? id;
  String? name;
  String? image;

  DataModel.fromJson(Map<String,dynamic> json){
    id=json['id'];
    name=json['name'];
    image=json['image'];
  }
}