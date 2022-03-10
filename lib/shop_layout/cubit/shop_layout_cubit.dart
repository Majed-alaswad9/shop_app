import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/NetWork/remote/dio_helper.dart';
import 'package:shop_app/shop_layout/shop_categories.dart';
import 'package:shop_app/shop_layout/shop_favourite.dart';
import 'package:shop_app/shop_layout/shop_home.dart';
import 'package:shop_app/shop_layout/shop_settings.dart';
import 'package:shop_app/shop_layout/cubit/shop_layout_state.dart';
import 'package:shop_app/shared/models/add_favoutite.dart';
import 'package:shop_app/shared/models/search_model.dart';
import 'package:shop_app/shared/models/categories_model.dart';
import 'package:shop_app/shared/models/home_model.dart';
import 'package:shop_app/shared/end_points.dart';
import 'package:shop_app/shared/models/favourite_model.dart';
import 'package:shop_app/shared/models/login_model.dart';

class ShopLayoutCubit extends Cubit<ShopLayoutstate> {
  ShopLayoutCubit() : super(LayoutInitState());

  static ShopLayoutCubit get(context) => BlocProvider.of(context);

  HomeModuel? homeModuel;
  CategoriesModel? categoriesModel;
  FavouriteModuel? favouriteChangeModel;
  Favourite? model;
  LoginModuel? user,user2;

  Map<int?, bool?> favouriteMap = {};
  List<String> bar = ['Home', 'Categories', 'Favourite', 'Settings'];
  List<Widget> bottomNavItem = [
    const HomeLayout(),
    const CategoriesLayout(),
    const FavoriteLayout(),
    SettingLayout(),
  ];
  int indexBottom = 0;

  void changeBottom(index) {
    indexBottom = index;
    emit(ChangeBottomState());
  }

  void getHomeData() {
    emit(ShopHomeLoadState());
    DioHelper.getData(url: home, token: token).then((value) {
      homeModuel = HomeModuel.fromJson(value.data);
      for (var element in homeModuel!.data!.product) {
        favouriteMap.addAll({element.id: element.inFavourite});
      }
      emit(ShopHomeSuccesState());
    }).catchError((error) {
      emit(ShopHomeErrorState(error.toString()));
    });
  }

  void getCategoriesData() {
    emit(ShopCategoriesLoadState());
    DioHelper.getData(url: categories, token: token).then((value) {
      categoriesModel = CategoriesModel.fromjson(value.data);
      emit(ShopCategoriesSuccesState());
    }).catchError((error) {
      emit(ShopCategoriesErrorState(error.toString()));
    });
  }

  void changeFavourite(int? product) {
    favouriteMap[product] = !favouriteMap[product]!;
    emit(ShopchangeSuccesState());
    DioHelper.postData(
            url: favourite, data: {'product_id': product}, token: token)
        .then((value) {
      favouriteChangeModel = FavouriteModuel.fromJson(value.data);
      if (!favouriteChangeModel!.status!) {
        favouriteMap[product] = !favouriteMap[product]!;
      } else {
        getFavourite();
      }
      emit(ShopChangeSuccessFavouriteState(favouriteChangeModel!));
    }).catchError((error) {
      favouriteMap[product] = !favouriteMap[product]!;
      emit(ShopChangeFavouriteErrorState(error.toString()));
    });
  }

  void getFavourite() {
    emit(ShopLoadingFavourtieSuccessesState());
    DioHelper.getData(url: favourite, token: token).then((value) {
      model = Favourite.fromJson(value.data);
      emit(ShopGetFavourtieSuccessesState());
    }).catchError((error) {
      emit(ShopGetFavouriteErrorState(error.toString()));
    });
  }

  void getProfile() {
    emit(ShopLoadingProfileState());
    DioHelper.getData(url: profile, token: token).then((value) {
      user = LoginModuel.fromJson(value.data);
      emit(ShopGetProfileSuccessesState(user));
    }).catchError((error) {
      emit(ShopGetProfileErrorState(error.toString()));
    });
  }

  void updateUserData(
      {required String email, required String name, required String phone}) {
    emit(ShopLoadingUpdateDataState());
    DioHelper.putData(
        url: update,
        token: token,
        data: {'email': email, 'name': name, 'phone': phone}).then((value) {
      user = LoginModuel.fromJson(value.data);
      emit(ShopUpdateDataSuccessesState(user));
    }).catchError((error) {
      emit(ShopUpdateDataErrorState(error.toString()));
    });
  }

  SearchModel? searchModel;

  void searchData({required String text}) {
    emit(SearchLoadingState());
    DioHelper.postData(url: search, data: {'text': text}).then((value) {
      searchModel = SearchModel.fromJson(value.data);
      emit(SearchSuccessState());
    }).catchError((error) {
      emit(SearchErrorState(error.toString()));
    });
  }

}
