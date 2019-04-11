import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
        title: 'Performance Test',
        theme: CupertinoThemeData(
          barBackgroundColor: Colors.blueGrey[100],
        ),
        home: MainView());
  }
}

class MainView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        // backgroundColor: CupertinoColors.lightBackgroundGray,
        navigationBar: CupertinoNavigationBar(
          middle: Text('Performance Test'),
        ),
        child: Container(
          child: MyTableView(),
        ));
  }
}

class MyTableView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 200,
      padding: EdgeInsets.only(top: 15,left: 15, right: 15),
      itemBuilder: buildItem
    );
  }
  Widget buildItem (BuildContext context, int index) {
        if (index.isOdd)
          return Container(
            height: 15,
          );
        index = index ~/ 2;
        return Container(
          height: 120,
          padding: EdgeInsets.only(left: 8, top: 8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: 40.0,
                    height: 40.0,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/avatar.jpg'),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(20.0),
                      ),
                    ),
                  ),
                  Text(
                    '   User$index',
                    style: TextStyle(color: Color.fromARGB(255, 2, 80, 80)),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.only(left: 50),
                width: 250,
                height: 45,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Container(
                      width: 75.0,
                      height: 45.0,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/banner1.png'),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.0),
                        ),
                      ),
                    ),
                    Container(
                      width: 75.0,
                      height: 45.0,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/banner2.png'),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.0),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
          decoration: BoxDecoration(
              color: Color.fromARGB(255, 178, 178, 178),
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.all(Radius.circular(10)),
              boxShadow: [
                BoxShadow(
                    color: Color.fromARGB(80, 94, 169, 234),
                    offset: Offset(0, 6),
                    blurRadius: 10,
                    spreadRadius: 2)
              ]),
        );
      }
}
