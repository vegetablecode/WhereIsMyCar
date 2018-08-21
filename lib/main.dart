import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:map_view/figure_joint_type.dart';
import 'package:map_view/map_view.dart';
import 'package:map_view/polygon.dart';
import 'package:map_view/polyline.dart';
import './pages/Home.dart' as homePage;
import './pages/About.dart' as aboutPage;

const API_KEY = "AIzaSyALQLUYBzyhgn7onshH989xBeiW6aUrm_I";

void main() {
  MapView.setApiKey(API_KEY);
  runApp(new MyApp());
}

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
      tabBar:
          new CupertinoTabBar(backgroundColor: new Color(0xFF454c54), items: [
        new BottomNavigationBarItem(
          icon: Icon(
            CupertinoIcons.home,
            color: Colors.white,
          ),
          title: Text("Home", style: new TextStyle(color: Colors.white)),
        ),
        new BottomNavigationBarItem(
          icon: Icon(
            CupertinoIcons.info,
            color: Colors.white,
          ),
          title: Text("O aplikacji", style: new TextStyle(color: Colors.white)),
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
