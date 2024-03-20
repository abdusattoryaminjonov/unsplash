
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:unsplash/models/image_model.dart';

class CollectionPage extends StatefulWidget {
  const CollectionPage({super.key});

  @override
  State<CollectionPage> createState() => _CollectionPageState();
}

class _CollectionPageState extends State<CollectionPage> {

  String title = "Nature";

  _backToFinish(){
    print("Qayti");
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
          itemCount: imageList.length,
          itemBuilder: (context, index) => ImageCard(
            imageData: imageList[index],
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

  final ImageModel imageData;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      // decoration: BoxDecoration(
      //   borderRadius: BorderRadius.circular(20),
      //   gradient:LinearGradient(
      //       begin:Alignment.bottomRight,
      //       colors: [
      //         Colors.black.withOpacity(0.7),
      //         Colors.black.withOpacity(0.7),
      //         Colors.black.withOpacity(0.5),
      //         Colors.black.withOpacity(0.1),
      //       ]
      //   ),
      // ),
      child: Image.network(imageData.imageUrl, fit: BoxFit.cover),
    );
  }
}

