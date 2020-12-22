import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: DecoratedBox(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.red),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 25),
              Row(
                children: [
                  Avatar(),
                  Text(
                    "Jedrek Wang",
                    style: TextStyle(fontWeight: FontWeight.w800),
                  )
                ],
              ),
              Divider(
                height: 5,
                color: Colors.lightBlue,
              ),
              Column(
                children: [
                  Flex(
                    direction: Axis.horizontal,
                    children: [
                      Expanded(
                        child: Container(
                          color: Colors.yellowAccent,
                          padding: EdgeInsets.all(10),
                          child: Text("动态"),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          color: Colors.redAccent,
                          padding: EdgeInsets.all(10),
                          child: Text("关注", textAlign: TextAlign.right,),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          color: Colors.blueAccent,
                          padding: EdgeInsets.all(10),
                          child: Text("粉丝", textAlign: TextAlign.right,),
                        ),
                      )
                    ],
                  )
                ],
              )
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
