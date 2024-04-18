import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:http/http.dart' as http;


import '../models/postAPI_model.dart';

class PostApiView extends StatelessWidget {

  List<PostApiModel> postApi = [];

  Future<List<PostApiModel>> getApi() async {
    
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
    final data = jsonDecode(response.body.toString());

    if(response.statusCode == 200){
      postApi.clear();
      for(Map i in data) {
        postApi.add(PostApiModel.fromJson(i));
      }
      return postApi;
    }
    return postApi;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: "Post Api View".text.xl2.make().centered(),
      ),

      body: FutureBuilder(
        future: getApi(),

        builder: (context,snapShot){
          if(!snapShot.hasData){
            return "Loading".text.xl.make().centered();
          }else{
            return ListView.builder(itemBuilder: (context,index){
              return Card(
                color: Colors.red,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    "Id".text.xl2.bold.make(),
                    "${postApi[index].id}".text.make(),
                    "Title".text.xl2.bold.make(),
                    "${postApi[index].title}".text.make(),
                  "Body".text.xl2.bold.make(),
                    "${postApi[index].body}".text.make(),
                  ],
                ),
              );
            },itemCount: postApi.length,);
          }
        },
      ),
    );
  }
}
