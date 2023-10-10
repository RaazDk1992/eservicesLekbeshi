import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:lekbeshimuneservices/models/articles_model.dart';
import 'package:lekbeshimuneservices/screens/articles_details.dart';
import 'package:lekbeshimuneservices/screens/pdf_reader.dart';
import 'package:lekbeshimuneservices/utils/apputils.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import '../workers/articles_provider.dart';

class FeedsScreen extends StatefulWidget {
  const FeedsScreen({super.key});

  @override
  State<FeedsScreen> createState() => _FeedsScreenState();
}

class _FeedsScreenState extends State<FeedsScreen> {
  final SearchTextController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final provider = Provider.of<ArticleProvider>(context, listen: false);

    provider.getDataFromAPI('');
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ArticleProvider>(context);
    return Container(
      child: provider.is_loading
          ? getLoadingUI()
          : provider.error.isNotEmpty
              ? getErrorUI(provider.error)
              : Container(
                  margin: const EdgeInsets.only(top: 10.0),
                  child: getBodyUI(context),
                ),
    );
  }

  getLoadingUI() {
    print("-------------loading ui-----------------------");
    return Center(
      child: SpinKitDoubleBounce(
        color: Colors.green,
        size: 50.0,
      ),
    );
  }

  getErrorUI(String error) {
    return Center(
      child: Text("Error: " + error),
    );
  }

  getBodyUI(BuildContext context) {
    final provider = Provider.of<ArticleProvider>(context, listen: false);

    return Column(
      children: [
        Container(
            margin: EdgeInsets.all(3.0),
            padding: EdgeInsets.all(2.0),
            child: TextFormField(
              controller: SearchTextController,
              decoration: InputDecoration(
                suffixIcon: InkWell(
                  onTap: () => {provider.makeSearch(SearchTextController.text)},
                  child: Container(
                    height: 25,
                    color: Colors.blue,
                    child: AspectRatio(
                      aspectRatio: 1.5 / 1,
                      child: Center(
                          child: Icon(
                        Icons.search,
                        color: Colors.white,
                      )),
                    ),
                  ),
                ),
                hintText: 'Search Document',
                contentPadding: EdgeInsets.symmetric(horizontal: 15),
                border: OutlineInputBorder(
                  borderSide: BorderSide(width: 1, color: Colors.black),
                ),
              ),
            )),
        Expanded(
            child: Consumer(
          builder: (context, ArticleProvider articleProvider, child) =>
              ListView.separated(
                  itemBuilder: (context, index) => ListTile(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DetailedArticle(
                                      id: provider.a.data[index].node),
                                  settings: RouteSettings(arguments: {
                                    'articleId':
                                        provider.a.data[index].node.toString()
                                  })));
                        },
                        leading: Container(
                          width: 50.0,
                          child: Center(
                            child: Text(
                              getSubstring(articleProvider
                                  .a.data[index].published_date
                                  .toString()),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.redAccent),
                            ),
                          ),
                        ),
                        title: Text(stripText(provider.a.data[index].title)),
                        subtitle: IntrinsicWidth(
                          child: Container(
                              height: 50.0,
                              child: Row(
                                children: [
                                  Container(
                                    child: Text(provider
                                        .a.data[index].actual_date
                                        .toString()),
                                  ),

                                  loadWidget(
                                      provider.a.data[index].document
                                          .toString(),
                                      provider.a.data[index].image.toString()),

                                  // Text('false--doc'),
                                  Container(
                                      margin: EdgeInsets.all(10.0),
                                      child: IconButton(
                                        icon: Icon(Icons.share),
                                        iconSize: 30.0,
                                        onPressed: () => shareThis(
                                            provider.a.data[index].title),
                                      )),
                                ],
                              )),
                        ),
                      ),
                  separatorBuilder: (context, index) {
                    return Divider(
                      color: Colors.amber,
                    );
                  },
                  itemCount: articleProvider.a.data.length),
        )),
      ],
    );
  }

  String getSubstring(String x) {
    int index = x.indexOf(' ');
    int last = x.indexOf(' ', index + 1);
    return x.substring(0, last) + "\n Ago";
  }

  loadWidget(
    String documentPath,
    String imagePath,
  ) {
    bool HasImage = imagePath?.isNotEmpty ?? false;
    bool HasDocument = documentPath?.isNotEmpty ?? false;

    if (HasImage && HasDocument) {
      return IntrinsicWidth(
        child: Container(
            height: 50.0,
            child: Row(
              children: [
                Container(
                  child: Text('-'),
                ),

                Container(
                    margin: EdgeInsets.all(5.0),
                    child: IconButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: ((context) =>
                                loadImage(context, imagePath)));
                      },
                      icon: Icon(Icons.image),
                    )),

                //Text('no img'),

                Container(
                    margin: EdgeInsets.all(5.0),
                    child: IconButton(
                      onPressed: () => {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  PdfReader(url: stripUrl(documentPath)[0]),
                            ))
                      },
                      icon: Icon(Icons.picture_as_pdf_outlined),
                      iconSize: 30.0,
                    )),

                // Text('false--doc'),
              ],
            )),
      );
    } else if (HasDocument) {
      return IntrinsicWidth(
        child: Container(
            height: 50.0,
            child: Row(
              children: [
                Container(
                  child: Text('-'),
                ),

                //Text('no img'),

                Container(
                    margin: EdgeInsets.all(5.0),
                    child: IconButton(
                      onPressed: () => {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  PdfReader(url: stripUrl(documentPath)[0]),
                            ))
                      },
                      icon: Icon(Icons.picture_as_pdf_outlined),
                      iconSize: 30.0,
                    )),

                // Text('false--doc'),
              ],
            )),
      );
    } else {
      return IntrinsicWidth(
        child: Container(
            height: 50.0,
            child: Row(
              children: [
                Container(
                  child: Text('-'),
                ),

                Container(
                    margin: EdgeInsets.all(5.0),
                    child: IconButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: ((context) =>
                                loadImage(context, imagePath)));
                      },
                      icon: Icon(Icons.image),
                    )),

                //Text('no img'),
              ],
            )),
      );
    }
  }

  loadImage(x, y) {
    List imageList = stripUrl(y);

    return Dialog(
      elevation: 0,
      insetPadding: EdgeInsets.only(left: 5.0, right: 5.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      child: SizedBox(
        height: MediaQuery.of(context).size.height - 150,
        width: MediaQuery.of(context).size.width - 20,
        child: PhotoViewGallery.builder(
          itemCount: imageList.length,
          builder: (context, index) {
            return PhotoViewGalleryPageOptions(
              imageProvider: NetworkImage(
                imageList[index],
              ),
              minScale: PhotoViewComputedScale.contained * 1,
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

  shareThis(String data) {
    print(contentLink(data));
    //Share.share(stripUrl(data), subject: stripText(data));
  }
}
