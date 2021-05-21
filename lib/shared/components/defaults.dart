import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:news_app/modules/webview_screen.dart';

Widget buildArticleItem(article, context) => InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => WebViewScreen(url: article["url"]),
            ));
      },
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.2,
              width: MediaQuery.of(context).size.width * 0.4,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(article["urlToImage"]))),
            ),
            SizedBox(
              width: 20,
            ),
            Expanded(
              child: Container(
                height: MediaQuery.of(context).size.height * 0.15,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                        child: Text(
                      "${article['title']}",
                      maxLines: 3,
                      textAlign: TextAlign.start,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyText1,
                    )),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      article["publishedAt"],
                      style: TextStyle(color: Colors.grey),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
Widget buildDivider({@required Color color}) => Padding(
      padding: EdgeInsetsDirectional.only(start: 20),
      child: Container(
        height: 1,
        width: double.infinity,
        color: color,
      ),
    );

Widget articleBuilder({@required list, bool isSearch = false}) =>
    ConditionalBuilder(
      condition: list.length > 0,
      fallback: (context) => isSearch
          ? Container()
          : Center(
              child: CircularProgressIndicator(),
            ),
      builder: (context) => ListView.separated(
          physics: BouncingScrollPhysics(),
          itemBuilder: (context, index) =>
              buildArticleItem(list[index], context),
          separatorBuilder: (context, index) =>
              buildDivider(color: Colors.deepOrange),
          itemCount: list.length),
    );
Widget defaultFormField(
        {@required TextEditingController controller,
        @required String label,
        Function onChange,
        Function onTap,
        Function onSubmit,
        @required Function validate,
        @required IconData prefix,
        @required TextInputType type}) =>
    TextFormField(
      controller: controller,
      onTap: onTap,
      onFieldSubmitted: onSubmit,
      keyboardType: type,
      validator: validate,
      onChanged: onChange,
      decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: label,
          prefixIcon: Icon(prefix)),
    );
