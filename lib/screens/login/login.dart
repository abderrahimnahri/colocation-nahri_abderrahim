
import 'package:flutter/material.dart';

import 'local_widgets/loginForm.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child : new Container(
          decoration: new BoxDecoration(color: Colors.cyan[200]),
          child :

            ListView(
              padding: EdgeInsets.all(20.0),
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(40.0),
                  child: Text("colocApp"),
                ),
                SizedBox(
                  height: 20.0,
                ),
                OurLoginForm(),

              ],
            ),
          ))
        ],
      ),
    );
  }
}