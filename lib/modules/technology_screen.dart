import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/shared/components/defaults.dart';
import 'package:news_app/shared/cubit/news_cubit.dart';
import 'package:news_app/shared/cubit/news_states.dart';

class TechnologyScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var list = NewsCubit.get(context).technology;
        return articleBuilder(list: list);
      },
    );
  }
}
