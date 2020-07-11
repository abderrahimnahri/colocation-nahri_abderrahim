import 'package:locprojet/screens/login/login.dart';
import 'package:locprojet/screens/root/root.dart';
import 'package:locprojet/states/currentUser.dart';
import 'package:locprojet/utils/ourTheme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create : (context) => CurrentUser(),
      child: MaterialApp(
        title: 'Flutter Demo',
        home: OurRoot(),
      ),
    );
  }
}
