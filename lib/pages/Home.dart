import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class Home extends StatefulWidget {
  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    // load images
    var parkCarImage = new AssetImage("assets/parkCar.png");
    var findCarImage = new AssetImage("assets/findCar.png");
    var parkCarImg = new Image(
      image: parkCarImage,
      width: 480.0,
    );
    var findCarImg = new Image(
      image: findCarImage,
      width: 480.0,
    );

    return CupertinoPageScaffold(
      backgroundColor: new Color(0xFFebe7de),
        child: CustomScrollView(
      slivers: <Widget>[
        new CupertinoSliverNavigationBar(
          largeTitle: Text('Gdzie jest moje auto?', style: new TextStyle(color: Colors.white),),
          backgroundColor: new Color(0xFF454c54),
        ),
        new SliverFillRemaining(
            child: new Container(
          padding: EdgeInsets.all(5.0),
          child: new Center(
            child: new Column(children: <Widget>[
              new Card(
                  child: new Container(
                child: parkCarImg,
              )),
              new Card(
                  child: new Container(
                child: findCarImg,
              ))
            ]),
          ),
        ))
      ],
    ));
  }
}
