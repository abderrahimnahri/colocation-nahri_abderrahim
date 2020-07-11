import 'dart:io';
import 'package:locprojet/models/offre.dart';
import 'package:locprojet/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:locprojet/services/database.dart';


class AddOffre extends StatefulWidget {
  @override
 final double x;
 final double y;

  const AddOffre ({ Key key, this.x,this.y }): super(key: key);
  _AddOffreState createState() => _AddOffreState();
}

class _AddOffreState extends State<AddOffre> {
  
  String dropdownValue_capacite = '1';
  bool terrasse = false;
  bool wifi = false;
  bool laveLinge = false;
  
 
  OurUser _currentUser = OurUser(); 

OurUser get getCurrentUser => _currentUser;

FirebaseAuth _auth = FirebaseAuth.instance;
 

 List<bool> suppls;


  TextEditingController _adressXController = TextEditingController();
  TextEditingController _teleController = TextEditingController();
  TextEditingController _adressYController = TextEditingController();
  TextEditingController _prixController = TextEditingController();
  TextEditingController _superficieController = TextEditingController();

  File _image;
  final picker = ImagePicker();
   Future getImage() async {
        var image = await ImagePicker.pickImage(source: ImageSource.gallery);

        setState(() {
          _image = image;
            print('Image Path $_image');
        });
  }
  
