import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import '../models/articles_model.dart';
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
                        onTap: () => {print("tap..")},
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
                                if (provider.a.data[index].image != '')
                                  Container(
                                    margin: EdgeInsets.all(10.0),
                                    child: IconButton(
                                      icon: Icon(Icons.image),
                                      iconSize: 30.0,
                                      onPressed: () {},
                                    ),
                                  ),
                                if (provider.a.data[index].document != '')
                                  Container(
                                    margin: EdgeInsets.all(10.0),
                                    child: IconButton(
                                      icon: Icon(Icons.picture_as_pdf),
                                      iconSize: 30.0,
                                      onPressed: () {},
                                    ),
                                  ),
                                Container(
                                  margin: EdgeInsets.all(10.0),
                                  child: IconButton(
                                    icon: Icon(Icons.share),
                                    iconSize: 30.0,
                                    onPressed: () {},
                                  ),
                                ),
                              ],
                            ),
                          ),
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

  stripText(i) {
    const start = '">';
    const end = '</a>';
    var str = i;

    final startIndex = str.indexOf(start);
    final endIndex = str.indexOf(end);
    final result = str.substring(startIndex + start.length, endIndex).trim();
    return result;
  }
}
