
import 'package:shop_app/model/register/register_model.dart';

abstract class RegisterState {}

class RegisterInitial extends RegisterState {}

class ChangePassRegisterState extends RegisterState {}

class RegisterLoadingState extends RegisterState {}
class RegisterSuccessState extends RegisterState {
  final RegisterModel? registerModel;

  RegisterSuccessState(this.registerModel);

}
class RegisterErrorState extends RegisterState {}
