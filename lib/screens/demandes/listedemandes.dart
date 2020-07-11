import 'dart:async';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:locprojet/services/servicedeData.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:locprojet/screens/demandes/demandeScreen.dart';
import 'package:locprojet/models/demandes.dart';

class Listdemandes extends StatefulWidget {
  @override
  _ListdemandesState createState() => new _ListdemandesState();
}

class _ListdemandesState extends State<Listdemandes> {
  List<Demande> items;
  FirestoreService fireServ = new FirestoreService();
  StreamSubscription<QuerySnapshot> Demandes;

  @override
  void initState() {
    super.initState();

    items = new List();

    Demandes?.cancel();
    Demandes = fireServ.getDemandeList().listen((QuerySnapshot snapshot) {
      final List<Demande> demandes = snapshot.documents
          .map((documentSnapshot) => Demande.fromMap(documentSnapshot.data))
          .toList();

      setState(() {
        this.items = demandes;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: <Widget>[
          _myAppBar(context),
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height - 80,
            child: ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return Stack(children: <Widget>[
                    // The containers in the background
                    Column(children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(left: 8.0, right: 8.0),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 80.0,
                          child: Padding(
                            padding: EdgeInsets.only(top: 0.0, bottom: 8.0),
                            child: Material(
                              color: Colors.cyanAccent,
                              elevation: 12.0,
                              child: Center(
                                child: Padding(
                                  padding: EdgeInsets.all(13.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      DemandeType(
                                          '${items[index].demandetype}'),
                                      Text(
                                        '${items[index].demandedetails}',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 20.0),
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Text(
                                            'le prix : ${items[index].demandebudget}',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 18.0,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            'le type : ${items[index].demandetype}',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 16.0),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ]),
                  ]);
                }),
          ),
        ],
      ),
      floatingActionButton:

      FloatingActionButton(
        backgroundColor: Color(0xFFFDDE42),
        child:
        Icon(
          FontAwesomeIcons.plus,
          color: Color(0x000000),
        ),
        onPressed: () {
          //Navigator.push(context,MaterialPageRoute(builder: (context) => DemandeScreen()),
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    DemandeScreen(Demande('', '', '', '', '')),
                fullscreenDialog: true),
          );
        },
      ),
    );
  }

  Widget DemandeType(String icontype) {
    IconData iconval;
    Color colorval;
    switch (icontype) {
      case 'appartement':
        iconval = FontAwesomeIcons.building;
        colorval = Color(0xff4158ba);
        break;
      case 'maison':
        iconval = null;
        colorval = Color(0xff4158ba);
        break;
      case 'garsoniere':
        iconval = null;
        colorval = Color(0xff4158ba);
        break;
      case 'chambre':
        iconval = null;
        colorval = Color(0xff4158ba);
        break;
      default:
        iconval = null;
        colorval = Color(0xff4158ba);
      //
    }
    return CircleAvatar(
      backgroundColor: colorval,
      child: Icon(iconval, color: Colors.white, size: 20.0),
    );
  }

  Widget _myAppBar(context) {
    return Container(
      height: 80.0,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: [
              const Color(0xFFFA7397 ),

            ],
            begin: const FractionalOffset(0.0, 0.0),
            end: const FractionalOffset(1.0, 0.0),
            stops: [0.0, 1.0],
            tileMode: TileMode.clamp),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 16.0),
        child: Center(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Container(
                child: IconButton(
                    icon: Icon(
                      FontAwesomeIcons.arrowCircleLeft,
                      color: Colors.white,
                    ),
                    ),
              ),
            ),
            Expanded(
              flex: 5,
              child: Container(
                child: Text(
                  'Les Demandes',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0),
                ),
              ),
            ),

          ],
        )),
      ),
    );
  }
}
