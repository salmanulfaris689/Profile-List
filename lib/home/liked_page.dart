import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LikedModel {
  LikedModel({this.id, this.name,});
  int? id;
  String? name;
}

class Likespag extends StatefulWidget {
  List? liked;
  LikedModel? aa;
  Likespag({Key? key, this.liked}) : super(key: key);

  @override
  _LikespagState createState() => _LikespagState();
}

class _LikespagState extends State<Likespag> {
  /*Future<Profilemodel?> getUserData() async {
    var url = Uri.parse("https://dummyapi.io/data/v1/user?page=1&limit=100");
    var response =
        await http.get(url, headers: {"app-id": "61855d9e2b97e51240f9f492"});
    if (response.statusCode == 200) {
      return Profilemodel.fromJson(jsonDecode(response.body));
    } else {
      print(response.body);
    }
  }*/

  /* @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserData();
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyan[100],
      appBar: AppBar(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30),
          ),
        ),
        title: const Text(
          "Liked Profiles",
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              letterSpacing: 5),
        ),
        backgroundColor: Colors.cyan[400],
        centerTitle: true,
        elevation: 0,
      ),
      body:  ListView.builder(
          itemCount: widget.liked!.length,
          itemBuilder: (context,index) {

            return SizedBox(
                height: 20,
                child: Text(widget.liked![index]));
          }
      )
    );
  }
}
