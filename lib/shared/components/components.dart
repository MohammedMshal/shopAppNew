import 'package:flutter/material.dart';
import 'package:shop_app/shared/style/theme.dart';

Widget defaultButton({
  required Function() onPressed,
  required String text,
  double height = 60.0,
  double radius = 24,
  bool isUpperText = true,
  bool isRadius = true,
  Color color = primaryColor,
  double width = double.infinity,
}) =>
    Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.all(
              isRadius ? Radius.circular(radius) : Radius.zero)),
      child: MaterialButton(
        onPressed: onPressed,
        child: Text(isUpperText ? text.toUpperCase() : text),
      ),
    );

Widget defaultTextFormField({
  required TextEditingController controller,
  required FormFieldValidator<String> validator,
  required String label,
  required IconData prefixIcon,
  bool isRadius = true,
  bool isPassword = false,
  double radius = 24.0,
  TextInputType textType = TextInputType.text,
  GestureTapCallback? onTap,
  ValueChanged<String>? onChanged,
  ValueChanged<String>? onSubmitted,
}) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: isRadius
          ? BorderRadius.all(Radius.circular(radius))
          : BorderRadius.zero,
    ),
    child: TextFormField(
      controller: controller,
      validator: validator,
      onTap: onTap,
      onChanged: onChanged,
      onFieldSubmitted: onSubmitted,
      obscureText: isPassword,
      keyboardType: textType,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
        prefixIcon: Icon(prefixIcon),
        suffixIcon: isPassword ? null : const Icon(Icons.visibility),
      ),
    ),
  );
}

Widget defaultTextButton({
  required GestureTapCallback onPressed,
  required String label,
  bool isUpperText = true,
  TextStyle? labelStyle,
}) {
  return TextButton(
    onPressed: onPressed,
    child: Text(
      isUpperText ? label.toUpperCase() : label,
      style: labelStyle,
    ),
  );
}
