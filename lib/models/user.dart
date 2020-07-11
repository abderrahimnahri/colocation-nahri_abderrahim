import 'package:cloud_firestore/cloud_firestore.dart';

class OurUser{
  String uid;
  String email;
  String fullName;
  String phoneNumber;
  Timestamp accountCreated;
  

  OurUser({
    this.uid,
    this.email,
    this.fullName,
    this.phoneNumber,
    this.accountCreated,
  });

}