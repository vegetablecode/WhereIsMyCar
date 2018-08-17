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
      navigationBar: CupertinoNavigationBar(
        middle: Text("About Page"),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            CupertinoButton(
              child: Text('Button'),
              onPressed: () {},
            ),
            CupertinoSlider(
              value: _value,
              min: 0.0,
              max: 100.0,
              onChanged: (double value) {
                setState(() => _value = value);
              },
              activeColor: CupertinoColors.activeGreen,
            ),
            CupertinoSwitch(
              value: _switchValue,
              onChanged: (bool value) {
                setState(() => _switchValue = value);
              },
            ),
            Text(
              'Sample text',
              style: Theme.of(context).textTheme.button,
            ),
          ],
        ),
      ),
    );
  }
}