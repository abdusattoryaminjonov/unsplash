import 'package:expandable_search_bar/expandable_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:http/http.dart';
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

  apiImageSearchPhotos() async{
    var response = await Network.GET(Network.API_SEARCH_PHOTOS,Network.paramsSearch());
    LogService.d(response!);
    setState(() {
      imageModell = Network.parseImageModel(response);
      imageModelList = imageModell!.results;
    });
  }

  _backToFinish() {
    print("Qayti");
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    apiImageSearchPhotos();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleTextStyle: TextStyle(color: Colors.white),
        backgroundColor: Colors.black,
        title: Container(
          child: Center(
            child: ExpandableSearchBar(
              backgroundColor: Colors.white,
              iconColor: Colors.white,
              iconBackgroundColor: Colors.black,
              width: MediaQuery.of(context).size.width,
              onTap: () {
                print(searchController!.text.toString());
              },
              hintText: "Search something",
              editTextController: searchController,
            ),
          ),
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
          mainAxisSpacing: 1.1,
          crossAxisSpacing: 1.1,
        ),
      ),
    );
  }
}

class ImageCard extends StatelessWidget {
  const ImageCard({required this.imageData});

  // Future _callDetailsPage(ImageModel imageModel) async {
  //   bool result = await Navigator.of(context)
  //       .push(MaterialPageRoute(builder: (BuildContext context) {
  //     return DetailsPage(: post);
  //   }));
  //
  //   if (result) {
  //     _HomePageState().apiImageSearchPhotos();
  //   }
  // }

  final Result imageData;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: (){
          //_callDetailsPage();
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
