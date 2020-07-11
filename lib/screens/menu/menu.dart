import 'package:locprojet/screens/home/home.dart';
import 'package:locprojet/screens/root/root.dart';
import 'package:locprojet/states/currentUser.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:locprojet/screens/demandes/listedemandes.dart';
import 'package:locprojet/screens/map_form/mapFrom.dart';
import '';


import 'package:provider/provider.dart';

import '../../main.dart';


class Menu extends StatefulWidget {
  @override
  _MenuState createState() => _MenuState();
}


class _MenuState extends State<Menu> {

  /*  else if(Provider.of<Tabs>(context).currentIndex== 1) {
      return Saved();
    }
    else if(Provider.of<Tabs>(context).currentIndex == 2) {
      return Bookings();
    } */
  
    
  
    Logout() async{
     CurrentUser _currentUser= Provider.of<CurrentUser>(context,listen:false);
     String _returnString = await _currentUser.signOut();
     if(_returnString =="success"){
Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=> OurRoot()
), (route) => false);
     }

   }
   double _width;
  double _height;
     @override
  Widget build(BuildContext context) {
    
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
    statusBarColor: Colors.deepPurpleAccent));
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    return CupertinoTabScaffold(

      tabBar: CupertinoTabBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.home),
            title: Text('Products'),

          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.home),
            title: Text('MAPS'),
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.home),
            title: Text('les demandes'),
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.home),
            title: Text('Logout'),
          ),
        ],
      ),
      tabBuilder: (context, index) {
        CupertinoTabView returnValue;
        switch (index) {
          case 0:
            returnValue = CupertinoTabView(builder: (context) {
              return CupertinoPageScaffold(
                child:  HomeScreen(),
                
              );
            });
            break;
          case 1:
            returnValue = CupertinoTabView(builder: (context) {
              return CupertinoPageScaffold(
                child: RunMap(),
              );
            });
            break;
        
              case 2:
            returnValue = CupertinoTabView(builder: (context) {
              return CupertinoPageScaffold(
                child: Listdemandes(),
              );
            });
            break; 
              case 3:
            returnValue = CupertinoTabView(builder: (context) {
              return CupertinoPageScaffold(
                child: Logout(),
              );
            });
            break;
        }
        return returnValue;
      },
    );
  }

}