import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/model/home/home_model.dart';
import 'package:shop_app/module/home_screen/cubit/home_states.dart';
import 'package:shop_app/shared/constans.dart';
import 'package:shop_app/shared/network/end_point.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

import '../../../model/category/category_model.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(InitialState());

  static HomeCubit get(context) => BlocProvider.of(context);

  HomeModel? homeModel;
  Map<int, bool> inFavorite = {};

  void homeData() {
    emit(HomeLoadingState());
    //print('loading');
    DioHelper.getData(
      url: homeURL,
      token: token,
    ).then((value) {
      //print('success');
      homeModel = HomeModel.fromJson(value.data);
      emit(HomeSuccessState());
    }).catchError((onError){
      debugPrint(onError.toString());
      emit(HomeErrorState());
    });
  }

  CategoryModel? categoryModel;

  void categoryData(){
    emit(CategoryLoadingState());
    //print('cat loading');
    DioHelper.getData(url: categoryURL,).then((value){
      categoryModel = CategoryModel.fromJson(value.data);
      emit(CategorySuccessState());
     // print('succ cat');
    }).catchError((onError){
      debugPrint(onError.toString());
      emit(CategoryErrorState());
    });
  }
}
