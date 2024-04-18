import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:http/http.dart' as http;


class FetchApiWithoutModel extends StatelessWidget {
  const FetchApiWithoutModel({super.key});

  @override
  Widget build(BuildContext context) {
    
    var data;
    Future<void> getApi() async {
      
      final response =await http.get(Uri.parse("https://jsonplaceholder.typicode.com/users"));

      if(response.statusCode == 200){
        data = jsonDecode(response.body.toString());
      }
    }
    
    return FutureBuilder(future: getApi(),
        builder: (context,snapShot){
          if(snapShot.connectionState == ConnectionState.waiting){
            return CircularProgressIndicator();
          }else{
            return "${data[0]["name"]}".text.make();
          }
        }
    );
  }
}
