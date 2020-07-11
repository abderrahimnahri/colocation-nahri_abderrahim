
import 'package:flutter/material.dart';

import 'local_widgets/signupForm.dart';



class OurSignUp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child:
          new Container(
          decoration: new BoxDecoration(color: Colors.cyan[200]),
          child :
            ListView(
              padding: EdgeInsets.all(20.0),
              children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  BackButton(),
                ],
              ),
            SizedBox(height : 40.0,),
            OurSignUpForm(),
           
              ],
            ),)
          )
        ],
      ),
    );
  }
}