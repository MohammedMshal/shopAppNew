abstract class HomeStates {}

class InitialState extends HomeStates{}

class HomeLoadingState extends HomeStates{}
class HomeSuccessState extends HomeStates{}
class HomeErrorState extends HomeStates{}

class CategoryLoadingState extends HomeStates{}
class CategorySuccessState extends HomeStates{}
class CategoryErrorState extends HomeStates{}