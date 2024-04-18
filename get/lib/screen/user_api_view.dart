import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:http/http.dart' as http;

import '../models/userAPI_model.dart';


class UserApiView extends StatelessWidget {

  
  List<UserApiModel> userApiList = [];
  
  Future<List<UserApiModel>> getApi() async {
    
    final response = await http.get(Uri.parse("https://jsonplaceholder.typicode.com/users"));
    final data = jsonDecode(response.body.toString());

    if(response.statusCode == 200){
      userApiList.clear();
      for(Map i in data){
        userApiList.add(UserApiModel.fromJson(i));
      }
      return userApiList;
    }
    return userApiList;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: "User Api View".text.xl3.make().centered(),
      ),

     body: FutureBuilder(future: getApi(),
         builder: (context,snapShot){
            if(!snapShot.hasData){
              return "Loading".text.make().centered();
            }else{
              return ListView.builder(
                itemCount: userApiList.length,
                itemBuilder:(context,index) => Card(
                  color: Colors.cyanAccent,
                  child: Column(
                    children: [

                      "${snapShot.data?[index].id}".text.make(),
                      "${snapShot.data?[index].address?.street}".text.make(),
                      "${snapShot.data?[index].address?.geo?.lat}".text.make(),
                    ],
                  ),
                ),
              );
            }
         }
     ),
      
    );
  }
}
