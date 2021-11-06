import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:like_button/like_button.dart';
import 'package:pillsbee/home/liked_page.dart';
import 'package:pillsbee/home/proflpage.dart';
import 'package:pillsbee/homemodel.dart';

class Homepag extends StatefulWidget {
  const Homepag({Key? key}) : super(key: key);

  @override
  _HomepagState createState() => _HomepagState();
}

class _HomepagState extends State<Homepag> {
  bool isliked = false;

  Future<Homemodel?> getUserData() async {
    var url = Uri.parse("https://dummyapi.io/data/v1/user?page=1&limit=100");
    var response =
    await http.get(url, headers: {"app-id": "61855d9e2b97e51240f9f492"});
    if (response.statusCode == 200) {
      print("ddd");
      return Homemodel.fromJson(jsonDecode(response.body));
    } else {
      print(response.body);
    }
  }
    List Liked = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserData();
  }

  @override
  Widget build(BuildContext context) {
    final double size = 50;
    LikeButton(
     // size: 30,
      isLiked: isliked,
      likeBuilder: (isliked) {
        final color = isliked ? Colors.red : Colors.grey;
        return Icon(
          Icons.favorite,
          color: color,size: 30,
        );
      },
    );
    return Scaffold(
      backgroundColor: Colors.cyan[100],
      appBar: AppBar(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30),
          ),
        ),
        title: const Text(
          'Profiles',
          style: TextStyle(
              fontSize: 30,
              color: Colors.white,
              fontWeight: FontWeight.bold,
              letterSpacing: 7),
        ),
        backgroundColor: Colors.cyan[400],
        centerTitle: true,
        elevation: 5,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (builderContext) => Likespag(
                      liked: Liked,
                    )));
              },
              icon: Icon(Icons.favorite),
              iconSize: 35,
              color: Colors.pink,
              alignment: Alignment.center,
            ),
          ),
        ],
      ),
      body: FutureBuilder<Homemodel?>(
          future: getUserData(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<Datum>? data = snapshot.data!.data;
              return ListView.builder(
                shrinkWrap: true,
                  padding: const EdgeInsets.all(16.0),
                  physics: const BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics()),
                  itemCount: data!.length,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>Homepage(profileId: data?[index].id.toString(),)));
                      },
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 20),
                        height: 150,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                            const BorderRadius.all(Radius.circular(20)),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 40,
                                  spreadRadius: 5),
                            ]),
                        child: Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //  crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  CircleAvatar(
                                    backgroundColor: Colors.grey[300],
                                    radius: 65,
                                    backgroundImage: NetworkImage(
                                      '${data[index].picture}',
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text( "ID: "
                                        '${data[index].id}',
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 15),
                                      child: Row(
                                        children: [
                                          Text(
                                            '${data[index].firstName}',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              '${data[index].lastName}',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                          Row(
                                            children: [
                                          //  LikeButton(),
                                              IconButton(
                                                onPressed: (){
                                                  setState(() {
                                                    Liked.add(data?[index].firstName);
                                                   // Liked.add(data?[index].lastName);
                                                  });
                                                },
                                                icon: Icon(Icons.favorite, color: Colors.pinkAccent,size: 40,),
                                              )
                                            ],
                                          )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  });
            } else {
              return Center(
                  child: CupertinoActivityIndicator(
                    animating: true,
                    radius: 20,
                  ));
            }
          }),
    );
  }
}