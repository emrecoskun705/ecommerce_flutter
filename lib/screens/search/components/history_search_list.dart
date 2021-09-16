import 'package:ecommerce_flutter/size_config.dart';
import 'package:flutter/material.dart';

class HistorySearchList extends StatelessWidget {
  const HistorySearchList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: ListView.builder(
          itemCount: 5,
          itemBuilder: (context, index) {
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
                  child: ListTile(
                    leading: Icon(Icons.search),
                    title: Text('deneme'),
                  ),
                ),
              ),
            );
          }),
    );
  }
}
