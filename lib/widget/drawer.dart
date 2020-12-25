import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List configs = [
      {"text": "首页", "label": Icons.home},
      {"text": "历史记录", "label": Icons.history},
      {"text": "下载管理", "label": Icons.arrow_circle_down},
      {"text": "我的收藏", "label": Icons.star_border},
      {"text": "稍后再看", "label": Icons.watch_later_outlined},
      {"text": "设置", "label": Icons.settings},
    ];

    return Drawer(
      child: MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: DecoratedBox(
          decoration: BoxDecoration(
            // border: Border.all(color: Colors.red),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 25),
              Row(
                children: [
                  Avatar(),
                  SizedBox(width: 20),
                  Text(
                    "Jedrek Wang",
                    style: TextStyle(fontWeight: FontWeight.w800),
                  )
                ],
              ),
              Divider(
                height: 5,
                color: Colors.grey,
              ),
              Column(
                children: [
                  Flex(
                    direction: Axis.horizontal,
                    children: [
                      Expanded(
                          child: FlatButton(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        onPressed: () {},
                        child: Column(
                          children: [Text("0"), Text("动态")],
                        ),
                      )),
                      Expanded(
                          child: FlatButton(
                        onPressed: () {},
                        child: Column(
                          children: [Text("0"), Text("关注")],
                        ),
                      )),
                      Expanded(
                          child: FlatButton(
                        onPressed: () {},
                        child: Column(
                          children: [Text("0"), Text("粉丝")],
                        ),
                      ))
                    ],
                  )
                ],
              ),
              Divider(
                height: 5,
                color: Colors.grey,
              ),
              Expanded(
                  child: ListView.builder(
                itemBuilder: (context, index) {
                  return SizedBox(
                      height: 50,
                      child: FlatButton(
                        child: Row(
                          children: [
                            Icon(configs[index]["label"]),
                            SizedBox(width: 30),
                            Text(configs[index]["text"])
                          ],
                        ),
                        onPressed: () {},
                      ));
                },
                itemCount: configs.length,
              ))
            ],
          ),
        ),
      ),
    );
  }
}

class Avatar extends StatelessWidget {
  const Avatar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Container(
          // alignment: Alignment.topLeft,
          width: 150,
          height: 150,
          child: Image.asset(
            "assets/head.jpg",
            alignment: Alignment.centerLeft,
            fit: BoxFit.cover,
          )),
    );
  }
}
