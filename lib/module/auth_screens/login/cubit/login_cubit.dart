import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'login_state.dart';


class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitial());
  static LoginCubit get(BuildContext context) => BlocProvider.of(context);

  bool isPassword = false;
  void changeVisPass(){
    isPassword = !isPassword;
    emit(ChangePassState());
  }


}
