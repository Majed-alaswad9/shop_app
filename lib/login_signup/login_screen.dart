import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:shop_app/cubit/app_cubit.dart';
import 'package:shop_app/login_signup//palette.dart';
import 'package:shop_app/shared/const.dart';
import 'package:shop_app/login_signup/cubit/login_register_cubit.dart';
import 'package:shop_app/login_signup/cubit/login_register_state.dart';
import 'package:shop_app/login_signup/register.dart';
import 'package:shop_app/NetWork/Local/cach_helper.dart';
import 'package:shop_app/shop_app/shop_layout_screen.dart';
import 'package:shop_app/shared/end_points.dart';

class LoginScreen extends StatelessWidget {
  var emailController = TextEditingController();
  var passController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  LoginScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginSignUpCubit, LogInSIgnUpState>(
      listener: (context, state) {
        if (state is LogInSuccessState) {
          if (state.logInModel.status!) {
            CachHelper.saveData(key: 'token', value: state.logInModel.data!.token)
                .then((value) {
              token=state.logInModel.data!.token;
            }).then((value) {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const ShopAppScreen()),
                        (route) => false);
            });
            showMsg(msg: state.logInModel.message, color: colorMsg.success);
          } else {
            showMsg(msg: state.logInModel.message, color: colorMsg.inCorrect);
          }
        }
      },
      builder: (context, state) {

        var cubit = LoginSignUpCubit.get(context);
        return Scaffold(
          appBar: AppBar(),
          body: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                       Text('LOGIN',
                          style: TextStyle(
                            color: AppCubit.get(context).isDark?Colors.white:Colors.black,
                            fontSize: 35
                          )),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text('Log In To brows our hot offers',
                          style: TextStyle(
                            fontSize: 17,
                            color: Palette.textColor1
                          )),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        validator: validateEmail,

                        decoration: InputDecoration(
                            // icon: Icons(Icons.alternate_email),
                            prefixIcon: const Icon(
                              Icons.alternate_email,
                            ),
                            hintText: 'Email',
                            hintStyle:Theme.of(context).textTheme.subtitle2,
                            border:const OutlineInputBorder() ,
                            enabledBorder:  const OutlineInputBorder(
                              borderSide: BorderSide(color: Palette.textColor1),
                              borderRadius: BorderRadius.all(Radius.circular(10.0)),
                            ),
                            focusedBorder:  const OutlineInputBorder(
                              borderSide: BorderSide(color: Palette.textColor1),
                              borderRadius: BorderRadius.all(Radius.circular(10.0)),
                            ),
                            contentPadding: const EdgeInsets.all(10)),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: passController,
                        keyboardType: TextInputType.visiblePassword,
                        validator: validatePass,
                        obscureText: cubit.isPassword,
                        decoration:  InputDecoration(
                          prefixIcon: const Icon(
                            Icons.lock,
                          ),
                          hintText: 'Password',
                          hintStyle: Theme.of(context).textTheme.subtitle2,
                          contentPadding: const EdgeInsets.all(10),
                          border:const OutlineInputBorder() ,
                          enabledBorder:  const OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          ),
                          focusedBorder:  const OutlineInputBorder(
                            borderSide: BorderSide(color: Palette.textColor1),
                            borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ConditionalBuilder(
                        condition: state is! LogInLoadState,
                        builder: (context) => Container(
                          width: double.infinity,
                          color: Colors.blue,
                          child: TextButton(
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                LoginSignUpCubit.get(context).userLogin(
                                    email: emailController.text,
                                    password: passController.text,);
                              }
                            },
                            child:  Text(
                              'LOGIN',
                              style:Theme.of(context).textTheme.bodyText1,
                            ),
                          ),
                        ),
                        fallback: (context) => const Center(
                          child: CircularProgressIndicator(
                            color: Colors.blue,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Don\'t have an account?',
                            style: TextStyle(fontSize: 15),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => RegisterScreen()),);
                            },
                            child: const Text(
                              'Register',
                              style: TextStyle(fontSize: 15),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  String? validateEmail(String? value) {
    if (value != null) {
      if (value.length > 5 && value.contains('@') && value.endsWith('.com')) {
        return null;
      }
      return 'Enter a Valid Email Address';
    }
  }

  String? validatePass(String? value) {
    if (value != null) {
      if (value.length >= 6) {
        return null;
      }
      return 'Password must be more than six characters';
    }
  }

  Widget buildShimmer() => Shimmer.fromColors(
        baseColor: Colors.grey[500]!,
        highlightColor: Colors.grey[300]!,
        child: Container(
          width: double.infinity,
          height: 40,
          color: Colors.grey,
        ),
      );
}
