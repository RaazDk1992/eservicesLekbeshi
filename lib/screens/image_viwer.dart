import 'package:flutter/material.dart';
import 'package:lekbeshimuneservices/widgets/appbar.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class ImageViewer extends StatelessWidget {
  final String articleTitle;
  final List imageUrls;
  ImageViewer({Key? key, required this.articleTitle, required this.imageUrls})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    //return const Placeholder();
    return Scaffold(
      appBar: const WidgetAppBar(title: 'Image viewer'),
      body: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        height: MediaQuery.of(context).size.height * 0.5,
        child: PhotoViewGallery.builder(
          itemCount: imageUrls.length,
          builder: (context, index) {
            return PhotoViewGalleryPageOptions(
              imageProvider: NetworkImage(
                imageUrls[index],
              ),
              minScale: PhotoViewComputedScale.contained * 0.9,
              maxScale: PhotoViewComputedScale.covered * 2,
            );
          },
          scrollPhysics: BouncingScrollPhysics(),
          backgroundDecoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            color: Theme.of(context).canvasColor,
          ),
          enableRotation: true,
          loadingBuilder: (context, event) => Center(
            child: Container(
              width: 30.0,
              height: 30.0,
              child: CircularProgressIndicator(
                backgroundColor: Colors.orange,
                value: event == null
                    ? 0
                    : event.cumulativeBytesLoaded / event.expectedTotalBytes!,
              ),
            ),
          ),
        ),
      ),
    );
  }

  showLibrary(x, y) {
    // List imageList = stripUrl(y);
  }
}
