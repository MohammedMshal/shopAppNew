

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'forgot_password_state.dart';

class ForgotPasswordCubit extends Cubit<ForgotPasswordStates> {
  ForgotPasswordCubit() : super(ForgotPasswordInitialState());
  static ForgotPasswordCubit get(BuildContext context) => BlocProvider.of(context);

  IconData? iconClosed;
  void changedClose({
  required TextEditingController textEditingController,
}){
    if(textEditingController.text == ''){
      iconClosed = null;
       emit(ChangeShowCloseState());
    }else{
      emit(ChangeShowCloseState());
       iconClosed = Icons.close;
    }
    //1

  }


}
