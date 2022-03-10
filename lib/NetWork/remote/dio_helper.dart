import 'package:dio/dio.dart';

class DioHelper {
  static Dio dio = Dio();

  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://student.valuxapps.com/api/',
        receiveDataWhenStatusError: true,
      ),
    );
  }

  static Future<Response> postData(
      {required String url,
      required Map<String, dynamic> data,
      String? token,
      String? lang = 'en'}) async {
    dio.options.headers = {
      'Content-Type': 'application/json',
      'lang': lang,
      'Authorization': token
    };
    return await dio.post(url, data: data);
  }

  static Future<Response> getData(
      {required String url,
      Map<String, dynamic>? query,
      String? token,
      String lang = 'en'}) async {
    dio.options.headers = {
      'Content-Type': 'application/json',
      'lang': lang,
      'Authorization': token
    };
    return await dio.get(url, queryParameters: query);
  }

  static Future<Response> putData(
      {required String url,
     required Map<String, dynamic> data,
        Map<String,dynamic>? query,
      String? token,
      String lang = 'en'}) async{
    dio.options.headers={
      'Content-Type': 'application/json',
      'lang': lang,
      'Authorization': token
    };
    return await dio.put(url,data: data,queryParameters:query );
  }
  static Future<Response> deleteData(
      {required String url,
        Map<String, dynamic>? data,
        Map<String,dynamic>? query,
        String? token,
        String lang = 'en'}) async{
    dio.options.headers={
      'Content-Type': 'application/json',
      'lang': lang,
      'Authorization': token
    };
    return await dio.delete(url,data: data,queryParameters:query );
  }
}
