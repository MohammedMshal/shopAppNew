import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/module/auth_screens/register/register.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/network/locale/cache_helper.dart';

import '../../../model/on_boarding/on_boarding.dart';
import 'onboarding_states.dart';

class OnBoardingCubit extends Cubit<OnBoardingStates> {
  OnBoardingCubit() : super(OnBoardingInitialState());

  static OnBoardingCubit get(context) => BlocProvider.of(context);

  bool isLast = false;

  void isChangeLastPage({
    required int value,
    required List<OnBoardingModel> model,
  }) {
    if (value == model.length - 1) {
      isLast = true;
      emit(OnBoardingGoToLoginScreenState());
      debugPrint(isLast.toString());
    } else {
      isLast = false;
      emit(OnBoardingGoToLoginScreenState());
      debugPrint(isLast.toString());
    }
  }

  void saveSubmit({
    required BuildContext context,
  }) {
    CacheHelper.putData(key: 'onBoarding', value: true).then((value){
      if(value){
        navigatorRemoved(context: context, widget: RegisterScreen());
      }
    } );
  }
}