  @override
  Widget build(BuildContext context) {

  

double x = widget.x;
print(x);
_adressXController.text= x.toString();
double y = widget.y;
_adressYController.text= y.toString();
print(y);
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(child:   IconButton(icon: Icon(Icons.arrow_back,color: Colors.white,), onPressed: (){
                        Navigator.of(context).pop();
                      }),
        ),
        title: Text('Nouvel Offre ',style: TextStyle(fontFamily: 'poppins-regular',fontWeight: FontWeight.w500),),
      ),
      body: ListView(
        children: <Widget>[
          AddNvlOffre(),
          
        ],
      ),
    );
  }


    Widget AddNvlOffre() {
    return new Container(
      height:600,
      decoration: BoxDecoration(
        color:  Colors.cyan[200],
      ),
      child: new ListView(
        children: <Widget>[
         SizedBox(height: 50,),
          new Row(
            children: <Widget>[
              Container(
                padding:EdgeInsets.fromLTRB(5,0,10,0),
                child: Text('Supplémentaire',
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 18
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          new Center(
            child: _image == null
                ? Text('Aucune image séléctionné ! ')
                : Image.file(_image ,height: 250 ),

          ),
          FloatingActionButton(
            onPressed: getImage,
            tooltip: 'Pick Image',
            child: Icon(Icons.add_a_photo),
          ),



          new Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.only(left: 0.0, right: 0.0, top: 10.0),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                    color: Colors.teal,
                    width: 0.5,
                    style: BorderStyle.solid),
              ),
            ),
            padding: const EdgeInsets.only(left: 0.0, right: 10.0),
            child: new Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("La terrasse" ,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.teal,
                          fontSize: 15.0,
                          fontFamily: 'Quicksand'
                      ),
                    ),

                    Checkbox(
                      value: terrasse,
                      onChanged: (bool value) {
                        setState(() {
                          terrasse = value;
                        });
                      },
                    ),
                  ],
                ),
                SizedBox(width: 40),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("WIFI",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.teal,
                          fontSize: 15.0,
                          fontFamily: 'Quicksand'
                      ),
                    ),
                    Checkbox(
                      value: wifi,
                      onChanged: (bool value) {
                        setState(() {
                          wifi = value;
                        });
                      },
                    ),
                  ],
                ),
                SizedBox(width: 40),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("Lave-Linge",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.teal,
                          fontSize: 15.0,
                          fontFamily: 'Quicksand'
                      ),
                    ),
                    Checkbox(
                      value: laveLinge,
                      onChanged: (bool value) {
                        setState(() {
                          laveLinge = value;
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          Divider(
            height: 24.0,
          ),



         new Container(
           width: MediaQuery.of(context).size.width,
           margin: const EdgeInsets.only(left: 0.0, right: 0.0, top: 10.0),
           alignment: Alignment.center,
           decoration: BoxDecoration(
             border: Border(
               bottom: BorderSide(
                   color: Colors.teal,
                   width: 0.5,
                   style: BorderStyle.solid),
             ),
           ),
           padding: const EdgeInsets.only(left: 0.0, right: 10.0),
           child: new Row(
             crossAxisAlignment: CrossAxisAlignment.center,
             mainAxisAlignment: MainAxisAlignment.start,
             children: <Widget>[
               new Expanded(
                 child: TextField(
                  controller: _adressXController,
                  enabled: false,
                   style: TextStyle(
                       color: Colors.teal
                   ),
                   cursorColor: Colors.teal,
                   textAlign: TextAlign.left,

                   onChanged: (String str){
                     setState(() {
                       //_data.name = str;
                     });
                   },
                 ),
               ),
             ],
           ),
         ),
         Divider(
           height: 24.0,
         ),
                  new Container(
           width: MediaQuery.of(context).size.width,
           margin: const EdgeInsets.only(left: 0, right: 0, top: 10.0),
           alignment: Alignment.center,
           decoration: BoxDecoration(
             border: Border(
               bottom: BorderSide(
                   color: Colors.teal,
                   width: 0.5,
                   style: BorderStyle.solid),
             ),
           ),
           padding: const EdgeInsets.only(left: 0.0, right: 10.0),
           child: new Row(
             crossAxisAlignment: CrossAxisAlignment.center,
             mainAxisAlignment: MainAxisAlignment.start,
             children: <Widget>[
               new Expanded(
                 child: TextField(
                  controller: _adressYController,
                  enabled: false,
                   style: TextStyle(
                       color: Colors.teal
                   ),
                   cursorColor: Colors.teal,
                   textAlign: TextAlign.left,
                   decoration: InputDecoration(
                     border: InputBorder.none,
                     hintText: 'Adresse du logement Y ...',
                     hintStyle: TextStyle(color: Theme.of(context).accentColor,fontFamily: 'Quicksand'),
                   ),
                   onChanged: (String str){
                     setState(() {
                       //_data.name = str;
                     });
                   },
                 ),
               ),
             ],
           ),
         ),
         Divider(
           height: 24.0,
         ),
                  new Container(
           width: MediaQuery.of(context).size.width,
           margin: const EdgeInsets.only(left: 0.0, right: 0.0, top: 10.0),
           alignment: Alignment.center,
           decoration: BoxDecoration(
             border: Border(
               bottom: BorderSide(
                   color: Colors.teal,
                   width: 0.5,
                   style: BorderStyle.solid),
             ),
           ),
           padding: const EdgeInsets.only(left: 0.0, right: 10.0),
           child: new Row(
             crossAxisAlignment: CrossAxisAlignment.center,
             mainAxisAlignment: MainAxisAlignment.start,
             children: <Widget>[
               new Expanded(
                 child: TextField(
                  controller: _teleController,
                   style: TextStyle(
                       color: Colors.teal
                   ),
                   cursorColor: Colors.teal,
                   textAlign: TextAlign.left,
                   decoration: InputDecoration(
                     border: InputBorder.none,
                     hintText: 'Numero de telephone...',
                     hintStyle: TextStyle(color: Theme.of(context).accentColor,fontFamily: 'Quicksand'),
                   ),
                   onChanged: (String str){
                     setState(() {
                       //_data.name = str;
                     });
                   },
                 ),
               ),
             ],
           ),
         ),
         Divider(
           height: 24.0,
         ),


         new Container(
           width: MediaQuery.of(context).size.width,
           margin: const EdgeInsets.only(left: 0, right: 0, top: 10.0),
           alignment: Alignment.center,
           decoration: BoxDecoration(
             border: Border(
               bottom: BorderSide(
                   color: Colors.teal,
                   width: 0.5,
                   style: BorderStyle.solid),
             ),
           ),
           padding: const EdgeInsets.only(left: 0.0, right: 10.0),
           child: new Row(
             crossAxisAlignment: CrossAxisAlignment.center,
             mainAxisAlignment: MainAxisAlignment.start,
             children: <Widget>[
               new Expanded(
                 child: TextField(
                  controller: _superficieController,
                   style: TextStyle(
                       color: Colors.teal
                   ),
                   cursorColor: Colors.teal,
                   textAlign: TextAlign.left,
                   decoration: InputDecoration(
                     border: InputBorder.none,
                     hintText: 'La superficie en m2',
                     hintStyle: TextStyle(color: Theme.of(context).accentColor,fontFamily: 'Quicksand'),
                   ),
                   onChanged: (String str){
                     setState(() {
                       //_data.name = str;
                     });
                   },
                 ),
               ),
             ],
           ),
         ),
         Divider(
           height: 24.0,
         ),


         new Container(
           width: MediaQuery.of(context).size.width,
           margin: const EdgeInsets.only(left: 0.0, right: 0.0, top: 4.0),
           alignment: Alignment.center,
           decoration: BoxDecoration(
             border: Border(
               bottom: BorderSide(
                   color: Colors.teal,
                   width: 0.5,
                   style: BorderStyle.solid),
             ),
           ),
           padding: const EdgeInsets.only(left: 0.0, right: 10.0),
           child: new Row(
             crossAxisAlignment: CrossAxisAlignment.center,
             mainAxisAlignment: MainAxisAlignment.start,
             children: <Widget>[
               new Expanded(
                 child: TextField(
                   controller: _prixController,
                   style: TextStyle(
                       color: Colors.teal
                   ),
                   cursorColor: Colors.teal,
                   textAlign: TextAlign.left,
                   decoration: InputDecoration(
                     border: InputBorder.none,
                     hintText: 'Le prix de location (DH)',
                     hintStyle: TextStyle(color: Theme.of(context).accentColor,fontFamily: 'Quicksand'),
                   ),
                   onChanged: (String str){
                     setState(() {
                       //_data.name = str;
                     });
                   },
                 ),
               ),
             ],
           ),
         ),
         Divider(
           height: 24.0,
         ),






          new Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.only(left: 30.0, right: 30.0, top: 50.0),
            alignment: Alignment.center,
            child: new Row(
              children: <Widget>[
                new Expanded(
                  child: new FlatButton(
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30.0),
                    ),
                    color: Colors.teal,
                    onPressed: () {
                      suppls = [terrasse,wifi,laveLinge];

                      _addOffre(_adressXController.text,_adressYController.text,_teleController.text, _prixController.text,_superficieController.text,dropdownValue_capacite , suppls , _image);
                                          },
                                          child: new Container(
                                            padding: const EdgeInsets.symmetric(
                                              vertical: 15.0,
                                              horizontal: 20.0,
                                            ),
                                            child: new Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children:
                                              <Widget>[
                                                new Expanded(
                                                  child:Container(
                                                margin:const EdgeInsets.only(bottom:40),
                                            child:Text(
                                              "Ajouter",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: 'Quicksand'
                                              ),
                                            ),
                                            ),


                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                
                              ],
                            ),
                          );
                        }
                      
                        void  _addOffre(String adresseX,String adresseY,String tele, String prix,
                            String superficie, String capacite , List suppls ,File image) async{
                            Offre _offre =Offre();
                            FirebaseUser _firebaseUser = await _auth.currentUser();
                            _currentUser.uid = _firebaseUser.uid;

                            try{
                                  _offre.prix = prix;
                                  _offre.superficie = superficie;
                                  _offre.adresseX = adresseX; 
                                   _offre.adresseY = adresseY;
                                   _offre.tele =  tele ;      
                                  _offre.capacite = capacite;      
                                  _offre.supplimentaires = suppls;      
                                  _offre.image = image;      
                                  String _returnString = await OurDatabase().createOffre(_offre ,context,_currentUser.uid);                            
                            }catch(e){

                            }
                        }

}