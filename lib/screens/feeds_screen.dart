import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:lekbeshimuneservices/screens/articles_details.dart';
import 'package:lekbeshimuneservices/screens/pdf_reader.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:provider/provider.dart';
import '../workers/articles_provider.dart';

class FeedsScreen extends StatefulWidget {
  const FeedsScreen({super.key});

  @override
  State<FeedsScreen> createState() => _FeedsScreenState();
}

class _FeedsScreenState extends State<FeedsScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final provider = Provider.of<ArticleProvider>(context, listen: false);

    provider.getDataFromAPI();
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
      child: SpinKitRotatingCircle(
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
          child: TextField(
            decoration: InputDecoration(
                hintText: 'Search',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                suffixIcon: Icon(Icons.search)),
            onChanged: (value) => provider.makeSearch(value),
          ),
        ),
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
                                  .sa.data[index].published_date
                                  .toString()),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.redAccent),
                            ),
                          ),
                        ),
                        title: Text(provider.a.data[index].title),
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
                                  if (provider.a.data[index].image != '')
                                    Container(
                                        margin: EdgeInsets.all(10.0),
                                        child: IconButton(
                                          onPressed: () => showDialog(
                                              context: context,
                                              builder: (_) => AlertDialog(
                                                    // title: Text('imgg'),
                                                    content: Container(
                                                      width: double.maxFinite,
                                                      child: showLibrary(
                                                          context,
                                                          provider.a.data[index]
                                                              .image
                                                              .toString()),
                                                    ),
                                                  )),
                                          icon: Icon(Icons.image),
                                          iconSize: 30.0,
                                        ))
                                  else
                                  //Text('no img'),
                                  if (provider.a.data[index].document
                                          .toString() !=
                                      null)
                                    Container(
                                        margin: EdgeInsets.all(10.0),
                                        child: IconButton(
                                          onPressed: () => {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      PdfReader(
                                                          url: stripUrl(provider
                                                              .a
                                                              .data[index]
                                                              .document!)[0]),
                                                ))
                                          },
                                          icon: Icon(
                                              Icons.picture_as_pdf_outlined),
                                          iconSize: 30.0,
                                        )),

                                  // Text('false--doc'),
                                  Container(
                                      margin: EdgeInsets.all(10.0),
                                      child: IconButton(
                                        onPressed: () {},
                                        icon: Icon(Icons.share),
                                        iconSize: 30.0,
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
                  itemCount: articleProvider.sa.data.length),
        )),
      ],
    );
  }

  String getSubstring(String x) {
    int index = x.indexOf(' ');
    int last = x.indexOf(' ', index + 1);
    return x.substring(0, last) + "\n Ago";
  }

  showFile() {
    print('object');
  }

  stripText(i) {
    const start = '">';
    const end = '</a>';
    var str = i;

    final startIndex = str.indexOf(start);
    final endIndex = str.indexOf(end);
    final result = str.substring(startIndex + start.length, endIndex).trim();
    return result;
  }

  stripUrl(String data) {
    final urlRegExp = new RegExp(
        r"((https?:www\.)|(https?:\/\/)|(www\.))[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9]{1,6}(\/[-a-zA-Z0-9()@:%_\+.~#?&\/=]*)?");
    final urlMatches = urlRegExp.allMatches(data);
    List urls = urlMatches
        .map((urlMatch) => data.substring(urlMatch.start, urlMatch.end))
        .toList();
    return urls;
  }

  showLibrary(x, y) {
    List imageList = stripUrl(y);

    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      height: MediaQuery.of(context).size.height * 0.5,
      child: PhotoViewGallery.builder(
        itemCount: imageList.length,
        builder: (context, index) {
          return PhotoViewGalleryPageOptions(
            imageProvider: NetworkImage(
              imageList[index],
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
    );
  }
}
