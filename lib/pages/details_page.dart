import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:unsplash/models/image_collection_model.dart';
import 'package:unsplash/models/image_search_model.dart';

import '../models/image_collections_model.dart';

class DetailsPage extends StatefulWidget {
  final Result? imageModell;
  final PreviewPhoto? previewPhoto;

  const DetailsPage({super.key, this.imageModell,this.previewPhoto});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {

  String username ="";
  String urlImg = "";
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
                          IconButton(
                            onPressed: (){},
                            icon: Icon(Icons.info_outline,color: Colors.white,size: 30,),
                          ),
                          IconButton(
                            onPressed: (){},
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
