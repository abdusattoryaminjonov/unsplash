
import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:lottie/lottie.dart';
import 'package:unsplash/models/image_collection_model.dart';
import 'package:unsplash/models/image_search_model.dart';
import 'package:http/http.dart' as http;
import 'package:unsplash/services/log_sevice.dart';
import '../models/image_collections_model.dart';

class DetailsPage extends StatefulWidget {
  final Result? imageModell;
  final PreviewPhoto? previewPhoto;

  const DetailsPage({super.key, this.imageModell,this.previewPhoto});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {

  Result? _imgModell;
  String username ="";
  String urlImg = "";
            //  saveNetworkImage function to save url image

  _saveNetworkImage() async {
    var response = await Dio().get(urlImg,
        options: Options(responseType: ResponseType.bytes));
    final result = await ImageGallerySaver.saveImage(
        Uint8List.fromList(response.data),
        quality: 60,
        name: "hello");
    LogService.i(result);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Image saved!!!",style: TextStyle(
        color: Colors.black26,
        fontSize: 20,
      ),)),
    );
  }


  _backToFinish(){
    Navigator.of(context).pop(true);
  }

  _infoData(){
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context){
      return Container(
        padding: EdgeInsets.all(10),
        width: MediaQuery.of(context).size.width/2,
        height: MediaQuery.of(context).size.height/3,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                child: Text(_imgModell!.user.username,style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),),
              ),
              Container(
                  child:Text(_imgModell!.altDescription,style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),),
              )
            ],
          ),
        ),
      );
    });
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _imgModell = widget.imageModell;
    username = _imgModell!.user.name;
    urlImg = _imgModell!.urls.full;
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
            icon: Icon(Icons.arrow_back_ios,color: Colors.white,),
            onPressed: () {
              _backToFinish();
            }
        ),
        actions: [

          //   Share button
          IconButton(
            onPressed: (){},
            icon: Icon(Icons.ios_share),
            color: Colors.white,
          ),
        ],
      ),
      body: Column(
        children: [

          Expanded(
            child: Stack(
              children: [
                Container(
                  child: new CachedNetworkImage(
                    imageUrl: urlImg,
                    placeholder: (context, url) => Image(
                        image: AssetImage("assets/images/placeholder.png"),
                        fit: BoxFit.cover
                    ),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.cover,
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 30,horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                            //   SImage info Button
                          IconButton(
                            onPressed: (){
                              _infoData();
                            },
                            icon: Icon(Icons.info_outline,color: Colors.white,size: 30,),
                          ),
                            //   Save Button
                          IconButton(
                            onPressed: (){
                              _saveNetworkImage();
                            },
                            icon: Icon(Icons.download_for_offline_outlined,color: Colors.white,size: 40,),
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              ],
            )
          ),
        ],
      ),
    );
  }
}
