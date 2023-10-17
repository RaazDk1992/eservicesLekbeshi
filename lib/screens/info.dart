import 'package:flutter/material.dart';
import 'package:lekbeshimuneservices/workers/info_provider.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

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
    List<ChartData> data = [
      ChartData(
          'महिला', double.parse(provider.a.data.elementAt(0).total_female!)),
      ChartData('पुरुष', double.parse(provider.a.data.elementAt(0).total_male!))
    ];
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            height: 100,
            margin: EdgeInsets.all(5.0),
            child: GridView.count(
              crossAxisCount: 4,
              children: <Widget>[
                Container(
                  height: 30,
                  color: Color.fromRGBO(230, 7, 120, 0.5),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('Area'),
                      Text(provider.a.data.elementAt(0).area)
                    ],
                  ),
                ),
                Container(
                  height: 30,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('Population'),
                      Text(provider.a.data.elementAt(0).total_population)
                    ],
                  ),
                ),
                Container(
                  height: 30,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('Male'),
                      Text(provider.a.data.elementAt(0).total_male!)
                    ],
                  ),
                ),
                Container(
                  height: 30,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('Female'),
                      Text(provider.a.data.elementAt(0).total_female!)
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            child: SfCircularChart(
              legend: Legend(isVisible: true),
              series: <CircularSeries>[
                PieSeries<ChartData, String>(
                  dataSource: data,
                  dataLabelSettings: DataLabelSettings(isVisible: true),
                  xValueMapper: (ChartData d, _) => d.label,
                  yValueMapper: (ChartData d, _) => d.value,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class ChartData {
  ChartData(this.label, this.value);
  final String label;
  final double value;
}
