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
  GestureTapCallback? onTapSuffix,
  IconData? suffixIco,
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
          suffixIcon: IconButton(
            onPressed: onTapSuffix,
            icon: Icon(suffixIco),
          )),
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

Widget defaultAuthSign({
  bool isRadius = true,
  double height = 64.0,
  double width = 92.0,
  double radius = 20.0,
  double? size,
  Color color = Colors.blue,
  required IconData icon,
  required GestureTapCallback? onTap,
}) {
  return InkWell(
    onTap: onTap,
    child: Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: myWight,
        borderRadius: BorderRadius.all(
          isRadius ? Radius.circular(radius) : Radius.zero,
        ),
      ),
      child: Center(
        child: Icon(
          icon,
          color: color,
          size: size,
        ),
      ),
    ),
  );
}

Widget defaultSwitch({
  required bool value,
  required ValueChanged<bool> onChanged,
  Color activeColor = primaryColor,
  bool isRadius = true,
  double radius = 20.0
}) {
  return Switch(
    value: value,
    onChanged: onChanged,
    activeColor: activeColor,
    splashRadius: 80 ,
  );
}

void navigatorTo({
  required BuildContext context,
  required Widget widget,
}) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => widget),
  );
}

void navigatorRemoved({
  required BuildContext context,
  required Widget widget,
}) {
  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder: (context) => widget),
    (route) => false,
  );
}
