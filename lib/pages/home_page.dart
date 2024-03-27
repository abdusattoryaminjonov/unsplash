import 'package:cached_network_image/cached_network_image.dart';
import 'package:expandable_search_bar/expandable_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:http/http.dart';
import 'package:lottie/lottie.dart';
import 'package:unsplash/models/image_model.dart';
import 'package:unsplash/pages/details_page.dart';

import '../models/image_search_model.dart';
import '../services/http_service.dart';
import '../services/log_sevice.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController? searchController = TextEditingController();

  bool isLoading = true;
  String title = "Nature";
  ImageModell? imageModell;
  List<Result> imageModelList = [];

  _apiImageSearchPhotos() async{
    try {
      var response = await Network.GET(
          Network.API_SEARCH_PHOTOS, Network.paramsSearch());
      setState(() {
        imageModell = Network.parseImageModel(response!);
        imageModelList = imageModell!.results;
        isLoading = false;
      });
      LogService.d(response!);
    }catch (e){
      LogService.e(e.toString());
    }
  }

  Future _callDetailsPage(Result imageData) async {
    bool result = await Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
      return DetailsPage(imageModell:imageData);
    }));

    if (result) {
      _apiImageSearchPhotos();
    }
  }

  Future<void> _handleRefresh() async {
    _apiImageSearchPhotos();
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
        titleTextStyle: TextStyle(color: Colors.white),
        backgroundColor: Colors.black,
        title: Container(
          height: 50,
          padding: EdgeInsets.only(left: 10, right: 10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.white.withOpacity(0.2)),
          child: TextField(
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              icon: Icon(Icons.search,color: Colors.grey,),
                hintText: "Search photos, collections, users",
                border: InputBorder.none,
                hintStyle:
                TextStyle(fontSize: 15, color: Colors.grey)),
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.only(top: 10),
          color: Colors.black,
        child: Stack(
          children: [

          RefreshIndicator(
            onRefresh: _handleRefresh,
              child: StaggeredGridView.countBuilder(
                crossAxisCount: 2,
                itemCount: imageModelList.length,
                itemBuilder: (context, index) => ImageCard(
                  imageModelList[index],
                ),
                staggeredTileBuilder: (index) => StaggeredTile.fit(1),
                mainAxisSpacing: 1.1,
                crossAxisSpacing: 1.1,
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
  Widget ImageCard(Result imageData) {
    return GestureDetector(
        onTap: (){
          _callDetailsPage(imageData);
        },
        child: Stack(
            children: [
              Container(
                child: Hero(
                    tag: imageData.id,
                    child: CachedNetworkImage(
                      fit: BoxFit.cover,
                      imageUrl: imageData.urls.full,
                      placeholder: (context, url) =>Container(
                          padding: EdgeInsets.all(50),
                          child: Lottie.asset("assets/images/placeholder.json")
                      ),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                ),
              ),

              // Image.network(imageData.urls.full, fit: BoxFit.cover),
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
                      Text(imageData.user.name,style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                      ),
                      ),
                    ],
                  ),
                ),
              ),
            ]
        )
    );
  }

}

// class ImageCard extends StatelessWidget {
//   const ImageCard({required this.imageData});
//
//   final Result imageData;
//   @override
//
// }
