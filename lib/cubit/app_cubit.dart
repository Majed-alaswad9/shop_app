import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/NetWork/Local/cach_helper.dart';
import 'package:shop_app/cubit/app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(InitAppState());

  static AppCubit get(context) => BlocProvider.of(context);

  bool isDark = false;

  void changeTheme({bool? fromShared}) {
    if (fromShared != null) {
      isDark = fromShared;
    } else {
      CachHelper.saveData(key: 'isDark', value: isDark).then((value) {
        emit(AppChangeThemeStates());
      });
    }
    isDark = !isDark;
  }
}
