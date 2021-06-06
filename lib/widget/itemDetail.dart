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
            ),
          ],
        ),
      ),
    );
  }
}
