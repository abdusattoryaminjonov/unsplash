import 'package:expandable_search_bar/expandable_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:unsplash/models/image_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController? searchController = TextEditingController();

  String title = "Nature";

  _backToFinish() {
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

                 hintText: "Search somethin",
                 editTextController: searchController,
               ),
             ),
           ),
        //   backgroundColor: Colors.black,
        //   centerTitle: true,
        //
        //   // title: Text(title, style: TextStyle(color: Colors.white),),
        //   // leading: IconButton(
        //   //     icon: Icon(Icons.arrow_back_ios,color: Colors.white,),
        //   //     onPressed: () {
        //   //       _backToFinish();
        //   //     }
        //   // ),
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
                mainAxisSpacing: 1.1,
                crossAxisSpacing: 1.1,
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
      borderRadius: BorderRadius.circular(0.0),
      child: Image.network(imageData.imageUrl, fit: BoxFit.cover),
    );
  }
}
