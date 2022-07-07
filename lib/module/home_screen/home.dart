import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/model/home/home_model.dart';
import 'package:shop_app/module/home_screen/cubit/home_cubit.dart';
import 'package:shop_app/module/home_screen/cubit/home_states.dart';
import 'package:shop_app/shared/style/theme.dart';

import '../../model/category/category_model.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit()
        ..homeData()
        ..categoryData(),
      child: BlocConsumer<HomeCubit, HomeStates>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          HomeCubit cubitController = HomeCubit.get(context);
          return ConditionalBuilder(
            condition: cubitController.homeModel != null &&
                cubitController.categoryModel != null,
            builder: (context) => _buildHomePage(
              homeModel: cubitController.homeModel,
              categoryModel: cubitController.categoryModel,
              context: context,
            ),
            fallback: (context) =>
                const Center(child: CircularProgressIndicator()),
          );
        },
      ),
    );
  }

  Widget _buildHomePage({
    required HomeModel? homeModel,
    required BuildContext context,
    required CategoryModel? categoryModel,
  }) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildBannersPage(homeModel: homeModel),
          const SizedBox(height: 10.0),
          _buildCategory(context: context, categoryModel: categoryModel),
          _buildProductGridView(
            cubit: HomeCubit.get(context),
            context: context,
          )
        ],
      ),
    );
  }
}

Widget _buildBannersPage({
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

Widget _buildCategory({
  required BuildContext context,
  required CategoryModel? categoryModel,
}) {
  return Padding(
    padding: const EdgeInsets.all(10.0),
    child: Column(
      children: [
        Text('Category', style: Theme.of(context).textTheme.bodyMedium),
        const SizedBox(height: 10.0),
        SizedBox(
          height: 100.0,
          child: ListView.separated(
            itemBuilder: (context, index) {
              return _buildCategoryItem(
                  categoryModel: categoryModel!.data!.data![index]);
            },
            separatorBuilder: (context, index) =>
                const SizedBox(height: 10.0, width: 10.0),
            itemCount: categoryModel!.data!.data!.length,
            scrollDirection: Axis.horizontal,
          ),
        ),
      ],
    ),
  );
}

Widget _buildCategoryItem({
  required CategoryList? categoryModel,
}) {
  return SizedBox(
    height: 100.0,
    width: 100.0,
    child: Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        Image(
          image: NetworkImage('${categoryModel!.image}'),
          height: 100.0,
          width: 100.0,
        ),
        Container(
          width: 100,
          color: myGrey,
          child: Text(
            '${categoryModel.name}',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.white),
          ),
        )
      ],
    ),
  );
}

Widget _buildProductGridView({
  required HomeCubit cubit,
  required BuildContext context,
}) {
  return Container(
    color: myGrey,
    child: GridView.count(
      crossAxisCount: 2,
      crossAxisSpacing: 2,
      childAspectRatio: 1 / 1.75,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: List.generate(
        cubit.homeModel!.data!.products!.length,
        (index) => _buildGridViewProductItem(
          model: cubit.homeModel!.data!.products![index],
          context: context,
        ),
      ),
    ),
  );
}

Widget _buildGridViewProductItem({
  required Products model,
  required BuildContext context,
}) {
  return Container(
    color: myWight,
    padding: const EdgeInsets.all(10.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          alignment: AlignmentDirectional.topStart,

          children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Image(
                  image: NetworkImage('${model.image}'),
                  width: double.infinity,
                  height: 200,
                ),
                if (model.discount != 0)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    color: Colors.red,
                    child: const Text(
                      'DISCOUNT',
                      style: TextStyle(fontSize: 10, color: myWight),
                    ),
                  )
              ],
            ),
            CircleAvatar(child: Icon(Icons.favorite),),

          ],
        ),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${model.name}',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Row(
                  children: [
                    Text('${model.price.round()}',
                        style: Theme.of(context).textTheme.bodySmall),
                    const SizedBox(width: 10),
                    if (model.discount != 0)
                      Text('${model.oldPrice.round()}',
                          style: Theme.of(context).textTheme.bodySmall),
                    /* const Spacer(),
                    CircleAvatar(
                      radius: 15,
                      backgroundColor:
                          AppShopCubit.get(context).favorite[model.id]!
                              ? defaultColor
                              : Colors.grey,
                      child: Center(
                        child: IconButton(
                          padding: EdgeInsets.zero,
                          onPressed: () {
                            AppShopCubit.get(context)
                                .postChangeFavorite(model.id!);
                          },
                          icon: const Icon(
                            Icons.favorite_outline,
                            size: 16,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    )*/
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
/*
  Widget _buildHomePage({
    required BuildContext context,
    required HomeModel? homeModel,
  }) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          _buildHomeBanner(context: context, homeModel: homeModel),
          const SizedBox(height: 10.0),
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
            return Container(
              color: myWight,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Categories',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  SizedBox(height: 100.0
                  ,child:  ,
                  ),
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
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 2.0,
      crossAxisSpacing: 2.0,
      crossAxisCount: 2,
      childAspectRatio: 2 / 2,
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
    );
  }

}

 */
/*
Stack(
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
Column(
crossAxisAlignment: CrossAxisAlignment.start,
children: [
Text('${HomeCubit.get(context).homeModel!.data!.products![index].name}'),
],
),*/
