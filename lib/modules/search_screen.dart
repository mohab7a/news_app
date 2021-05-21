import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/shared/components/defaults.dart';
import 'package:news_app/shared/cubit/news_cubit.dart';
import 'package:news_app/shared/cubit/news_states.dart';

class SearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      builder: (context, state) {
        NewsCubit cubit = NewsCubit.get(context);
        return Scaffold(
          appBar: AppBar(),
          body: Column(
            children: [
              Padding(
                  padding: const EdgeInsets.all(20),
                  child: defaultFormField(
                    onChange: (value) {
                      cubit.getSearch(value);
                    },
                    label: "Search",
                    validate: (String value) {
                      if (value.isEmpty) {
                        return "Search Must Not Be Empty";
                      }
                      return null;
                    },
                    prefix: Icons.search,
                    type: TextInputType.text,
                  )),
              Expanded(
                  child: articleBuilder(list: cubit.search, isSearch: true))
            ],
          ),
        );
      },
      listener: (context, state) {},
    );
  }
}
