// import 'package:Focus/parser/rss_parser.dart';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// import 'package:xml/xml.dart';
// import 'package:flutter/services.dart' show rootBundle;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Focus',
      theme: ThemeData(primaryColor: Colors.white),
      home: HomePage(title: "Focus on"),
    );
  }
}

// 第二个页面组件
class NewRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("New route"),
        ),
        body: HomePage());
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return HomePageState();
  }
}

class HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  TabController _tabController; //需要定义一个Controller
  List tabs = ["关注", "推荐", "热榜"];

  @override
  void initState() {
    super.initState();
    // 创建Controller
    _tabController = TabController(length: tabs.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Focus on"),
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
              // Image.asset('assets/Tunnel.jpg'),
              FutureBuilder(
                  future: DefaultAssetBundle.of(context)
                      .loadString("assets/package.json"),
                  builder: (builder, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.hasError) {
                        return Text("Error: ${snapshot.error}");
                      } else {
                        var content = json.decode(snapshot.data);
                        return ItemList(content: content);
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
        // tabs.map((e) { //创建3个Tab页
        //   return Container(
        //     alignment: Alignment.center,
        //     child: Text(e, textScaleFactor: 5),
        //   );
        // }).toList(),
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

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: DecoratedBox(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/head.jpg"), fit: BoxFit.contain)),
      ),
    ));
  }
}

class ItemList extends StatelessWidget {
  const ItemList({
    Key key,
    @required this.content,
  }) : super(key: key);

  final content;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: ListView.builder(
      itemBuilder: (context, index) {
        return SizedBox(
          height: 100,
          child: DisplayItem(item: content[index]),
        );
      },
      itemCount: content.length,
    ));
  }
}

class DisplayItem extends StatelessWidget {
  const DisplayItem({
    Key key,
    @required this.item,
  }) : super(key: key);

  final item;

  @override
  Widget build(BuildContext context) {
    return Card(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
                child: Text(
                  "${item["name"]}",
                  textAlign: TextAlign.left,
                  textScaleFactor: 1.2,
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                flex: 3),
            Expanded(
              child: Text("${item["degree"]}万热度",
                  textAlign: TextAlign.left,
                  style: TextStyle(color: Colors.grey)),
              flex: 1,
            )
          ],
        ));
  }
}
