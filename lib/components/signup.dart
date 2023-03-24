import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../utils/routes.dart';

class AddUser extends StatefulWidget {

  @override
  State<AddUser> createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {

  final TextEditingController _controllerName=TextEditingController();
  final TextEditingController _controllerRoll_no=TextEditingController();
  final TextEditingController _controllerHall=TextEditingController();
  final TextEditingController _controllerGithub_ID=TextEditingController();

  String name= "";
  bool changeButton = false;
  final _formKey = GlobalKey<FormState>();

  moveToHome(BuildContext) async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        changeButton = true;
      });

      await Future.delayed(const Duration(seconds: 1));
      // ignore: use_build_context_synchronously
      Navigator.pushNamed(context, MyRoutes.homeRoute);
      setState(() {
        changeButton = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Sign up",
        ),
      ),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Image.asset(
                  "assets/images/signup.png",
                  fit: BoxFit.cover,
                ),
                const SizedBox(height: 20),
                Text("Welcome $name!!", style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0 ),
                  child: Column(
                    children: [TextFormField(
                      controller: _controllerName,
                      decoration: const InputDecoration(
                        hintText: "Enter name",
                        labelText: "Name",
                      ),
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return "This field cannot be empty";
                        }
                         return null;
                      },
                      onChanged: (value) {
                        name = value;
                        setState(() {});
                      },
                    ),
                      TextFormField(
                        controller: _controllerRoll_no,
                        obscureText: true,
                        decoration: const InputDecoration(
                          hintText: "Enter roll no.",
                          labelText: "Roll no.",
                        ),
                        validator: (value) {
                          if(value == null || value.isEmpty ){
                            return "This field cannot be empty";
                          } else if(value.length<6){
                            return "Password cannot be less than 6 letters";
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: _controllerHall,
                        decoration: const InputDecoration(
                          hintText: "Enter Hall in format eg: Hall 3",
                          labelText: "Hall",
                        ),
                        validator: (value) {
                          if(value == null || value.isEmpty){
                            return "This field cannot be empty";
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: _controllerGithub_ID,
                        decoration: const InputDecoration(
                          hintText: "Enter github ID",
                          labelText: "Github",
                        ),
                        validator: (value) {
                          if(value == null || value.isEmpty){
                            return "This field cannot be empty";
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 40),

                Material(
                  color: Colors.deepOrangeAccent,
                  borderRadius: BorderRadius.circular(changeButton? 50:8),

                  child: TextButton(
                    onPressed: () {
                      Map<String, String>dataTosave = {
                        'Name': _controllerName.text,
                        'Roll_no': _controllerRoll_no.text,
                        'Hall': _controllerHall.text,
                        'Github_ID': _controllerGithub_ID.text,
                      };
                      if (_formKey.currentState!.validate()) {
                        FirebaseFirestore.instance.collection('users').add(
                            dataTosave);
                        Navigator.pushNamed(context, MyRoutes.homeRoute).then((
                            _) {});
                      }
                    },
                    child: const Text(
                      "Add User",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
    );
  }
}

