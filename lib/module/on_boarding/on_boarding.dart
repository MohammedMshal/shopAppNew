import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/module/on_boarding/cubit/onboarding_cubit.dart';
import 'package:shop_app/module/on_boarding/cubit/onboarding_states.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/style/theme.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../model/on_boarding/on_boarding.dart';

class ONBoardingScreen extends StatelessWidget {
  ONBoardingScreen({Key? key}) : super(key: key);

  final pageController = PageController();
  final List<OnBoardingModel> data = [
    OnBoardingModel(
      image:
          'https://img.freepik.com/free-vector/happy-people-shopping-online_74855-5865.jpg',
      title: 'Shop now',
      body: 'Shop now online',
    ),
    OnBoardingModel(
      image:
          'https://img.freepik.com/free-vector/ecommerce-web-page-concept-illustration_114360-8204.jpg',
      title: 'esy Shop',
      body: 'Ease of shopping',
    ),
    OnBoardingModel(
      image:
          'https://img.freepik.com/free-photo/laptop-shopping-bags-online-shopping-concept_1423-189.jpg',
      title: 'Speed delivery',
      body: 'Speed in order delivery',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OnBoardingCubit, OnBoardingStates>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            actions: [
              defaultTextButton(onPressed: () {}, label: 'SKIP'),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              children: [
                _buildPageView(
                  context: context,
                ),
                _buildBottomPage(
                  isLast: OnBoardingCubit.get(context).isLast,
                  context: context,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildPageView({required BuildContext context}) {
    return Expanded(
      child: PageView.builder(
          controller: pageController,
          itemCount: data.length,
          onPageChanged: (value) {
            OnBoardingCubit.get(context)
                .isChangeLastPage(value: value, model: data);
          },
          itemBuilder: (BuildContext context, int index) {
            return _buildItemBoarding(model: data[index], context: context);
          }),
    );
  }

  Widget _buildItemBoarding({
    required OnBoardingModel model,
    required BuildContext context,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Image(
            image: NetworkImage(model.image),
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(height: 30.0),
        Text(
          model.title,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const SizedBox(height: 15.0),
        Text(model.body, style: Theme.of(context).textTheme.bodyMedium),
      ],
    );
  }

  Widget _buildPageIndicator() {
    return SmoothPageIndicator(
      controller: pageController,
      count: data.length,
      effect: const ExpandingDotsEffect(
        activeDotColor: primaryColor,
        dotColor: myGrey,
        dotHeight: 10.0,
        expansionFactor: 4.0,
        dotWidth: 10.0,
        spacing: 5.0,
      ),
    );
  }

  Widget _buildBottomPage({
    required bool isLast,
    required BuildContext context,
  }) {
    return Row(
      children: [
        _buildPageIndicator(),
        const Spacer(),
        FloatingActionButton(
          onPressed: () {
            if (isLast) {
              OnBoardingCubit.get(context).saveSubmit(context: context);
            } else {
              pageController.nextPage(
                duration: const Duration(microseconds: 500),
                curve: Curves.fastLinearToSlowEaseIn,
              );
            }
          },
          child: const Icon(Icons.arrow_forward_ios_outlined),
        ),
      ],
    );
  }
}
