import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shop_layout/search_screen.dart';
import 'package:shop_app/shop_layout/cubit/shop_layout_cubit.dart';
import 'package:shop_app/shop_layout/cubit/shop_layout_state.dart';
import 'package:shop_app/cubit/app_cubit.dart';

class ShopAppScreen extends StatelessWidget {
  const ShopAppScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopLayoutCubit()
        ..getHomeData()
        ..getCategoriesData()
        ..getFavourite()
        ..getProfile(),
      child: BlocConsumer<ShopLayoutCubit, ShopLayoutstate>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = ShopLayoutCubit.get(context);
          return Scaffold(
              appBar: AppBar(
                title: Text(
                  cubit.bar[cubit.indexBottom],
                ),
                actions: [
                  if (cubit.indexBottom == 0)
                    IconButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SearchScreen()));
                        },
                        icon: const Icon(Icons.search)),
                  IconButton(
                      onPressed: () {
                        AppCubit.get(context).changeTheme();
                      },
                      icon: const Icon(
                        Icons.brightness_medium,
                      )),
                  const SizedBox(
                    width: 10,
                  ),
                ],
              ),
              body: cubit.bottomNavItem[cubit.indexBottom],
              bottomNavigationBar: BottomNavigationBar(
                onTap: (index) {
                  cubit.changeBottom(index);
                },
                currentIndex: cubit.indexBottom,
                selectedItemColor: Colors.blue,
                unselectedItemColor: Colors.grey,
                items: const [
                  BottomNavigationBarItem(
                      icon: Icon(Icons.home), label: 'home'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.apps), label: 'Categories'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.favorite), label: 'favourite'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.settings), label: 'setting'),
                ],
              ));
        },
      ),
    );
  }
}
