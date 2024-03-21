import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../models/image_model.dart';
class CollectionsPage extends StatefulWidget {
  const CollectionsPage({super.key});

  @override
  State<CollectionsPage> createState() => _CollectionsPageState();
}

class _CollectionsPageState extends State<CollectionsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        width: MediaQuery.of(context).size.width,
        child: StaggeredGridView.countBuilder(
          crossAxisCount: 1,
          //mainAxisCount:3,
          itemCount: imageList.length,
          itemBuilder: (context, index) => ImageCard(
            imageData: imageList[index],),
          staggeredTileBuilder: (index) => StaggeredTile.fit(1),
          mainAxisSpacing: 4.4,
          crossAxisSpacing: 2.0,

        ),
      ),
    );
  }
}

class ImageCard extends StatelessWidget {
  const ImageCard({required this.imageData});

  final ImageModel imageData;

  @override
  Widget build(BuildContext context) {
    return Center(
      // heightFactor: MediaQuery.of(context).size.height/3,
      child: ClipRRect(

        borderRadius: BorderRadius.circular(0.0),
        child: Image.network(imageData.imageUrl, fit: BoxFit.cover),
      ),
    );
  }
}