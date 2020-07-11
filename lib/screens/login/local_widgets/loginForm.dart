

import 'package:locprojet/screens/home/home.dart';
import 'package:locprojet/screens/menu/menu.dart';
import 'package:locprojet/screens/singup/singup.dart';
import 'package:locprojet/states/currentUser.dart';
import 'package:locprojet/widgets/ourContainer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OurLoginForm extends StatefulWidget {
  @override
  _OurLoginFormState createState() => _OurLoginFormState();
}

class _OurLoginFormState extends State<OurLoginForm> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  
  void _loginUser(String email, String password , BuildContext context) async{
    CurrentUser _currentUser = Provider.of<CurrentUser>(context, listen: false);
    try{
         String _returnString = await _currentUser.loginUser(email, password);
      if(_returnString== "success"){
        Navigator.of(context).push(
          MaterialPageRoute(
          builder: (context)=> Menu(),
          ),
        );
      } else{
        Scaffold.of(context).showSnackBar(
               SnackBar(content: Text(_returnString),
               duration: Duration(seconds: 2),
               )
             );

      }
    }
    catch(e){

    }
  }
  @override
  Widget build(BuildContext context) {
    return OurContainer(
      child : new Container(
        decoration: new BoxDecoration(color: Colors.lightBlueAccent),
        child :
        Column(
          children : <Widget>[
            Padding(padding: EdgeInsets.symmetric(vertical :0 ,horizontal:0.0),
              child: Text(

                  "",
                  style : TextStyle(
                    color : Theme.of(context).secondaryHeaderColor,
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold,
                  )
              ),
            ),
            TextFormField(
              controller: _emailController,
              decoration : InputDecoration(prefixIcon : Icon(Icons.alternate_email), hintText:"Email"),
            ),
            SizedBox(height : 20.0),
            TextFormField(
              controller: _passwordController,
              decoration : InputDecoration(prefixIcon : Icon(Icons.text_fields), hintText:"Password"),
              obscureText: true,
            ),
            SizedBox(height : 20.0),
            RaisedButton(child: Padding(padding: EdgeInsets.symmetric(horizontal : 30 ),
              child : Text("Log In" ,
                style: TextStyle(
                  color : Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                ),),
            ),
              onPressed: (){
                _loginUser(_emailController.text , _passwordController.text, context);
              },
            ),
            FlatButton(
              child : Text("creer un compte"),
              materialTapTargetSize:  MaterialTapTargetSize.shrinkWrap,
              onPressed: (){
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context)=> OurSignUp(),
                  ),
                );
              },)

          ],
        ),
      )


);

    
  }
}