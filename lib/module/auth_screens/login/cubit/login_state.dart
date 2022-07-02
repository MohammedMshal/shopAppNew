
import 'package:shop_app/model/login/login_model.dart';

abstract class LoginStates {}

class LoginInitial extends LoginStates {}

class ChangePassState extends LoginStates {}


class LoginLoadingState extends LoginStates {}
class LoginSuccessState extends LoginStates {
  final LoginModel loginModel;
  LoginSuccessState(this.loginModel);
}
class LoginErrorState extends LoginStates {}

