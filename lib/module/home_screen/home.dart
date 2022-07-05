import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_grid_list/responsive_grid_list.dart';
import 'package:shop_app/model/home/home_model.dart';
import 'package:shop_app/module/home_screen/cubit/home_cubit.dart';
import 'package:shop_app/module/home_screen/cubit/home_states.dart';
import 'package:shop_app/shared/style/theme.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
  create: (context) => HomeCubit()..homeData()..categoryData(),
  child: BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubitController = HomeCubit.get(context);
        return ConditionalBuilder(
        condition: cubitController.homeModel !=null && cubitController.categoryModel != null,
          builder: (context) =>  _buildHomePage(context: context,homeModel: cubitController.homeModel),
          fallback: (context) =>
              const Center(child: CircularProgressIndicator()),
        );
      },
    ),
);
  }

  Widget _buildHomePage({
    required BuildContext context,
    required HomeModel? homeModel,
  }) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildHomeBanner(context: context, homeModel: homeModel),
          _buildCategoryScroll(context: context),
          //_buildProducts(context: context),
        ],
      ),
    );
  }

  Widget _buildHomeBanner({
    required BuildContext context,
    required HomeModel? homeModel,
  }) {
    return CarouselSlider(
      items: homeModel!.data!.banners!.map(
        (e) {
          return Image(
            image: NetworkImage(
              e.image.toString(),
            ),
          );
        },
      ).toList(),
      options: CarouselOptions(
        height: 250.0,
        initialPage: 0,
        enableInfiniteScroll: true,
        reverse: false,
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 3),
        autoPlayAnimationDuration: const Duration(seconds: 1),
        autoPlayCurve: Curves.fastOutSlowIn,
        scrollDirection: Axis.horizontal,
        viewportFraction: 1.1,
      ),
    );
  }

  Widget _buildCategoryScroll({
    required BuildContext context,
  }) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: SizedBox(
        height: 100.0,
        child: ListView.separated(
          itemBuilder: (context, index) {
            return SizedBox(
              height: 100.0,
              width: 100.0,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Image(
                    image: NetworkImage(
                        '${HomeCubit.get(context).categoryModel!.data!.data![index].image}'),
                    height: 100.0,
                    width: 100.0,
                  ),
                  Container(
                    width: 100.0,
                    color: myGrey,
                    child: Text(
                      textAlign: TextAlign.center,
                      '${HomeCubit.get(context).categoryModel!.data!.data![index].name}',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  )
                ],
              ),
            );
          },
          separatorBuilder: (context, index) {
            return const SizedBox(
              height: 10.0,
              width: 10.0,
            );
          },
          itemCount: HomeCubit.get(context).categoryModel!.data!.data!.length,
          scrollDirection: Axis.horizontal,
        ),
      ),
    );
  }

  Widget _buildProducts({
    required BuildContext context,
  }) {
    return Expanded(
      child: ResponsiveGridList(
        minItemWidth: 2.0,
        children: List.generate(
            HomeCubit.get(context).homeModel!.data!.products!.length, (index) {
          return SizedBox(
            height: 100.0,
            width: 100.0,
            child: Stack(
              alignment: AlignmentDirectional.bottomCenter,
              children: [
                Image(
                  image: NetworkImage(
                      '${HomeCubit.get(context).homeModel!.data!.products![index].image}'),
                  height: 100,
                  width: 100.0,
                ),
              ],
            ),
          );
        }),
      ),
    );
  }

}
