import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class About extends StatefulWidget {
  @override
  AboutState createState() => AboutState();
}

class AboutState extends State<About> {
  double _value = 50.0;
  bool _switchValue = false;
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: new Color(0xFFebe7de),
      navigationBar: CupertinoNavigationBar(
        middle: Text(
          "O aplikacji",
          style: new TextStyle(color: Colors.white),
        ),
        backgroundColor: new Color(0xFF454c54),
      ),
      child: Center(
          child: new Container(
        padding: new EdgeInsets.all(5.0),
        child: Column(
          children: <Widget>[
            new Container(
              padding: new EdgeInsets.all(5.0),
              child: Text(
                'Aplikacja służy do lokalizacji samochodu na parkingu samochodowym. Wystarczy "Zaparkować Samochód" w aplikacji, by potem łatwo odnaleźć go na mapie.',
                style: Theme.of(context).textTheme.button,
              ),
            )
          ],
        ),
      )),
    );
  }
}
