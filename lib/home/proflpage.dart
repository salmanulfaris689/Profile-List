import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'liked_page.dart';
import 'package:pillsbee/model_clss.dart';
import 'package:like_button/like_button.dart';

class Homepage extends StatefulWidget {
  String? profileId;
  Homepage({Key? key,this.profileId}) : super(key: key);

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  bool isliked = false;

  Future<Profilemodel?> getUserData() async {
    var url = Uri.parse("https://dummyapi.io/data/v1/user/" +widget.profileId.toString());
    var response =
    await http.get(url, headers: {"app-id": "61855d9e2b97e51240f9f492"});
    if (response.statusCode == 200) {
      return Profilemodel.fromJson(jsonDecode(response.body));
    } else {
      print(response.body);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserData();
  }

  @override
  Widget build(BuildContext context) {
    final double size = 50;
    // LikeButton(
    //   size: size,
    //   isLiked: isliked,
    //   likeBuilder: (isliked) {
    //     final color = isliked ? Colors.red : Colors.grey;
    //     return Icon(
    //       Icons.favorite,
    //       color: color,
    //     );
    //   },
    // );
    return Scaffold(
      backgroundColor: Colors.cyan[100],
      appBar: AppBar(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30),
          ),
        ),
        title: const Text(
          'Details',
          style: TextStyle(
              fontSize: 30,
              color: Colors.white,
              fontWeight: FontWeight.bold,
              letterSpacing: 5),
        ),
        backgroundColor: Colors.cyan[400],
        centerTitle: true,
        elevation: 0,
      ),
      body: FutureBuilder<Profilemodel?>(
          future: getUserData(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var data = snapshot.data;
              return ListView.builder(
                  padding: const EdgeInsets.all(16.0),
                  physics: const BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics()),
                  itemCount: 1,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      margin: const EdgeInsets.only(bottom: 20),
                      height: 700,
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
                      child: Column(
                       //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //  crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: Column(
                              children: [
                                CircleAvatar(
                                  backgroundColor: Colors.blue,
                                  radius: 100,
                                  backgroundImage: NetworkImage(
                                    data!.picture.toString(),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 15),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          data.title.toString(),
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 30),
                                        ),
                                      ),
                                      Text(
                                        data!.firstName.toString(),
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 30),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          data.lastName.toString(),
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 30),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    data.email.toString(),
                                    style: TextStyle(
                                        fontWeight: FontWeight.normal,
                                        fontSize: 20),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    data.dateOfBirth.toString(),
                                    style: TextStyle(
                                        fontWeight: FontWeight.normal,
                                        fontSize: 20),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    data.gender.toString(),
                                    style: TextStyle(
                                        fontWeight: FontWeight.normal,
                                        fontSize: 20),
                                  ),
                                ),

                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    data.location.toString(),
                                    style: TextStyle(
                                        fontWeight: FontWeight.normal,
                                        fontSize: 20),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    data.phone.toString(),
                                    style: TextStyle(
                                        fontWeight: FontWeight.normal,
                                        fontSize: 20),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    data.registerDate.toString(),
                                    style: TextStyle(
                                        fontWeight: FontWeight.normal,
                                        fontSize: 20),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    data.updatedDate.toString(),
                                    style: TextStyle(
                                        fontWeight: FontWeight.normal,
                                        fontSize: 20),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );

                    /*Text(data!.firstName.toString()),
                          Text(data.lastName.toString()),
                          Text(data.email.toString()),
                          Text(data.location.toString()),
                          Text(data!.firstName.toString()),*/
                  });
            } else {
              return const Center(
                  child: CupertinoActivityIndicator(
                    animating: true,
                    radius: 20,
                  ));
            }
          }),
    );
  }
}