import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:locprojet/screens/fromOffre/nvl_offre.dart';
class HomeScreen extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();

}

class _HomeState extends State<HomeScreen> {
  double _width;
  double _height;

  @override
  void initState() {
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;


    return NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(

              expandedHeight: _height/9,
              floating: false,
              pinned: true,
              backgroundColor: Colors.blueAccent,
              //#f02730
              flexibleSpace: FlexibleSpaceBar(
                collapseMode: CollapseMode.parallax,
                centerTitle: true,
                titlePadding: EdgeInsets.only(top: 30.0),
                title: Center(
                  child: Text(
                    "les offres ",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'poppins-regular',
                        fontSize: 22),
                  ),
                ),
              ),

            ),
          ];
        },
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[



              Padding(
                padding: EdgeInsets.only(top: 20, left: 10, right: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                   SizedBox(height:20),
               StreamBuilder<QuerySnapshot>(
                stream: Firestore.instance.collection("offres").snapshots(),
                builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) return new Text('${snapshot.error}');
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                      return new Center(child: new CircularProgressIndicator());
                    default:

                      return Card(
                        child: Column(
                          children: <Widget>[
                            ListView(
                              shrinkWrap: true,
                              children: snapshot.data.documents.map(
                                (DocumentSnapshot document) {
                                  return  itemCard( document['prix'],document['image'],false);
                                },
                              ).toList(),
                            ),
                          ],
                        ),
                      );
                  }
                },
              ),






                  ],
                ),
              ),
            ],
          ),
        )
    );
  }



  Widget itemCard(String title, String imgPath, bool isFavorite) {
  return  GestureDetector (

    child: Column(
      children: <Widget>[
        Padding(
        padding: EdgeInsets.only(left: 8.0, right: 8.0, top: 10.0),
        child: Container(

        height: 120.0,
        width: double.infinity,
        //color: Colors.white,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            color: Colors.white
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[


          ClipRRect(
            borderRadius: BorderRadius.circular(100.0),
                        child: Image.network(imgPath,
                                              fit: BoxFit.cover,
                                              width: 150,

                                            ),
          ),

          SizedBox(width: 4.0),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              SizedBox(height: 10,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    ' le prix :'+title+ 'DH',
                    style: TextStyle(
                        fontFamily: 'Quicksand',
                        fontSize: 17.0,
                        color: Colors.black87,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 5.0),
                  Container(
                    width: 175.0,
                    child: Text(
                      'telephone : 0666666',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontFamily: 'Quicksand',
                          color: Colors.grey,
                          fontSize: 12.0),
                    ),
                  ),
                ],
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    height: 40.0,
                    width: 70.0,
                    child: Center(
                      child: Text(
                        '',
                        style: TextStyle(
                            color: Colors.black87,
                            fontFamily: 'Quicksand',
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  SizedBox(width: 20.0),



                ],

              )
            ],
          )
        ],

      ),

    ),
  ),
  ],
 ),

 );
}


}




