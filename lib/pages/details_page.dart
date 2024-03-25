
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

   _infoImage(){
    showDialog(
        context: context,
        builder: (BuildContext context){
          return Container(
              width: 100,
              height: 100,
              child: AlertDialog(
                actions: [
                  Container(
                    padding: EdgeInsets.only(right: 35),
                    child:Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: 20,),
                        Container(
                          padding: EdgeInsets.all(5),
                          child: Text(_imgModell!.user.username,style: TextStyle(
                              overflow: TextOverflow.ellipsis,
                              fontSize: 10,
                            fontWeight: FontWeight.bold
                          ),)
                        ),
                        // SizedBox(height: 50,),
                        MaterialButton(
                            child:Container(
                                width: 100,
                                height: 40,
                                color: Colors.deepPurpleAccent,
                                child: Center(
                                  child: Text("pass",style: TextStyle(
                                    color: Colors.white,
                                  ),),
                                )
                            ),
                            onPressed: (){
                              Navigator.of(context).pop();
                            }),
                      ],
                    ),
                  )
                ],
              )
          );
        }
    );
  }

  _backToFinish(){
    Navigator.of(context).pop(true);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    username = widget.imageModell!.user.name;
    urlImg = widget.imageModell!.urls.full;
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
                            //   Show detailes Button
                          IconButton(
                            onPressed: (){
                              _infoImage();
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
