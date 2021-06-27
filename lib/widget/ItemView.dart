import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constant.dart';
import '../models.dart';
import '../parser.dart';
import 'package:async/async.dart';

import 'displayItem.dart';

class ItemView extends StatefulWidget {
  // 表示首页第一个tab页，及RSS内容的列表
  const ItemView({
    Key key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => ItemViewState();
}

class ItemViewState extends State<ItemView> {
  final AsyncMemoizer memoizer = AsyncMemoizer();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FutureBuilder(
            future: memoizer.runOnce(() => RssParser(rssUrl).parseRss()),
            builder: (builder, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  return Text("Error: ${snapshot.error}");
                } else {
                  List<RssChannel> rssChannelList = snapshot.data;
                  RssChannel content = rssChannelList[0];
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
              } else {
                return CircularProgressIndicator();
              }
            }),
      ],
    );
  }
}
