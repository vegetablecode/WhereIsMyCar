import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import './pages/Home.dart' as homePage;
import './pages/About.dart' as aboutPage;

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cupertino Demo',
      theme: ThemeData.light(),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return new CupertinoTabScaffold(
      tabBar: new CupertinoTabBar(
          backgroundColor: CupertinoColors.lightBackgroundGray,
          items: [
            new BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.home),
              title: Text("Home"),
            ),
            new BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.info),
              title: Text("About me"),
            ),
          ]),
      tabBuilder: (context, index) {
        return CupertinoTabView(
          builder: (context) {
            switch (index) {
              case 0:
                return homePage.Home();
                break;
              case 1:
                return aboutPage.About();
                break;
              default:
                return Container();
            }
          },
        );
      },
    );
  }
}
