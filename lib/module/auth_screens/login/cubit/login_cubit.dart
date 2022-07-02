import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/model/login/login_model.dart';
import 'package:shop_app/shared/network/end_point.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

import 'login_state.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitial());

  static LoginCubit get(BuildContext context) => BlocProvider.of(context);

  bool isPassword = false;

  void changeVisPass() {
    isPassword = !isPassword;
    emit(ChangePassState());
  }

  LoginModel? loginModel;

  void userLogin({
    required String email,
    required String password,
  }) {
    emit(LoginLoadingState());
    DioHelper.postData(
      url: loginURL,
      data: {
        'email': email,
        'password': password,
      },
    )
        .then(
          (value) {
            loginModel = LoginModel.fromJson(value.data);
            emit(LoginSuccessState(loginModel!));
          },
        )
        .catchError(
          (onError) {
            debugPrint(onError.toString());
            emit(LoginErrorState());
          },
        );
  }
}
