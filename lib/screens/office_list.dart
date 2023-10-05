import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:lekbeshimuneservices/widgets/appbar.dart';

import 'package:lekbeshimuneservices/workers/fetch_offices.dart';

import 'package:provider/provider.dart';

class OfficeLists extends StatefulWidget {
  const OfficeLists({super.key});

  @override
  State<OfficeLists> createState() => _OfficeListsState();
}

class _OfficeListsState extends State<OfficeLists> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final provider = Provider.of<OfficeListProvider>(context, listen: false);

    provider.getDataFromAPI();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<OfficeListProvider>(context);
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
    final provider = Provider.of<OfficeListProvider>(context, listen: false);

    return Scaffold(
      appBar: WidgetAppBar(title: 'Office Details'),
      body: Consumer(
        builder: (context, value, child) => Container(
          margin: EdgeInsets.all(10.0),
          child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200,
                  childAspectRatio: 3 / 2,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20),
              itemCount: provider.office.data.length,
              itemBuilder: (BuildContext ctx, index) {
                return Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: Colors.amber,
                      borderRadius: BorderRadius.circular(5)),
                  child: Text(provider.office.data[index].name.toString()),
                );
              }),
        ),
      ),
    );
  }
}
