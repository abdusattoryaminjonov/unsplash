import 'dart:typed_data';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:lottie/lottie.dart';
import 'package:unsplash/models/image_collection_model.dart';
import 'package:unsplash/models/image_search_model.dart';
import 'package:http/http.dart' as http;
import '../models/image_collections_model.dart';

class DetailsPage extends StatefulWidget {
  final Result? imageModell;
  final PreviewPhoto? previewPhoto;

  const DetailsPage({Key? key, this.imageModell, this.previewPhoto}) : super(key: key);

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  String username = "";
  String urlImg = "";

  _dialogsaveImage() {
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

  late Uint8List _imageBytes = Uint8List(0);

  Future<void> loadImage() async {
    var response = await http.get(Uri.parse(urlImg));
    setState(() {
      _imageBytes = response.bodyBytes;
    });
  }

  Future<void> _downloadImage(Uint8List url) async {
    if (_imageBytes.isNotEmpty) {
      bool result = await ImageGallerySaver.saveImage(url);

      if (result) {
        _dialogsaveImage();
      }
    } else {
      print('Image bytes are empty, cannot download.');
      // You can show a message or handle this case as needed.
    }
  }

  _backToFinish() {
    Navigator.of(context).pop(true);
  }

  @override
  void initState() {
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
        title: Text(
          username,
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () {
            _backToFinish();
          },
        ),
        actions: [
          IconButton(
            onPressed: () {},
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
                      fit: BoxFit.cover,
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
                      padding: EdgeInsets.symmetric(vertical: 30, horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.info_outline, color: Colors.white, size: 30),
                          ),
                          IconButton(
                            onPressed: () {
                              _downloadImage(_imageBytes);
                            },
                            icon: Icon(Icons.download_for_offline_outlined, color: Colors.white, size: 40),
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
