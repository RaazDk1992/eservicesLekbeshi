import 'package:flutter/material.dart';
import 'package:lekbeshimuneservices/workers/info_provider.dart';
import 'package:provider/provider.dart';

class PalikaInfo extends StatefulWidget {
  const PalikaInfo({super.key});

  @override
  State<PalikaInfo> createState() => _PalikaInfoState();
}

class _PalikaInfoState extends State<PalikaInfo> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final provider = Provider.of<InfoProvider>(context, listen: false);

    provider.getDataFromAPI();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<InfoProvider>(context);

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
    // print("===>");
  }

  getErrorUI(String error) {
    return Center(
      child: Text("Error" + error),
    );
  }

  getBodyUI(BuildContext context) {
    final provider = Provider.of<InfoProvider>(context, listen: false);
    // print(provider.a.data.length.toString() + "===>");
    return Text(provider.a.data.length.toString());
  }
}
