import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shop_app/layout/layout_screen.dart';
import 'package:shop_app/module/auth_screens/forget_password/forgot_password.dart';
import 'package:shop_app/module/auth_screens/login/cubit/login_cubit.dart';
import 'package:shop_app/module/auth_screens/login/cubit/login_state.dart';
import 'package:shop_app/shared/components/components.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    
    return BlocProvider(
  create: (context) => LoginCubit(),
  child: BlocConsumer<LoginCubit, LoginStates>(
  listener: (context, state) {
    // TODO: implement listener
  },
  builder: (context, state) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildLoginText(context),
                const SizedBox(height: 80.0),
                _buildTextBoxEmail(),
                const SizedBox(height: 10.0),
                _buildTextBoxPassword(context: context),
                const SizedBox(height: 15.0),
                _buildForgotYourPassword(context),
                const SizedBox(height: 20.0),
                _buildLoginButton(context: context),
                const SizedBox(height: 20.0),
                _buildTextLoginWith(context),
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

  Widget _buildLoginText(BuildContext context) {
    return Text(
      'Login',
      style: Theme.of(context).textTheme.titleLarge,
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

  Widget _buildTextBoxPassword(
  {
  required BuildContext context,
}
      ) {
    return defaultTextFormField(
      controller: passwordController,
      validator: (String? value) {
        if (value!.isEmpty) {
          return 'the password is empty';
        }
        return null;
      },
      onTapSuffix: (){
        LoginCubit.get(context).changeVisPass();
      },
      label: 'password',
      prefixIcon: Icons.lock_outlined,
      isPassword: LoginCubit.get(context).isPassword,
      suffixIco: LoginCubit.get(context).isPassword ? Icons.visibility_outlined: Icons.visibility_off_outlined,
    );
  }

  Widget _buildForgotYourPassword(BuildContext context) {
    return Row(
      children: [
        const Spacer(),
        defaultTextButton(
          onPressed: () {
            navigatorTo(context: context, widget:  ForgotPasswordScreen());
          },
          label: 'Forgot your password?',
          isUpperText: false,
          labelStyle: Theme.of(context).textTheme.bodySmall,
        ),
        const Icon(Icons.arrow_right_alt),
      ],
    );
  }

  Widget _buildLoginButton({
    required BuildContext context,
  }) {
    return defaultButton(
        onPressed: () {
          if(formKey.currentState!.validate()){
            navigatorRemoved(context: context, widget: const LayoutScreen());
          }
        },
        text: 'login');
  }

  Widget _buildTextLoginWith(BuildContext context) {
    return Center(
        child: Text(
      'Or login with social account',
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
