import 'package:shop_app/shared/models/add_favoutite.dart';
import 'package:shop_app/shared/models/login_model.dart';

abstract class ShopLayoutstate{}

class LayoutInitState extends ShopLayoutstate{}

class ChangeBottomState extends ShopLayoutstate{}

class ShopHomeLoadState extends ShopLayoutstate{}

class ShopHomeSuccesState extends ShopLayoutstate{}

class ShopHomeErrorState extends ShopLayoutstate{
  final String error;

  ShopHomeErrorState(this.error);
}

class ShopCategoriesLoadState extends ShopLayoutstate{}

class ShopCategoriesSuccesState extends ShopLayoutstate{}

class ShopCategoriesErrorState extends ShopLayoutstate{
  final String error;

  ShopCategoriesErrorState(this.error);
}

class ShopchangeSuccesState extends ShopLayoutstate{}

class ShopChangeSuccessFavouriteState extends ShopLayoutstate{
  final FavouriteModuel model;

  ShopChangeSuccessFavouriteState(this.model);

}

class ShopChangeFavouriteErrorState extends ShopLayoutstate{
  final String error;

  ShopChangeFavouriteErrorState(this.error);
}

class ShopGetFavourtieSuccessesState extends ShopLayoutstate{}

class ShopLoadingFavourtieSuccessesState extends ShopLayoutstate{}

class ShopGetFavouriteErrorState extends ShopLayoutstate{
  final String error;

  ShopGetFavouriteErrorState(this.error);
}

class ShopGetProfileSuccessesState extends ShopLayoutstate{
  final LoginModuel? profile;

  ShopGetProfileSuccessesState(this.profile);
}

class ShopLoadingProfileState extends ShopLayoutstate{}

class ShopGetProfileErrorState extends ShopLayoutstate{
  final String error;

  ShopGetProfileErrorState(this.error);

}

class ShopUpdateDataSuccessesState extends ShopLayoutstate{
  final LoginModuel? update;

  ShopUpdateDataSuccessesState(this.update);

}

class ShopLoadingUpdateDataState extends ShopLayoutstate{}

class ShopUpdateDataErrorState extends ShopLayoutstate{
  final String error;

  ShopUpdateDataErrorState(this.error);
}

class SearchLoadingState extends ShopLayoutstate{}

class SearchSuccessState extends ShopLayoutstate{}

class SearchErrorState extends ShopLayoutstate{
  final String error;

  SearchErrorState(this.error);
}




