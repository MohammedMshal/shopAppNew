import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/layout_state.dart';
import 'package:shop_app/layout/layout_screen.dart';
import 'package:shop_app/module/auth_screens/register/register.dart';
import 'package:shop_app/shared/network/locale/cache_helper.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';
import 'package:shop_app/shared/style/theme.dart';

import 'layout/cubit/layout_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  await CacheHelper.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => LayoutCubit()),
      ],
      child: BlocConsumer<LayoutCubit, LayoutStates>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          LayoutCubit cubit = LayoutCubit.get(context);
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: cubit.switchDarkMode ? ThemeMode.light : ThemeMode.dark,
            home: const LayoutScreen(),
          );
        },
      ),
    );
  }
}
