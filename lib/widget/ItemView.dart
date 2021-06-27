import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

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
  EasyRefreshController _controller;
  RssChannel content;

  @override
  void initState() {
    super.initState();
    _controller = EasyRefreshController();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FutureBuilder(
            future: fetchItemList(),
            builder: (builder, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  return Text("Error: ${snapshot.error}");
                } else {
                  content = snapshot.data[0];
                  return Expanded(
                      child: EasyRefresh(
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        return SizedBox(
                          height: 100,
                          child: DisplayItem(item: content.rssItemList[index]),
                        );
                      },
                      itemCount: content.rssItemList.length,
                    ),
                    onRefresh: () async {
                      RssParser(rssUrl).parseRss();
                      _controller.resetLoadState();
                    },
                  ));
                }
              } else {
                return CircularProgressIndicator();
              }
            }),
      ],
    );
  }

  Future<dynamic> fetchItemList() =>
      memoizer.runOnce(() => RssParser(rssUrl).parseRss());

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
