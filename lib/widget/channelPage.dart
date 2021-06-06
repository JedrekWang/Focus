import 'package:flutter/cupertino.dart';

import '../models.dart';
import 'displayItem.dart';

class ItemList extends StatelessWidget {
  const ItemList({
    Key key,
    @required this.content,
  }) : super(key: key);

  final RssChannel content;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: ListView.builder(
          itemBuilder: (context, index) {
            return SizedBox(
              height: 100,
              child: DisplayItem(item: content.rssItemList[index]),
            );
          },
          itemCount: content.rssItemList.length,
        ));
  }
}