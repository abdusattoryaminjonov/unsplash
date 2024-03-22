import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:lottie/lottie.dart';
import 'package:unsplash/models/image_collections_model.dart';

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
    var response = await Network.GET(Network.API_COLLECTIONS,Network.paramsCollections());
    print(response);
    LogService.d(response!);
    setState(() {
      imageCollections = Network.parseCollections(response);
      isLoading = false;
    });

  }

  _callCollectionPage(){

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
      body: Stack(
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
    );
  }

  Widget _itemOfCollectons(ImageCollections imageCollections){
    return GestureDetector(
      onTap: _callCollectionPage(),
      child: Container(
        child: CachedNetworkImage(
          fit: BoxFit.cover,
          imageUrl: imageCollections.coverPhoto.urls.full,
          placeholder: (context, url) => Image(
              image: AssetImage("assets/images/placeholder.png"),
              fit: BoxFit.cover
          ),
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),
      ),
    );
  }
}
