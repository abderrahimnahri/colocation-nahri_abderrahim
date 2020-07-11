import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:locprojet/models/offre.dart';
import 'package:locprojet/screens/fromOffre/nvl_offre.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class RunMap extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Coloc',
      theme: ThemeData(
        primaryColor: Colors.blue,
      ),
      home: new HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => new HomePageState();
}

class HomePageState extends State<HomePage> {
  Completer<GoogleMapController> _controller = Completer();
  double clickedLat = 0;
  double clickedLong = 0;

  List<Marker> allMarkers = [];
  List<Marker> allMarker = [];

  var offres = new List<Offre>();



  @override
  void initState() {

    Firestore.instance
        .collection('offres')
        .getDocuments()
        .then((QuerySnapshot snapshot) {
      snapshot.documents.forEach((result) {
        offres.add(new Offre(oid: result.data['oid'],adresseX:result.data['adresseX'],adresseY:result.data['adresseY'],capacite:result.data['capacite'],superficie:result.data['superficie'],prix:result.data['prix']));
        print("prix"+result.data['prix']);
      });
    });
    allMarker.add(Marker(
      markerId: MarkerId('hi'),
      onTap: () {
        print('Marker Tapped');

      },
      position : LatLng(32.375510, -6.318743),

      draggable:false,
      infoWindow: InfoWindow(
        title: 'appartement 3 chambre 2 cuisine',

        snippet:'prix : 2000 DH',

      ),

    ));




    print('${offres}');
    offres.forEach((Offre off) {



    });



    // TODO: implement initState
    super.initState();
    print('test');
  }

  double zoomVal = 5.0;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Maps"),
      ),
      body: Stack(
        children: <Widget>[
          _googlemap(context),
          _builderfunction(),
        ],
      ),
    );
  }

  Widget _builderfunction() {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 20.0),
        height: 150.0,
        padding: const EdgeInsets.all(8.0),


      ),

    );
  }

  Widget _boxes(String _image, String addressx, String addressy, String prix,String superf,String cap,String tele) {
    return GestureDetector(
      onTap: () {
        _gotoLocation(double.parse(addressx),double.parse(addressy));
      },
      child: Container(
        child: new FittedBox(
          child: Material(
              color: Colors.white,
              elevation: 14.0,
              borderRadius: BorderRadius.circular(24.0),
              shadowColor: Color(0x802196F3),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    width: 180,
                    height: 200,
                    child: ClipRRect(
                      borderRadius: new BorderRadius.circular(24.0),
                      child: Image(
                        fit: BoxFit.fill,
                        image: NetworkImage(_image),
                      ),
                    ),
                  ),

                ],
              )),
        ),
      ),
    );
  }



  Widget _googlemap(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: GoogleMap(
        mapType: MapType.normal,
        onTap: (LatLng) {
          clickedLat = LatLng.latitude;
          clickedLong = LatLng.longitude;
          var router = new MaterialPageRoute(
              builder: (BuildContext context) => AddOffre(x:clickedLat,y:clickedLong));
          Navigator.of(context).push(router);
        },

        initialCameraPosition:
        CameraPosition(target: LatLng(32.375510, -6.318743), zoom: 12.0),
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        markers: Set.from(allMarker),
      ),
    );
  }

  Future<void> _gotoLocation(double lat, double long) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: LatLng(lat, long),
      zoom: 15,
      tilt: 50.0,
      bearing: 45.0,
    )));
  }
}
