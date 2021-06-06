import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

import '../models.dart';

class ItemDetail extends StatelessWidget {
  final RssItem item;

  ItemDetail(this.item);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(item.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Html(
              data: item.desc,
              style: {
                "a": Style(
                  color: Colors.blueAccent,
                  textDecoration: TextDecoration.none
                ),
                "p": Style(
                    fontSize: FontSize.larger,
                    padding: EdgeInsets.only(top: 15, bottom: 15),
                    margin: EdgeInsets.only(left: 10, right: 10),
                    lineHeight: LineHeight.number(1.2),
                ),

              },
            ),
          ],
        ),
      ),
    );
  }
}
