import 'package:Focus/models.dart';
import 'package:Focus/parser.dart';
import 'package:Focus/widget/channelPage.dart';
import 'package:Focus/widget/drawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'constant.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appName,
      theme: ThemeData(primaryColor: Colors.white),
      home: HomePage(title: homePageTitle),
    );
  }
}

/// 应用首页UI
class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  State<StatefulWidget> createState() {
    return HomePageState();
  }
}

/// 首页状态管理
class HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  TabController _tabController; //tab状态管理对象
  List tabs = homePageTabs;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: tabs.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(appName),
        actions: <Widget>[Icon(Icons.search)],
        bottom: TabBar(
            controller: _tabController,
            tabs: tabs.map((e) => Tab(text: e)).toList()),
      ),
      drawer: MyDrawer(),
      body: TabBarView(
        controller: _tabController,
        children: [
          Column(
            children: [
              FutureBuilder(
                  future: RssParser(rssUrl).parseRss(),
                  builder: (builder, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.hasError) {
                        return Text("Error: ${snapshot.error}");
                      } else {
                        List<RssChannel> content = snapshot.data;
                        return ItemList(content: content[0]);
                      }
                    } else {
                      return CircularProgressIndicator();
                    }
                  }),
            ],
          ),
          Container(
              alignment: Alignment.center,
              child: Text(tabs[1], textScaleFactor: 5)),
          Container(
              alignment: Alignment.center,
              child: Text(tabs[2], textScaleFactor: 5)),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.home),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.album),
              onPressed: () {},
            ),
            SizedBox(),
            IconButton(
              icon: Icon(Icons.favorite),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.person),
              onPressed: () {},
            )
          ],
          mainAxisAlignment: MainAxisAlignment.spaceAround,
        ),
        color: Colors.white,
        shape: CircularNotchedRectangle(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
