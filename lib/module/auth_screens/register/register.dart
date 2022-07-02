import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shop_app/layout/layout_screen.dart';
import 'package:shop_app/module/auth_screens/login/login.dart';
import 'package:shop_app/module/auth_screens/register/cubit/regester_state.dart';
import 'package:shop_app/module/auth_screens/register/cubit/register_cubit.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/constans.dart';
import 'package:shop_app/shared/network/locale/cache_helper.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({Key? key}) : super(key: key);

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final phoneController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterState>(
        listener: (context, state) {
          if (state is RegisterSuccessState) {
            if (state.registerModel!.status!) {
              CacheHelper.putData(
                key: 'token',
                value: state.registerModel!.data!.token,
              ).then((value) {
                token = state.registerModel!.data!.token!;
                navigatorRemoved(
                    context: context, widget: const LayoutScreen());
              });
            }
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Padding(
              padding: const EdgeInsets.all(10.0),
              child: SingleChildScrollView(
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildRegisterText(context),
                      const SizedBox(height: 80.0),
                      _buildTextBoxName(),
                      const SizedBox(height: 10.0),
                      _buildTextBoxEmail(),
                      const SizedBox(height: 10.0),
                      _buildTextBoxPassword(context: context),
                      const SizedBox(height: 10.0),
                      _buildTextBoxPhone(),
                      const SizedBox(height: 15.0),
                      _buildForgotYourPassword(context),
                      _buildRegisterButton(registerState: state),
                      const SizedBox(height: 20.0),
                      _buildTextRegisterWith(context),
                      const SizedBox(height: 15.0),
                      _buildSignWith(),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildRegisterText(BuildContext context) {
    return Text(
      'Sign up',
      style: Theme.of(context).textTheme.titleLarge,
    );
  }

  Widget _buildTextBoxName() {
    return defaultTextFormField(
      controller: nameController,
      validator: (String? value) {
        if (value!.isEmpty) {
          return 'the name is empty';
        }
        return null;
      },
      label: 'Name',
      prefixIcon: Icons.email_outlined,
    );
  }

  Widget _buildTextBoxEmail() {
    return defaultTextFormField(
      controller: emailController,
      validator: (String? value) {
        if (value!.isEmpty) {
          return 'the email is empty';
        }
        return null;
      },
      label: 'Email',
      prefixIcon: Icons.email_outlined,
    );
  }

  Widget _buildTextBoxPhone() {
    return defaultTextFormField(
      controller: phoneController,
      validator: (String? value) {
        if (value!.isEmpty) {
          return 'the phone is empty';
        }
        return null;
      },
      label: 'phone',
      prefixIcon: Icons.lock_outline,
    );
  }

  Widget _buildTextBoxPassword({
    required BuildContext context,
  }) {
    return defaultTextFormField(
      controller: passwordController,
      validator: (String? value) {
        if (value!.isEmpty) {
          return 'the password is empty';
        }
        return null;
      },
      onTapSuffix: () {
        RegisterCubit.get(context).changeVisPass();
      },
      label: 'password',
      prefixIcon: Icons.lock_outlined,
      isPassword: RegisterCubit.get(context).isPassword,
      suffixIco: RegisterCubit.get(context).isPassword
          ? Icons.visibility_outlined
          : Icons.visibility_off_outlined,
    );
  }

  Widget _buildForgotYourPassword(BuildContext context) {
    return Row(
      children: [
        const Spacer(),
        defaultTextButton(
          onPressed: () {
            navigatorTo(context: context, widget: LoginScreen());
          },
          label: 'Already have an account?',
          isUpperText: false,
          labelStyle: Theme.of(context).textTheme.bodySmall,
        ),
        const Icon(Icons.arrow_right_alt),
      ],
    );
  }

  Widget _buildRegisterButton({
    required RegisterState registerState,
  }) {
    return ConditionalBuilder(
      condition: registerState is! RegisterLoadingState,
      builder: (context) => defaultButton(
          onPressed: () {
            if (formKey.currentState!.validate()) {
              RegisterCubit.get(context).registerUser(
                name: nameController.text,
                email: emailController.text,
                phone: phoneController.text,
                password: passwordController.text,
              );
            }
          },
          text: 'Sign up'),
      fallback: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget _buildTextRegisterWith(BuildContext context) {
    return Center(
        child: Text(
      'Or sign up with social account',
      style: Theme.of(context).textTheme.bodySmall,
    ));
  }

  Widget _buildSignWith() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        defaultAuthSign(icon: FontAwesomeIcons.google, size: 30, onTap: () {}),
        const SizedBox(width: 20.0),
        defaultAuthSign(
            icon: FontAwesomeIcons.facebook, size: 30, onTap: () {}),
      ],
    );
  }
}
