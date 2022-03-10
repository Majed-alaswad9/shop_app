import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/NetWork/remote/dio_helper.dart';
import 'package:shop_app/shop_app/shop_layout_screen.dart';
import 'package:shop_app/shared/end_points.dart';
import 'package:shop_app/shop_app/on_board.dart';
import 'package:shop_app/NetWork/Local/cach_helper.dart';
import 'login_signup/login_screen.dart';
import 'cubit/app_cubit.dart';
import 'cubit/app_state.dart';
import 'cubit/blockProvider.dart';
import 'login_signup/cubit/login_register_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CachHelper.init();
  Widget statetWidget;
  dynamic onBoarding = CachHelper.getData(key: 'onBoarding');
  token = CachHelper.getData(key: 'token');
  bool? isDark = CachHelper.getData(key: 'isDark')??false;
  if (onBoarding != null) {
    if (token != null) {
      statetWidget = const ShopAppScreen();
    } else {
      statetWidget =  LoginScreen();
    }
  } else {
      statetWidget = const OnBoarding();
    }
  runApp(MyApp(statetWidget, isDark!));
}

class MyApp extends StatelessWidget {
  final Widget _widget;
  final bool isDark;

  // ignore: use_key_in_widget_constructors
  const MyApp(this._widget, this.isDark);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (BuildContext context) =>
                  AppCubit()..changeTheme(fromShared: isDark)),
          BlocProvider(create: (BuildContext context) => LoginSignUpCubit()),
        ],
        child: BlocConsumer<AppCubit, AppState>(
          listener: (context, state) {},
          builder: (context, state) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Flutter Demo',
              theme: ThemeData(
                appBarTheme: const AppBarTheme(
                    titleTextStyle: TextStyle(
                        color: Colors.blue,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                    backgroundColor: Colors.white,
                    elevation: 0.0,
                    iconTheme: IconThemeData(color: Colors.blue),
                    systemOverlayStyle: SystemUiOverlayStyle(
                        statusBarColor: Colors.white,
                        statusBarIconBrightness: Brightness.dark)),
                primarySwatch: Colors.blue,
                textTheme: const TextTheme(
                    bodyText1: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 20),
                    bodyText2: TextStyle(fontSize: 15, color: Colors.black),
                    subtitle1: TextStyle(
                      color: Colors.black,
                      fontSize: 35,
                    ),
                    subtitle2: TextStyle(
                        color: Colors.black,fontSize: 15
                    )
                ),
                bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                    type: BottomNavigationBarType.fixed,
                    backgroundColor: Colors.white,
                    elevation: 10,
                    selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold)),
              ),
              darkTheme: ThemeData(
                scaffoldBackgroundColor: Colors.grey[700],
                floatingActionButtonTheme: const FloatingActionButtonThemeData(
                    backgroundColor: Colors.black),
                appBarTheme: const AppBarTheme(
                  titleTextStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                  iconTheme: IconThemeData(color: Colors.white),
                  systemOverlayStyle: SystemUiOverlayStyle(
                      statusBarColor: Colors.black45,
                      statusBarIconBrightness: Brightness.light),
                  backgroundColor: Colors.black45,
                ),
                bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                  type: BottomNavigationBarType.fixed,
                  elevation: 10,
                  backgroundColor: Colors.black45,
                ),
                cardColor: Colors.black45,
                textTheme: const TextTheme(
                    bodyText1: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                    bodyText2: TextStyle(fontSize: 15, color: Colors.white),
                  subtitle1: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                  subtitle2: TextStyle(
                    color: Colors.grey,fontSize: 20
                  )
                ),

              ),
              themeMode: AppCubit.get(context).isDark
                  ? ThemeMode.dark
                  : ThemeMode.light,
              home: _widget,
            );
          },
        ));
  }
}
