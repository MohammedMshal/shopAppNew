import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/layout_cubit.dart';
import 'package:shop_app/layout/cubit/layout_state.dart';

class LayoutScreen extends StatelessWidget {
  const LayoutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LayoutCubit, LayoutStates>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        LayoutCubit cubit = LayoutCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(cubit.changeTitle[cubit.currentIndex],style: Theme.of(context).textTheme.titleMedium,),
            centerTitle: true,
            leading:  IconButton(icon: const Icon(Icons.arrow_back_ios_new_outlined),onPressed: (){}),
          ),
          body: cubit.changePage[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            items: bottomNavigationBar(),
            currentIndex: cubit.currentIndex,
            onTap: (int index) {
              cubit.changePage[index];
              cubit.changeBottomNav(index);
            },
          ),
        );
      },
    );
  }

  List<BottomNavigationBarItem> bottomNavigationBar() {
    return const[
      BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: 'Home'),
      BottomNavigationBarItem(icon: Icon(Icons.shop_outlined), label: 'Shop'),
      BottomNavigationBarItem(
          icon: Icon(Icons.shopping_bag_outlined), label: 'Bag'),
      BottomNavigationBarItem(
          icon: Icon(Icons.favorite_outline), label: 'Favorite'),
      BottomNavigationBarItem(
          icon: Icon(Icons.person_outline), label: 'Profile'),
    ];
  }

}
