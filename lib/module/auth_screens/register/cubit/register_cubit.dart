import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/module/auth_screens/register/cubit/regester_state.dart';


class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());
  static RegisterCubit get(BuildContext context) => BlocProvider.of(context);
  bool isPassword = false;
  void changeVisPass(){
    isPassword = !isPassword;
    emit(ChangePassRegisterState());
  }
}
