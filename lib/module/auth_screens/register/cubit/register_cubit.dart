import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/model/register/register_model.dart';
import 'package:shop_app/module/auth_screens/register/cubit/regester_state.dart';
import 'package:shop_app/shared/network/end_point.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());

  static RegisterCubit get(BuildContext context) => BlocProvider.of(context);
  bool isPassword = false;

  void changeVisPass() {
    isPassword = !isPassword;
    emit(ChangePassRegisterState());
  }

  RegisterModel? registerModel;

  void registerUser({
    required String name,
    required String email,
    required String phone,
    required String password,
  }) {
    emit(RegisterLoadingState());
    DioHelper.postData(url: registerURL, data: {
      'name': name,
      'email': email,
      'password': password,
      'phone': phone,
    }).then((value) {
      registerModel = RegisterModel.fromJson(value.data);
      emit(RegisterSuccessState(registerModel));
    }).catchError((onError) {
      debugPrint(onError.toString());
      emit(RegisterErrorState());
    });
  }
}
