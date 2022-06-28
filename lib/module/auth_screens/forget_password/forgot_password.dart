import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/module/auth_screens/forget_password/cubit/forgot_password_cubit.dart';
import 'package:shop_app/module/auth_screens/forget_password/cubit/forgot_password_state.dart';
import 'package:shop_app/shared/components/components.dart';

class ForgotPasswordScreen extends StatelessWidget {
  ForgotPasswordScreen({Key? key}) : super(key: key);

  final emailController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
  create: (context) => ForgotPasswordCubit(),
  child: BlocConsumer<ForgotPasswordCubit, ForgotPasswordStates>(
  listener: (context, state) {
    // TODO: implement listener
  },
  builder: (context, state) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildTextForgotPassword(context: context),
            const SizedBox(height: 80.0),
            _buildBodyText(context: context),
            const SizedBox(height: 15),
            _buildTextBox(context: context ),
            const SizedBox(height: 80),
            _buildButtonSend(),
          ],
        ),
      ),
    );
  },
),
);
  }

  Widget _buildTextForgotPassword({
    required BuildContext context,
  }) {
    return Text('Forgot password',
        style: Theme.of(context).textTheme.titleLarge);
  }

  Widget _buildBodyText({
    required BuildContext context,
  }) {
    return Text(
      'Please, enter your email address. You will receive a link to create a new password via email.',
      style: Theme.of(context).textTheme.bodySmall,
    );
  }

  Widget _buildTextBox({
  required BuildContext context,
}) {
    return Form(
      key: formKey,
      child: defaultTextFormField(
        controller: emailController,
        validator: (String? value) {
          if (value!.isEmpty) {
            return 'Not a valid email address';
          }
          return null;
        },
        label: 'Email',
        prefixIcon: Icons.email_outlined,
        suffixIco: ForgotPasswordCubit.get(context).iconClosed,
        onTapSuffix: () {
          emailController.text = '';
        },
        onChanged: (String value){
          ForgotPasswordCubit.get(context).changedClose(textEditingController: emailController);
        }
      ),
    );
  }

  Widget _buildButtonSend() {
    return defaultButton(
      onPressed: () {
        if (formKey.currentState!.validate()) {}
      },
      text: 'Send',
    );
  }
}
