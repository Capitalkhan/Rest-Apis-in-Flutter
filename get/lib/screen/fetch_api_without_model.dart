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
    
    return Scaffold(

      body: FutureBuilder(future: getApi(),
          builder: (context,snapShot){
            if(snapShot.connectionState == ConnectionState.waiting){
              return CircularProgressIndicator().centered();
            }else{
              return ListView.builder(itemCount: data.length,itemBuilder: (context,index) {
                return Card(
                  color: Colors.blue,
                  child: Column(
                    children: [
                      ReuseableRow(title:"Name" , value: data[index]['name'],),
                      ReuseableRow(title:"Email" , value: data[index]['email'],),
                      ReuseableRow(title:"City" , value: data[index]['address']['city'],),
                      ReuseableRow(title:"Company Name" , value: data[index]['company']['name'],),
                    ],
                  ),
                );
              });

            }
          }
      )
    );
  }
}
class ReuseableRow extends StatelessWidget {
  final String title;
  final String value;

  ReuseableRow({required this.title,required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          "$title".text.make(),
          "$value".text.make(),
        ],
      ),
    );
  }
}
