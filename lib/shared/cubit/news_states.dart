abstract class NewsStates {}

class NewsInitialState extends NewsStates {}

class BottomNavState extends NewsStates {}

class NewsBusinessLoadingState extends NewsStates {}

class GetBusinessNewsSuccessState extends NewsStates {}

class GetBusinessNewsErrorState extends NewsStates {
  final String error;
  GetBusinessNewsErrorState(this.error);
}

class NewsSportsLoadingState extends NewsStates {}

class GetSportsNewsSuccessState extends NewsStates {}

class GetSportsNewsErrorState extends NewsStates {
  final String error;
  GetSportsNewsErrorState(this.error);
}

class NewsTechnologyLoadingState extends NewsStates {}

class GetTechnologyNewsSuccessState extends NewsStates {}

class GetTechnologyNewsErrorState extends NewsStates {
  final String error;
  GetTechnologyNewsErrorState(this.error);
}

class ChangeAppThemeState extends NewsStates {}

class NewsSearchLoadingState extends NewsStates {}

class GetSearchNewsSuccessState extends NewsStates {}

class GetSearchNewsErrorState extends NewsStates {
  final String error;
  GetSearchNewsErrorState(this.error);
}
