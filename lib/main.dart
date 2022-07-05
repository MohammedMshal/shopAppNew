import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/layout_state.dart';
import 'package:shop_app/layout/layout_screen.dart';
import 'package:shop_app/module/auth_screens/register/register.dart';
import 'package:shop_app/module/home_screen/cubit/home_cubit.dart';
import 'package:shop_app/module/on_boarding/cubit/onboarding_cubit.dart';
import 'package:shop_app/module/on_boarding/on_boarding.dart';
import 'package:shop_app/shared/constans.dart';
import 'package:shop_app/shared/network/locale/cache_helper.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';
import 'package:shop_app/shared/style/theme.dart';

import 'layout/cubit/layout_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  await CacheHelper.init();
  bool isDark = CacheHelper.getData(key: 'isDark') ?? true;
  token = CacheHelper.getData(key: 'token') ?? '';

  bool isBoarding = CacheHelper.getData(key: 'onBoarding') ?? false;

  Widget? widget;
  if(isBoarding) {
    if (token.isNotEmpty) {
    widget = const LayoutScreen();
  } else {
    widget = RegisterScreen();
  }
  }else{
    widget = ONBoardingScreen();
  }
  runApp(MyApp(
    isDark: isDark,
    startWidget: widget,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key, required this.isDark, required this.startWidget})
      : super(key: key);
  final bool isDark;
  final Widget startWidget;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) =>
                LayoutCubit()..changeDarkMode(formShared: isDark)),
        BlocProvider(
            create: (context) => HomeCubit()
              ..homeData()
              ..categoryData()),
        BlocProvider(create: (context) => OnBoardingCubit())
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
            home: startWidget,
          );
        },
      ),
    );
  }
}
