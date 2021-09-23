import 'package:ecommerce_flutter/providers/search_history_provider.dart';
import 'package:ecommerce_flutter/screens/search/components/product_list_result.dart';
import 'package:ecommerce_flutter/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';

class HistorySearchList extends StatefulWidget {
  @override
  _HistorySearchListState createState() => _HistorySearchListState();
}

class _HistorySearchListState extends State<HistorySearchList> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      Provider.of<SearchHistoryProvider>(context, listen: false)
          .getSearchHistory();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: context.watch<SearchHistoryProvider>().loading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount:
                  context.watch<SearchHistoryProvider>().searchHistory.length,
              itemBuilder: (context, index) {
                String text =
                    context.watch<SearchHistoryProvider>().searchHistory[index];
                return Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: getProportionateScreenWidth(20)),
                  child: Material(
                    elevation: 2,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: index == 4
                            ? null
                            : Border(
                                bottom: BorderSide(
                                width: 1.2,
                                color: Colors.grey.withOpacity(0.4),
                              )),
                      ),
                      child: GestureDetector(
                        onTap: () {
                          pushNewScreen(context,
                              screen: ProductListPage(
                                query: text,
                              ));
                        },
                        child: ListTile(
                          leading: Icon(Icons.search),
                          title: Text(text),
                        ),
                      ),
                    ),
                  ),
                );
              }),
    );
  }
}
