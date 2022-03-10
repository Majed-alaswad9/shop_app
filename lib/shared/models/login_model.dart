class LoginModuel {
  String? message;
  bool? status;
  UserLogin? data ;

  LoginModuel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    data = json['data'] == null ? null : UserLogin.fromjeson(json['data']);
  }
}

class UserLogin {
  int? id;
  String? name;
  String? token;
  String? email;
  String? phone;
  String? image;
  int? point;
  int? credit;

  UserLogin.fromjeson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    name = json['name'];
    phone = json['phone'];
    image = json['image'];
    credit = json['credit'];
    token = json['token'];
    point = json['point'];
  }
}
