
import 'dart:io';
import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:lottie/lottie.dart';
import 'package:unsplash/models/image_search_model.dart';
import 'package:http/http.dart' as http;
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

   _dialogsaveImage(){
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          actions: [
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 10),
                  Container(
                    padding: EdgeInsets.all(50),
                    child: Lottie.asset("assets/images/downloade.json"),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Success!",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            )
          ],
        );
      },
    );
  }

  late Uint8List _imageBytes;

  Future<void> loadImage() async {
    var response = await http.get(Uri.parse(urlImg));

    setState(() {
      _imageBytes = response.bodyBytes;
    });

  }

  Future<void> _downloadImage(Uint8List url) async {
    bool result = await ImageGallerySaver.saveImage(url);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Downloaded to Gallery!")),
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
                        SizedBox(height: 50,),
                        Container(
                          child: Text(_imgModell!.user.name,style: TextStyle(
                              fontSize: 20,
                            fontWeight: FontWeight.bold
                          ),)
                        ),
                        SizedBox(height: 50,),
                        // Text(_imgModell!.user.name,style: TextStyle(
                        //     fontSize: 20,
                        //     fontWeight: FontWeight.bold
                        // ),),
                        // Text(_imgModell!.user.username,style: TextStyle(
                        //     fontSize: 15
                        // ),),
                        // Text(_imgModell!.user.bio!,style: TextStyle(
                        //     fontSize: 15,
                        //    overflow: TextOverflow.ellipsis,
                        // ),),
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

  // _shareNetworkImage(String url) async{
  //   final uri = Uri.parse(url);
  //   final response = await http.get(uri);
  //   final imageBytes = response.bodyBytes;
  //   final t = await getTemporaryDirectory();
  //   final path = '${t.path}/sharedImage.jpg';
  //   File(path).writeAsBytesSync(imageBytes);
  //
  // }

  _backToFinish(){
    Navigator.of(context).pop(true);
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadImage();
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
          IconButton(
            onPressed: (){
              // _shareNetworkImage(urlImg);
            },
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
                          IconButton(
                            onPressed: (){
                              _infoImage();
                            },
                            icon: Icon(Icons.info_outline,color: Colors.white,size: 30,),
                          ),
                          IconButton(
                            onPressed: (){
                              _downloadImage(_imageBytes);
                            },
                            icon: Icon(Icons.download_for_offline_outlined,color: Colors.white,size: 40,),
                          ),
                          // Container(
                          //   margin: EdgeInsets.only(bottom: 30,right: 20),
                          //   decoration: BoxDecoration(
                          //     color: Colors.white,
                          //     shape: BoxShape.circle,
                          //   ),
                          // )
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
