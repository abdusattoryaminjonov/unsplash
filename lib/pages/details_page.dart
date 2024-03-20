import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage({super.key});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {

  String username = "Lucas Gallone";
  String urlImg = "https://images.unsplash.com/photo-1493612276216-ee3925520721?q=80&w=1528&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text(username,style: TextStyle(color: Colors.white),),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: (){
            _backToFinish(){
              print("Qayti");
            }
          },
        ),
        actions: [
          IconButton(
            onPressed: (){},
            icon: Icon(Icons.ios_share),
            color: Colors.white,
          ),
        ],
      ),
      body: Column(
        children: [
          SizedBox(
              height: 50,
            child:Container(
              color: Colors.black,
            ),
          ),
          Expanded(
            child: Column(
              children: [

              ],
            )
          ),
          SizedBox(
              height: 20,
            child:Container(
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
