import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:locprojet/models/demandes.dart';
import 'package:locprojet/services/servicedeData.dart';

class DemandeScreen extends StatefulWidget {
  final Demande demande;
  DemandeScreen(this.demande);
  @override
  _DemandeScreenState createState() => _DemandeScreenState();
}

class _DemandeScreenState extends State<DemandeScreen> {
  FirestoreService fireServ = new FirestoreService();

  TextEditingController _demandebudgetController;
  TextEditingController _demandedetailsController;
  TextEditingController _demandedateController;
  TextEditingController _demandetimeController;

  int _mydemandetype = 0;
  String demandeVal;
  void _handledemandetype(int value) {
    setState(() {
      _mydemandetype = value;
      switch (_mydemandetype) {
        case 1:
          demandeVal = 'chambre';
          break;
        case 2:
          demandeVal = 'appartement';


          break;
      }
    });
  }

  @override
  void initState() {
    super.initState();

    _demandebudgetController =
        new TextEditingController(text: widget.demande.demandebudget);
    _demandedetailsController =
        new TextEditingController(text: widget.demande.demandedetails);
    _demandedateController =
        new TextEditingController(text: widget.demande.demandedate);
    _demandetimeController =
        new TextEditingController(text: widget.demande.demandetime);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: <Widget>[
          _myAppBar(),
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height - 80,
            child: ListView(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 16.0, right: 16.0),
                  child: TextField(
                    controller: _demandebudgetController,
                    decoration: InputDecoration(hintText: "Budget max: ",border: OutlineInputBorder()),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 16.0, right: 16.0),
                  child: TextField(
                    controller: _demandedetailsController,
                    decoration: InputDecoration(hintText: "Details: ",border: OutlineInputBorder()),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 16.0, right: 16.0),
                  child: TextField(
                    controller: _demandedateController,
                    decoration: InputDecoration(hintText: "Date: ",border: OutlineInputBorder()),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 16.0, right: 16.0),
                  child: TextField(
                    controller: _demandetimeController,
                    decoration: InputDecoration(hintText: "Time: ", border: OutlineInputBorder()),
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Radio(
                          value: 1,
                          groupValue: _mydemandetype,
                          onChanged: _handledemandetype,
                          activeColor: Color(0xff4158ba),
                        ),
                        Text(
                          'Appartement',
                          style: TextStyle(fontSize: 16.0),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Radio(
                          value: 2,
                          groupValue: _mydemandetype,
                          onChanged: _handledemandetype,
                          activeColor: Color(0x1111111),
                        ),
                        Text(
                          'Maison',
                          style: TextStyle(
                            fontSize: 16.0,
                          ),
                        ),
                      ],
                    ),



                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[

                    RaisedButton(
                        color: Color(0x0000000),
                        onPressed: () {
                          fireServ
                              .createDemande(
                                  _demandebudgetController.text,
                                  _demandedetailsController.text,
                                  _demandedateController.text,
                                  _demandetimeController.text,
                                  demandeVal)
                              .then((_) {
                            Navigator.pop(context);
                          });
                        },
                        child: const Text(
                          "Submit",
                          style: TextStyle(color: Color(0xFFFDDE42),
                          
                          ),
                        ))
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _myAppBar() {
    return Container(
      height: 80.0,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: [
              const Color(0xFFFA7397),

            ],
            begin: const FractionalOffset(0.0, 0.0),
            end: const FractionalOffset(1.0, 0.0),
            stops: [0.0, 1.0],
            tileMode: TileMode.clamp),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 0.0),
        child: Center(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Container(
                child: IconButton(
                    icon: Icon(
                      FontAwesomeIcons.arrowLeft,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    }),
              ),
            ),
            Expanded(
              flex: 5,
              child: Container(
                child: Text(
                  'Nouvelle Demande',
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
