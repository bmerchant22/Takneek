import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:myfirstapp_bm/components/profile.dart';
import 'package:myfirstapp_bm/components/signup.dart';
import 'package:myfirstapp_bm/utils/routes.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
      );
  runApp(const MyApp());
}

class SignupButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextButton(
        child: const Text(
          "Sign up",
          style: TextStyle(
            fontSize: 18,
            color: Colors.white,
          ),
        ),
        onPressed: () => Navigator.pushNamed(context, MyRoutes.signupRoute),
      ),
    );
  }
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(60.0),
          child: AppBar(
            actions: [SignupButton()],
            title: const Text(
              'Student Data',
              style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w600
              ),
            ),
            backgroundColor: Colors.red,
          ),
        ),
        body: fetchData(),
      ),
       //initialRoute: MyRoutes.homeRoute,
      routes: {
        MyRoutes.homeRoute: (context)=> fetchData(),
        MyRoutes.signupRoute: (context)=> AddUser(),
      },
    );
  }
}

fetchData() {
  final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance.collection('users').snapshots();

  return StreamBuilder<QuerySnapshot>(
    stream: _usersStream,
    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
      if (snapshot.hasError) {
        debugPrint("error in fetching data : $snapshot ");
        return const Text('Something went wrong');
      }

      if (snapshot.connectionState == ConnectionState.waiting) {
        return const Text("Loading");
      }

      return ListView(
        children: snapshot.data!.docs.map((DocumentSnapshot document) {
          Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
          return MyProfile(Name: data["Name"],Roll_no: data["Roll_no"],Hall: data["Hall"],Github_ID: data["Github_ID"],);
        }).toList(),
      );
    },
  );
}