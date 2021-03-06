import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:map_view/map_view.dart';

const API_KEY = "AIzaSyALQLUYBzyhgn7onshH989xBeiW6aUrm_I";

class Home extends StatefulWidget {
  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  // load map
  var mapView = new MapView();
  CameraPosition cameraPosition;
  Uri staticMapUri;
  var compositeSubscription = new CompositeSubscription();
  var staticMapProvider = new StaticMapProvider(API_KEY);
  var currentLocation;

  List<Marker> _markers = <Marker>[
    new Marker(
      "1",
      "Something fragile!",
      45.52480841512737,
      -122.66201455146073,
      color: Colors.blue,
      draggable: true, //Allows the user to move the marker.
      markerIcon: new MarkerIcon(
        "images/flower_vase.png",
        width: 112.0,
        height: 75.0,
      ),
    ),
  ];
  
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

    // initial state
    @override
    initState() {
      super.initState();
      cameraPosition = new CameraPosition(Locations.portland, 2.0);
      staticMapUri = staticMapProvider.getStaticUri(Locations.portland, 12,
        width: 900, height: 400, mapType: StaticMapViewType.roadmap);
    }

    return CupertinoPageScaffold(
        backgroundColor: new Color(0xFFebe7de),
        child: CustomScrollView(
          slivers: <Widget>[
            new CupertinoSliverNavigationBar(
              largeTitle: Text(
                'Gdzie jest moje auto?',
                style: new TextStyle(color: Colors.white),
              ),
              backgroundColor: new Color(0xFF454c54),
            ),
            new SliverFillRemaining(
                child: new Container(
              padding: EdgeInsets.all(5.0),
              child: new Center(
                child: new Column(children: <Widget>[
                  new GestureDetector(
                    onTap: parkTheCarDialog,
                    child: new Card(
                        child: new Container(
                      child: parkCarImg,
                    )),
                  ),
                  new GestureDetector(
                      onTap: findTheCar,
                      child: new Card(
                          child: new Container(
                        child: findCarImg,
                      )))
                ]),
              ),
            ))
          ],
        ));
  }

  void parkTheCar() {
    print("park"); 
    getLocation();
    getLocation();
    carParkedDialog();
  }

  void findTheCar() {
    print("find");
    showMap();
  }

  // map methods
  void showMap() {
    mapView.show(
        new MapOptions(
            mapViewType: MapViewType.normal,
            showUserLocation: true,
            showMyLocationButton: true,
            showCompassButton: true,
            initialCameraPosition: new CameraPosition(
                new Location(_markers[0].latitude, _markers[0].longitude), 15.0),
            hideToolbar: false,
            title: "Znajdź samochód"),
        toolbarActions: [new ToolbarAction("Close", 1)]);
    StreamSubscription sub = mapView.onMapReady.listen((_) {
      mapView.setMarkers(_markers);
    });
    compositeSubscription.add(sub);
    sub = mapView.onLocationUpdated.listen((location) {
      print("Location updated $location");
    });
    compositeSubscription.add(sub);
    sub = mapView.onTouchAnnotation
        .listen((annotation) => print("annotation ${annotation.id} tapped"));
    compositeSubscription.add(sub);
    sub = mapView.onMapTapped
        .listen((location) => print("Touched location $location"));
    compositeSubscription.add(sub);
    sub = mapView.onCameraChanged.listen((cameraPosition) =>
        this.setState(() => this.cameraPosition = cameraPosition));
    compositeSubscription.add(sub);
    sub = mapView.onAnnotationDragStart.listen((markerMap) {
      var marker = markerMap.keys.first;
      print("Annotation ${marker.id} dragging started");
    });
    sub = mapView.onAnnotationDragEnd.listen((markerMap) {
      var marker = markerMap.keys.first;
      print("Annotation ${marker.id} dragging ended");
    });
    sub = mapView.onAnnotationDrag.listen((markerMap) {
      var marker = markerMap.keys.first;
      var location = markerMap[marker];
      print("Annotation ${marker.id} moved to ${location.latitude} , ${location
          .longitude}");
    });
    compositeSubscription.add(sub);
    sub = mapView.onToolbarAction.listen((id) {
      print("Toolbar button id = $id");
      if (id == 1) {
        _handleDismiss();
      }
    });
    compositeSubscription.add(sub);
    sub = mapView.onInfoWindowTapped.listen((marker) {
      print("Info Window Tapped for ${marker.title}");
    });
    compositeSubscription.add(sub);
  }

  void _handleDismiss() async {
    double zoomLevel = await mapView.zoomLevel;
    Location centerLocation = await mapView.centerLocation;
    List<Marker> visibleAnnotations = await mapView.visibleAnnotations;
    print("Zoom Level: $zoomLevel");
    print("Center: $centerLocation");
    print("Visible Annotation Count: ${visibleAnnotations.length}");
    var uri = await staticMapProvider.getImageUriFromMap(mapView,
        width: 900, height: 400);
    setState(() => staticMapUri = uri);
    mapView.dismiss();
    compositeSubscription.cancel();
  }

  void getLocation() {
    mapView.show(
        new MapOptions(
            mapViewType: MapViewType.normal,
            showUserLocation: true,
            showMyLocationButton: true,
            showCompassButton: true,
            initialCameraPosition: new CameraPosition(
                new Location(45.526607443935724, -122.66731660813093), 15.0),
            hideToolbar: false,
            title: "Zaparkowano samochód"),
        toolbarActions: [new ToolbarAction("Close", 1)]);
    StreamSubscription sub = mapView.onMapReady.listen((_) {
      mapView.setMarkers(_markers);
    });
    compositeSubscription.add(sub);
    sub = mapView.onLocationUpdated.listen((location) {
      print("Location updated $location");
      currentLocation = location;
    });
    compositeSubscription.add(sub);
    sub = mapView.onTouchAnnotation
        .listen((annotation) => print("annotation ${annotation.id} tapped"));
    compositeSubscription.add(sub);
    sub = mapView.onMapTapped
        .listen((location) => print("Touched location $location"));
    compositeSubscription.add(sub);
    sub = mapView.onCameraChanged.listen((cameraPosition) =>
        this.setState(() => this.cameraPosition = cameraPosition));
    compositeSubscription.add(sub);
    sub = mapView.onAnnotationDragStart.listen((markerMap) {
      var marker = markerMap.keys.first;
      print("Annotation ${marker.id} dragging started");
    });
    sub = mapView.onAnnotationDragEnd.listen((markerMap) {
      var marker = markerMap.keys.first;
      print("Annotation ${marker.id} dragging ended");
    });
    sub = mapView.onAnnotationDrag.listen((markerMap) {
      var marker = markerMap.keys.first;
      var location = markerMap[marker];
      print("Annotation ${marker.id} moved to ${location.latitude} , ${location
          .longitude}");
    });
    compositeSubscription.add(sub);
    sub = mapView.onToolbarAction.listen((id) {
      print("Toolbar button id = $id");
      if (id == 1) {
        _handleDismiss();
      }
    });
    compositeSubscription.add(sub);
    sub = mapView.onInfoWindowTapped.listen((marker) {
      print("Info Window Tapped for ${marker.title}");
    });
    compositeSubscription.add(sub);

    // add new point
    sub = mapView.onLocationUpdated.listen((location) {
      // create a new marker
      Marker carMarker = new Marker(
      "2",
      "Twój samochód!",
      currentLocation.latitude,
      currentLocation.longitude,
      color: Colors.blue,
      draggable: false,
      markerIcon: new MarkerIcon(
        "assets/parking.png",
        width: 75.0,
        height: 75.0,
      ),
      );
      _markers.clear();
      _markers.add(carMarker);
      print("a new point has been created!");
    });
    _handleDismiss();
  }

  Future<Null> parkTheCarDialog() async {
    return showDialog<Null>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return new AlertDialog(
          title: new Text('Parkowanie auta'),
          content: new SingleChildScrollView(
            child: new ListBody(
              children: <Widget>[
                new Text('Czy jesteś pewien, że chcesz zaparkować auto? Zapisane miejsce parkingowe zostanie usunięte.'),
              ],
            ),
          ),
          actions: <Widget>[
            new FlatButton(
              child: new Text('Ok'),
              onPressed: () {
                parkTheCar();
                Navigator.of(context).pop();
              },
            ),
            new FlatButton(
              child: new Text('Anuluj'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<Null> carParkedDialog() async {
    return showDialog<Null>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return new AlertDialog(
          title: new Text('Parkowanie auta'),
          content: new SingleChildScrollView(
            child: new ListBody(
              children: <Widget>[
                new Text('Samochód zaparkowany pomyślnie'),
              ],
            ),
          ),
          actions: <Widget>[
            new FlatButton(
              child: new Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

class CompositeSubscription {
  Set<StreamSubscription> _subscriptions = new Set();

  void cancel() {
    for (var n in this._subscriptions) {
      n.cancel();
    }
    this._subscriptions = new Set();
  }

  void add(StreamSubscription subscription) {
    this._subscriptions.add(subscription);
  }

  void addAll(Iterable<StreamSubscription> subs) {
    _subscriptions.addAll(subs);
  }

  bool remove(StreamSubscription subscription) {
    return this._subscriptions.remove(subscription);
  }

  bool contains(StreamSubscription subscription) {
    return this._subscriptions.contains(subscription);
  }

  List<StreamSubscription> toList() {
    return this._subscriptions.toList();
  }
}