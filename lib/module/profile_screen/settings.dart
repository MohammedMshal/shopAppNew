import 'package:flutter/material.dart';
import 'package:shop_app/layout/cubit/layout_cubit.dart';
import 'package:shop_app/shared/components/components.dart';

import '../../shared/style/theme.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          _buildDarkMode(context: context),
        ],
      ),
    );
  }
}

Widget _buildDarkMode({
  required BuildContext context,
}) {
  return Row(
    children: [
      const Icon(Icons.dark_mode),
      const SizedBox(width: 10),
      Text('DarkMode', style: Theme.of(context).textTheme.bodyMedium),
      const Spacer(),
      defaultSwitch(
        value: LayoutCubit.get(context).switchDarkMode,
        onChanged: (value) {
          LayoutCubit.get(context).changeDarkMode();
        },
      ),
    ],
  );
}
