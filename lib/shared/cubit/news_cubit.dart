import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/modules/business_screen.dart';
import 'package:news_app/modules/sports_screen.dart';
import 'package:news_app/modules/technology_screen.dart';
import 'package:news_app/shared/networks/local/cache_helper.dart';
import 'package:news_app/shared/networks/remote/dio_helper.dart';

import 'news_states.dart';

class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() : super(NewsInitialState());
  static NewsCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;
  List<BottomNavigationBarItem> bottomItems = [
    BottomNavigationBarItem(icon: Icon(Icons.business), label: "Business"),
    BottomNavigationBarItem(icon: Icon(Icons.sports), label: "Sports"),
    BottomNavigationBarItem(
        icon: Icon(Icons.mobile_friendly), label: "Technology"),
  ];
  void changeBottomNavBar(int index) {
    currentIndex = index;
    emit(BottomNavState());
  }

  List<Widget> screens = [
    BusinessScreen(),
    SportsScreen(),
    TechnologyScreen(),
  ];
  List<dynamic> business = [];
  void getBusinessNews() {
    if (business.length == 0) {
      emit(NewsBusinessLoadingState());
      DioHelper.getData(url: "v2/top-headlines", query: {
        "country": "eg",
        "category": "business",
        "apiKey": "7a8beaf65f544fe1ac3acac1841a335a"
      }).then((value) {
        business = value.data["articles"];
        emit(GetBusinessNewsSuccessState());
      }).catchError((error) {
        print("error : $error");
        emit(GetBusinessNewsErrorState(error.toString()));
      });
    } else {
      emit(GetBusinessNewsSuccessState());
    }
  }

  List<dynamic> sports = [];
  void getSportsNews() {
    if (sports.length == 0) {
      emit(NewsSportsLoadingState());
      DioHelper.getData(url: "v2/top-headlines", query: {
        "country": "eg",
        "category": "sports",
        "apiKey": "7a8beaf65f544fe1ac3acac1841a335a"
      }).then((value) {
        sports = value.data["articles"];
        emit(GetSportsNewsSuccessState());
      }).catchError((error) {
        print("error : $error");
        emit(GetSportsNewsErrorState(error.toString()));
      });
    } else {
      emit(GetSportsNewsSuccessState());
    }
  }

  List<dynamic> technology = [];
  void getTechnologyNews() {
    if (technology.length == 0) {
      emit(NewsSearchLoadingState());
      DioHelper.getData(url: "v2/top-headlines", query: {
        "country": "eg",
        "category": "technology",
        "apiKey": "7a8beaf65f544fe1ac3acac1841a335a"
      }).then((value) {
        technology = value.data["articles"];
        emit(GetTechnologyNewsSuccessState());
      }).catchError((error) {
        print("error : $error");
        emit(GetTechnologyNewsErrorState(error.toString()));
      });
    } else {
      emit(GetSearchNewsSuccessState());
    }
  }

  bool isDark = false;
  void changeAppTheme({bool fromShared}) {
    if (fromShared != null) {
      isDark = fromShared;
      emit(ChangeAppThemeState());
    } else {
      isDark = !isDark;
      CacheHelper.setData(key: "dark", value: isDark)
          .then((value) => emit(ChangeAppThemeState()));
    }
  }

  List<dynamic> search = [];
  void getSearch(value) {
    emit(NewsSearchLoadingState());
    DioHelper.getData(url: "v2/everything", query: {
      "q": "$value",
      "apiKey": "7a8beaf65f544fe1ac3acac1841a335a",
    }).then((value) {
      search = value.data["articles"];
      emit(GetSearchNewsSuccessState());
    }).catchError((error) {
      print("error : $error");
      emit(GetSearchNewsErrorState(error.toString()));
    });
  }
}
