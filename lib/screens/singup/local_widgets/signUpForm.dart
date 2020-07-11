

import 'package:locprojet/screens/singup/singup.dart';
import 'package:locprojet/states/currentUser.dart';
import 'package:locprojet/widgets/ourContainer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OurSignUpForm extends StatefulWidget {
  @override
  _OurSignUpFormState createState() => _OurSignUpFormState();
}

class _OurSignUpFormState extends State<OurSignUpForm> {
  TextEditingController _mobileNumberController = TextEditingController();
  TextEditingController _fullNameController = TextEditingController();
  TextEditingController _emailNumberController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();

  void _signUpUser(String email, String password , BuildContext context,String fullname,String phonenumber) async{
    CurrentUser _currentUser = Provider.of<CurrentUser>(context, listen: false);
    
    try{
      String _returnString = await _currentUser.signUpUser(email, password,fullname,phonenumber);
      if(_returnString== "success"){
        Navigator.pop(context);
      }else{
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
      child :new Container(
        decoration: new BoxDecoration(color: Colors.lightBlueAccent,
            border:  Border.all(color:Colors.cyanAccent)),
    child :
      Column(
   children : <Widget>[
     Padding(padding: EdgeInsets.symmetric(vertical :0.0 ,horizontal:8.0),
     child: Text(
       "",

     ),
     ),
     TextFormField(
       controller: _fullNameController,
      decoration : InputDecoration(
        prefixIcon : Icon(Icons.person_outline),
        hintText:"Full name"),
     ),
      SizedBox(height : 20.0),
      TextFormField(
        controller: _mobileNumberController,
          decoration : InputDecoration(
            prefixIcon : Icon(Icons.confirmation_number),
            hintText:"Mobile Number"),
      ),
       SizedBox(height : 20.0),
        TextFormField(
          controller: _emailNumberController,
          decoration : InputDecoration(
            prefixIcon : Icon(Icons.alternate_email),
            hintText:"Email"),
        ),
        SizedBox(height : 20.0),
        TextFormField(
         controller: _passwordController,
         decoration : InputDecoration(
           prefixIcon : Icon(Icons.lock_outline),
           hintText:"Password"),
            obscureText: true,
         ),
        SizedBox(height : 20.0),
        TextFormField(
          controller: _confirmPasswordController,
         decoration : InputDecoration(
           prefixIcon : Icon(Icons.lock_open),
           hintText:"Confirme Password"),
          obscureText: true,
         ),
         SizedBox(height : 0.0),

         RaisedButton(child: Padding(padding: EdgeInsets.symmetric(horizontal : 30 ),
         child : Text("Sign Up" , 
         style: TextStyle(
         color : Colors.black,
         fontWeight: FontWeight.bold,
         fontSize: 20.0,
        ),
        ),
        ),
         onPressed: (){
           if(_passwordController.text == _confirmPasswordController.text){
             _signUpUser(_emailNumberController.text, _passwordController.text,context,_fullNameController.text,_mobileNumberController.text);
           }else{
             Scaffold.of(context).showSnackBar(
               SnackBar(content: Text("Password do not match"),
               duration: Duration(seconds: 2),
               )
             );
           }
         },
         ),


],
)),
);

    
  }
}