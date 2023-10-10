import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hive/hive.dart';
import 'package:lekbeshimuneservices/models/staffs_model.dart';
import 'package:lekbeshimuneservices/screens/articles_details.dart';
import 'package:lekbeshimuneservices/screens/pdf_reader.dart';
import 'package:lekbeshimuneservices/utils/apputils.dart';
import 'package:lekbeshimuneservices/widgets/appbar.dart';
import 'package:lekbeshimuneservices/workers/staffs_provider.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
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
      appBar: WidgetAppBar(title: 'Staff details'),
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
                        leading: CircleAvatar(
                          radius: 50,
                          backgroundColor: Colors.deepOrangeAccent,
                          child: ClipOval(
                            child: CachedNetworkImage(
                              imageUrl:
                                  loadAvatar(provider.staffs.data[index].image),
                              fit: BoxFit.cover,
                              width: 55,
                              height: 110,
                            ),
                          ),
                        ),
                        title: Text(provider.staffs.data[index].title +
                            "\n" +
                            provider.staffs.data[index].designation +
                            "," +
                            "\n" +
                            provider.staffs.data[index].dept! +
                            "\n" +
                            provider.staffs.data[index].office),
                        subtitle: subtitle(provider.staffs.data[index].phone,
                            provider.staffs.data[index].email),
                        isThreeLine: true,
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

  subtitle(String? phone, String? email) {
    bool hasPhone = phone?.isNotEmpty ?? false;
    bool hasMail = email?.isNotEmpty ?? false;

    if (hasMail && hasPhone) {
      return Row(
        children: [
          Container(
              margin: EdgeInsets.all(3.0),
              height: 80,
              width: 100,
              child: IconButton(
                  onPressed: () => openDialer(phone!),
                  icon: Icon(Icons.phone))),
          Container(
              margin: EdgeInsets.all(3.0),
              height: 80,
              width: 100,
              child: IconButton(onPressed: () {}, icon: Icon(Icons.mail)))
        ],
      );
    } else if (hasMail) {
      return Row(
        children: [
          Container(
              margin: EdgeInsets.all(3.0),
              width: 100,
              height: 80,
              child: IconButton(onPressed: () {}, icon: Icon(Icons.mail)))
        ],
      );
    } else if (hasPhone) {
      return Row(
        children: [
          Container(
              margin: EdgeInsets.all(3.0),
              width: 100,
              height: 80,
              child: IconButton(onPressed: () {}, icon: Icon(Icons.phone))),
        ],
      );
    } else {
      return Container();
    }
  }

  openDialer(String phone) async {
    Uri ph = Uri.parse("tel:+977" + phone);
    if (await canLaunchUrl(ph)) {
      await launchUrl(ph);
    } else {
      print('Could not launch');
    }
  }
}
