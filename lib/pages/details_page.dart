import 'package:flutter/material.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage({super.key});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {

  String username = "Lucas Gallone";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(username,style: TextStyle(color: Colors.white),),
        actions: [
          IconButton(
            onPressed: (){},
            icon: Icon(Icons.ios_share),
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}
