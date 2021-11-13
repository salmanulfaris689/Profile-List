import 'dart:async';
import 'dart:convert';

import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pillsbee/home/liked_page.dart';
import 'package:pillsbee/home/proflpage.dart';
import 'package:pillsbee/homemodel.dart';

class Homepag extends StatefulWidget {
  const Homepag({Key? key}) : super(key: key);

  @override
  _HomepagState createState() => _HomepagState();
}

class _HomepagState extends State<Homepag> with TickerProviderStateMixin {
  List<Color> colorList = [
    const Color(0xffD23756),
    const Color(0xff032340),
    const Color(0xffD23756),
    const Color(0xff2C0340),
    const Color(0xffD23756),
  ];
  List<Alignment> alignmentList = [Alignment.topCenter, Alignment.bottomCenter];
  int index = 0;
  Color bottomColor = const Color(0xffD23756);
  Color topColor = const Color(0xff092646);
  Alignment begin = Alignment.bottomCenter;
  Alignment end = Alignment.topCenter;

  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(microseconds: 0),
      () {
        setState(
          () {
            bottomColor = const Color(0xff33267C);
          },
        );
      },
    );
    getUserData();
  }

  Future<Homemodel?> getUserData() async {
    var url = Uri.parse("https://dummyapi.io/data/v1/user?page=1&limit=100");
    var response =
        await http.get(url, headers: {"app-id": "61855d9e2b97e51240f9f492"});
    if (response.statusCode == 200) {
      //print("ddd");
      return Homemodel.fromJson(jsonDecode(response.body));
    } else {
      // print(response.body);
    }
  }

  List Liked = [];

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(seconds: 2),
      onEnd: () {
        setState(
          () {
            index = index + 1;
            bottomColor = colorList[index % colorList.length];
            topColor = colorList[(index + 1) % colorList.length];
          },
        );
      },
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: begin,
          end: end,
          colors: [bottomColor, topColor],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
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
          backgroundColor: Colors.transparent,
          centerTitle: true,
          elevation: 0,
          automaticallyImplyLeading: false,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (builderContext) => Likespag(
                                liked: Liked,
                              )));
                },
                icon: const Icon(Icons.favorite),
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
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Homepage(
                                        profileId: data[index].id.toString(),
                                      )));
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
                            crossAxisAlignment: CrossAxisAlignment.start,
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
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "ID: "
                                        '${data[index].id}',
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          '${data[index].firstName}',
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            '${data[index].lastName}',
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        FavoriteButton(
                                          valueChanged: (_isFavourite) {
                                            setState(() {
                                              Liked.add(data[index].firstName);
                                            });
                                          },
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    });
              } else {
                return const Center(
                    child: CircularProgressIndicator(
                  color: Colors.white,
                  backgroundColor: Colors.grey,
                ));
              }
            }),
      ),
    );
  }
}
