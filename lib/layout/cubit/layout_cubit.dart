import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/layout_state.dart';
import 'package:shop_app/module/bag_screen/bag.dart';
import 'package:shop_app/module/favorite_screen/favorite.dart';
import 'package:shop_app/module/home_screen/home.dart';
import 'package:shop_app/module/profile_screen/settings.dart';
import 'package:shop_app/module/shop_screen/shop.dart';



class LayoutCubit extends Cubit<LayoutStates> {
  LayoutCubit() : super(LayoutInitial());

  static LayoutCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;
  List<Widget> changePage = [
    const HomeScreen(),
    const ShopScreen(),
    const BagScreen(),
    const FavoriteScreen(),
    const SettingsScreen(),
  ];
  List<String> changeTitle = [
    'Home',
    'Shop',
    'Bag',
    'Favorite',
    'Profile',
  ];

  void changeBottomNav(int index) {
    currentIndex = index;
    emit(ChangeBottomNavState());
  }


  bool switchDarkMode = true;

  void changeDarkMode() {
    switchDarkMode = !switchDarkMode;
    emit(ChangeThemeModeState());
  }
}