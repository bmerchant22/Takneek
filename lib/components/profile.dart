import 'package:flutter/material.dart';

import '../utils/routes.dart';

class MyProfile extends StatelessWidget {

  MyProfile({required this.Name, required this.Roll_no, required this.Hall, required this.Github_ID});
  final Name;
  final Roll_no ;
  final Hall;
  final Github_ID;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
         alignment: Alignment.center,
         height:200,
         width: 100,
         decoration: BoxDecoration(
             border: Border.all(width: 5, color:Colors.grey),
           borderRadius: BorderRadius.circular(15),
         ),
         child: Row(
           mainAxisAlignment:MainAxisAlignment.start,
           crossAxisAlignment: CrossAxisAlignment.center,
           children: [
             Container(
               margin: const EdgeInsets.only(left:10,right: 10 ,top: 10,bottom: 10),
             width: 150,
             height: 150,
             decoration: const BoxDecoration(
               shape: BoxShape.circle,
               color: Colors.white,
               image: DecorationImage(
                   fit: BoxFit.fill,
                   image: NetworkImage('https://drive.google.com/uc?export=view&id=1S0TGvsRt36V1SZ7kcn4wOMZWBdY3aHEm'),
               ),
             ),
           ),
             Container(
               child: Column(
                 mainAxisAlignment: MainAxisAlignment.center,
                 crossAxisAlignment: CrossAxisAlignment.center,
                 children: [
                   Text(' Name: $Name \n Roll_no: $Roll_no \n Hall: $Hall \n Github: $Github_ID',
                   style: const TextStyle(
                     fontSize: 15,
                     fontFamily: "Raleway",
                     color: Colors.black,
                   ),
                   ),
                 ],
               ),
             ),
           ],
         ),
       ),
    );
  }
}
