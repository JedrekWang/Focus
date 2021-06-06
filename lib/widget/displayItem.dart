import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models.dart';

class DisplayItem extends StatelessWidget {
  const DisplayItem({
    Key key,
    @required this.item,
  }) : super(key: key);

  final RssItem item;

  @override
  Widget build(BuildContext context) {
    return Card(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
                child: Text(
                  "${item.title}",
                  textAlign: TextAlign.left,
                  textScaleFactor: 1.2,
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                flex: 3),
            Expanded(
              child: Text("作者：${item.creator}",
                  textAlign: TextAlign.left,
                  style: TextStyle(color: Colors.grey)),
              flex: 1,
            )
          ],
        ));
  }
}