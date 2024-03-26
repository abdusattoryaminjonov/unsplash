import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:lottie/lottie.dart';
import 'package:unsplash/models/image_collection_model.dart';
import 'package:unsplash/models/image_model.dart';
import 'package:unsplash/models/image_search_model.dart';

import '../models/image_collections_model.dart';
import '../services/http_service.dart';
import '../services/log_sevice.dart';
import 'details_page.dart';

class CollectionPage extends StatefulWidget {

  final ImageCollections collections;

  const CollectionPage({super.key,required this.collections});

  @override
  State<CollectionPage> createState() => _CollectionPageState();
}

class _CollectionPageState extends State<CollectionPage> {

  bool isLoading = true;
  String title = "";
  List<ImageCollection>? imageCollection;
  List<PreviewPhoto> previewPhotos = [];
  String? id;

  _apiCollection() async{
    try {
      setState(() {
        id = widget.collections.id;
        title = widget.collections.title;
      });
      var response = await Network.GET(
          Network.API_COLLECTIONS_ID.replaceFirst(':id', '${id}'),
          Network.paramsCollection());
      setState(() {
        imageCollection = Network.parseCollection(response!);
      });
      LogService.d(response!);
    }catch (e){
      LogService.e(e.toString());
    }
  }

  Future _callDetailsPage(PreviewPhoto previewPhoto) async {
    bool result = await Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
      return DetailsPage(previewPhoto:previewPhoto);
    }));

    if (result) {
      _apiCollection();
    }
  }



  _backToFinish(){
    Navigator.of(context).pop(true);
  }

  Future<void> _handleRefresh() async {
    _apiCollection();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _apiCollection();
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
        padding: EdgeInsets.only(top: 10),
        color: Colors.black,
        child: Stack(
          children: [
            RefreshIndicator(
              onRefresh: _handleRefresh,
              child: StaggeredGridView.countBuilder(
                crossAxisCount: 2,
                itemCount: previewPhotos.length,
                itemBuilder: (context, index) => ImageCard(
                  previewPhotos[index],
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

  Widget ImageCard(PreviewPhoto previewPhoto) {
    return GestureDetector(
        onTap: (){
          _callDetailsPage(previewPhoto);
        },
        child: Image.network(previewPhoto.urls.full, fit: BoxFit.cover),
    );
  }
}
