import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/NetWork/remote/dio_helper.dart';
import 'package:shop_app/login_signup/cubit/login_register_state.dart';
import 'package:shop_app/shared/models/login_model.dart';
import 'package:shop_app/shared/end_points.dart';

class LoginSignUpCubit extends Cubit<LogInSIgnUpState> {
  LoginSignUpCubit() : super(InitialLogInState());

  static LoginSignUpCubit get(context) => BlocProvider.of(context);

  LoginModuel? loginModel;

  bool isPassword = true;
  IconData suffix = Icons.visibility;
  bool isSignupScreen = false;

  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix = isPassword ? Icons.visibility : Icons.visibility_off;
    emit(ChangePasswordVisibilityState());
  }

  void changeIsSignUp() {
    isSignupScreen = true;
    emit(ChangeIsSignUpState());
  }

  void changeIsNotSignUp() {
    isSignupScreen = false;
    emit(ChangeIsSignUpState());
  }

  void userLogin({
    required String email,
    required String password,
  }) {
    emit(LogInLoadState());
    DioHelper.postData(url: login, token: token, data: {
      'email': email,
      'password': password,
    }).then((value) {
      loginModel = LoginModuel.fromJson(value.data);
      emit(LogInSuccessState(loginModel!));
    }).catchError((error) {
      emit(LogInErrorState(error.toString()));
    });
  }

  void userSignUp(
      {required String email,
      required String password,
      required String name,
      required String phone,
      dynamic image,
      BuildContext? context}) {
    emit(SignUpLoadState());
    DioHelper.postData(url: signUp, token: token, data: {
      'email': email,
      'password': password,
      'name': name,
      'phone': phone,
      'image': image
    }).then((value) {
      loginModel = LoginModuel.fromJson(value.data);
      emit(SignUpSuccessState(loginModel!));
    }).catchError((error) {
      print(error.toString());
      emit(SignUpErrorState(error.toString()));
    });
  }
}
