
import 'package:shop_app/shared/models/login_model.dart';

abstract class LogInSIgnUpState{}

class InitialLogInState extends LogInSIgnUpState{}

class LogInSuccessState extends LogInSIgnUpState{
  final LoginModuel logInModel;

  LogInSuccessState(this.logInModel);
}
class SaveTokenState extends LogInSIgnUpState{

}
class LogInLoadState extends LogInSIgnUpState{}

class LogInErrorState extends LogInSIgnUpState{
  final String error;

  LogInErrorState(this.error);
}

class ChangePasswordVisibilityState extends LogInSIgnUpState{}

class ChangeIsSignUpState extends LogInSIgnUpState{}

class SignUpSuccessState extends LogInSIgnUpState{
  final LoginModuel userSign;

  SignUpSuccessState(this.userSign);
}

class SignUpLoadState extends LogInSIgnUpState{}

class SignUpErrorState extends LogInSIgnUpState{
  final String error;

  SignUpErrorState(this.error);
}

class PickImageSuccessState extends LogInSIgnUpState{}
class PickImageErrorState extends LogInSIgnUpState{}