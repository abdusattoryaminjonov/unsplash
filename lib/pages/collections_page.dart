import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:lottie/lottie.dart';
import 'package:unsplash/models/image_collection_model.dart';
import 'package:unsplash/models/image_collections_model.dart';
import 'package:unsplash/pages/collection_page.dart';

import '../models/image_model.dart';
import '../services/http_service.dart';
import '../services/log_sevice.dart';

class CollectionsPage extends StatefulWidget {
  const CollectionsPage({super.key});

  @override
  State<CollectionsPage> createState() => _CollectionsPageState();
}

class _CollectionsPageState extends State<CollectionsPage> {

  bool isLoading = true;
  List<ImageCollections> imageCollections = [];

  _apiImageCollections() async{
    try {
      var response = await Network.GET(
          Network.API_COLLECTIONS, Network.paramsCollections());
      setState(() {
        imageCollections = Network.parseCollections(response!);
        isLoading = false;
      });
      LogService.d(response!);
    }catch (e){
      LogService.e(e.toString());
    }
  }

  Future _callCollectionPage(ImageCollections collections) async {
    bool result = await Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
      return CollectionPage(collections: collections);
    }));

    if (result) {
      _apiImageCollections();
    }
  }

  Future<void> _handleRefresh() async {
    _apiImageCollections();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _apiImageCollections();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black,
        title: Text("Unsplash",style: TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),),
        leading: GestureDetector(
          onTap: () {
            _apiImageCollections();
          },
          child: Container(
            padding: EdgeInsets.all(14),
            child: Image.asset(
              "assets/images/unsplash.png"
            ),
         ),
        ),
      ),
      body: Container(
        color: Colors.black,
        child: Stack(
          children: [
            RefreshIndicator(
              onRefresh: _handleRefresh,
              child: ListView.builder(
                itemCount: imageCollections.length,
                itemBuilder: (ctx, index) {
                  return _itemOfCollectons(imageCollections[index]);
                },
              ),
            ),
            isLoading
                ? Center(
              child: Lottie.asset("assets/images/loading.json",width: 150),
            )
                : SizedBox.shrink(),
          ],
        ),
      ),
    );
  }

  Widget _itemOfCollectons(ImageCollections imageCollections){
    return GestureDetector(
      onTap: (){
        _callCollectionPage(imageCollections);
      },
      child: Container(
        height: 300,
        child: Stack(
          children:[
            CachedNetworkImage(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.cover,
              imageUrl: imageCollections.coverPhoto.urls.full,
              placeholder: (context, url) =>Container(
                padding: EdgeInsets.all(80),
                  child: Lottie.asset("assets/images/placeholder.json")
              ),
              errorWidget: (context, url, error) => Icon(Icons.error),
          ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.bottomRight,
                      colors: [
                        Colors.black.withOpacity(0.9),
                        Colors.black.withOpacity(0.8),
                        Colors.black.withOpacity(0.7),
                        Colors.black.withOpacity(0.6),
                        Colors.black.withOpacity(0.5),
                        Colors.black.withOpacity(0.4),
                        Colors.black.withOpacity(0.3),
                        Colors.black.withOpacity(0.2),
                        Colors.black.withOpacity(0.1),
                        Colors.black.withOpacity(0.05),
                        Colors.black.withOpacity(0.02),
                      ]
                  ),
                ),
                child: Row(
                  children: [
                    Text(imageCollections.title,style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                    ),
                    ),
                  ],
                ),
              ),
            ),
         ]
        ),
      ),
    );
  }
}
