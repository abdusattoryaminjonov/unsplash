
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:unsplash/models/image_model.dart';
import 'package:unsplash/models/image_search_model.dart';

import '../services/http_service.dart';
import '../services/log_sevice.dart';

class CollectionPage extends StatefulWidget {
  const CollectionPage({super.key});

  @override
  State<CollectionPage> createState() => _CollectionPageState();
}

class _CollectionPageState extends State<CollectionPage> {

  bool isLoading = true;
  String title = "Nature";
  ImageModell? imageModell;
  List<Result> imageModelList = [];

  _apiImageSearchPhotos() async{
    var response = await Network.GET(Network.API_SEARCH_PHOTOS,Network.paramsSearch());
    LogService.d(response!);
    setState(() {
      imageModell = Network.parseImageModel(response);
      imageModelList = imageModell!.results;
    });
  }
  
  
  _backToFinish(){
    print("Qayti");
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _apiImageSearchPhotos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: Text(title, style: TextStyle(color: Colors.white),),
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios,color: Colors.white,),
            onPressed: () {
              _backToFinish();
            }
        ),
      ),

      body: Container(
        color: Colors.black,
        child: StaggeredGridView.countBuilder(
          crossAxisCount: 2,
          itemCount: imageModelList.length,
          itemBuilder: (context, index) => ImageCard(
            imageData: imageModelList[index],
          ),
          staggeredTileBuilder: (index) => StaggeredTile.fit(1),
          mainAxisSpacing: 2.0,
          crossAxisSpacing: 2.0,
        ),
      ),
    );
  }
}

class ImageCard extends StatelessWidget {
  const ImageCard({required this.imageData});

   final Result imageData;

  _callDetailsPage(){
    print("CLICK");
  }

 @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        _callDetailsPage();
      },
      child: Stack(
          children: [
            Image.network(imageData.urls.full, fit: BoxFit.cover),
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
                child: Text(imageData.user.username,style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
                ),
              ),
            ),
          ]
      )
    );
  }
}

