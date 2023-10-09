import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hive/hive.dart';
import 'package:lekbeshimuneservices/models/staffs_model.dart';
import 'package:lekbeshimuneservices/screens/articles_details.dart';
import 'package:lekbeshimuneservices/screens/pdf_reader.dart';
import 'package:lekbeshimuneservices/workers/staffs_provider.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:provider/provider.dart';
import '../workers/articles_provider.dart';

class StaffsScreen extends StatefulWidget {
  const StaffsScreen({super.key});

  @override
  State<StaffsScreen> createState() => _StaffsScreenState();
}

class _StaffsScreenState extends State<StaffsScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final provider = Provider.of<StaffsProvider>(context, listen: false);

    provider.getDataFromAPI();
  }

  @override
  void dispose() {
    // TODO: implement dispose

    super.dispose();
    Hive.box('staffx').close();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<StaffsProvider>(context);
    return Scaffold(
      body: Container(
        child: provider.is_loading
            ? getLoadingUI()
            : provider.error.isNotEmpty
                ? getErrorUI(provider.error)
                : Container(
                    margin: const EdgeInsets.only(top: 10.0),
                    child: getBodyUI(context),
                  ),
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
    final provider = Provider.of<StaffsProvider>(context, listen: false);

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
          builder: (context, StaffsProvider StaffsProvider, child) =>
              ListView.separated(
                  itemBuilder: (context, index) => ListTile(
                        onTap: () {},
                        leading: Container(
                          width: 50.0,
                        ),
                        title: Text(provider.staffs.data[index].title),
                        subtitle: IntrinsicWidth(),
                      ),
                  separatorBuilder: (context, index) {
                    return Divider(
                      color: Colors.amber,
                    );
                  },
                  itemCount: StaffsProvider.staffs.data.length),
        )),
      ],
    );
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
