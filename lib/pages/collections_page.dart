
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

  List<ImageModel> imageList = [
    ImageModel(
      id: 'id-001',
      imageUrl: 'https://picsum.photos/seed/image001/500/500',
    ),
    ImageModel(
      id: 'id-002',
      imageUrl: 'https://picsum.photos/seed/image002/500/800',
    ),
    ImageModel(
      id: 'id-003',
      imageUrl: 'https://picsum.photos/seed/image003/500/300',
    ),
    ImageModel(
      id: 'id-004',
      imageUrl: 'https://picsum.photos/seed/image004/500/900',
    ),
    ImageModel(
      id: 'id-005',
      imageUrl: 'https://picsum.photos/seed/image005/500/600',
    ),
    ImageModel(
      id: 'id-006',
      imageUrl: 'https://picsum.photos/seed/image006/500/500',
    ),
    ImageModel(
      id: 'id-007',
      imageUrl: 'https://picsum.photos/seed/image007/500/400',
    ),
    ImageModel(
      id: 'id-008',
      imageUrl: 'https://picsum.photos/seed/image008/500/700',
    ),
    ImageModel(
      id: 'id-009',
      imageUrl: 'https://picsum.photos/seed/image009/500/600',
    ),
    ImageModel(
      id: 'id-010',
      imageUrl: 'https://picsum.photos/seed/image010/500/900',
    ),
    ImageModel(
      id: 'id-011',
      imageUrl: 'https://picsum.photos/seed/image011/500/900',
    ),
    ImageModel(
      id: 'id-012',
      imageUrl: 'https://picsum.photos/seed/image012/500/700',
    ),
    ImageModel(
      id: 'id-013',
      imageUrl: 'https://picsum.photos/seed/image013/500/700',
    ),
    ImageModel(
      id: 'id-014',
      imageUrl: 'https://picsum.photos/seed/image014/500/800',
    ),
    ImageModel(
      id: 'id-015',
      imageUrl: 'https://picsum.photos/seed/image015/500/500',
    ),
    ImageModel(
      id: 'id-016',
      imageUrl: 'https://picsum.photos/seed/image016/500/700',
    ),
    ImageModel(
      id: 'id-017',
      imageUrl: 'https://picsum.photos/seed/image017/500/600',
    ),
    ImageModel(
      id: 'id-018',
      imageUrl: 'https://picsum.photos/seed/image018/500/900',
    ),
    ImageModel(
      id: 'id-019',
      imageUrl: 'https://picsum.photos/seed/image019/500/800',
    ),
  ];

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
      )
    );
  }
}
class ImageCard extends StatelessWidget {
  const ImageCard({required this.imageData});

  final ImageModel imageData;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16.0),
      child: Image.network(imageData.imageUrl, fit: BoxFit.cover),
    );
  }
}

