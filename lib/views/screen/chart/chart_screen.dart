import 'package:ecome_app/models/user.dart';
import 'package:ecome_app/views/screen/widget/text_appbar.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class ChartScreen extends StatefulWidget {
  static const String routeName = '/chart';
  const ChartScreen({Key? key}) : super(key: key);

  @override
  State<ChartScreen> createState() => _ChartScreenState();
}

class _ChartScreenState extends State<ChartScreen> {
  static List<dynamic> data = [
    Data(name: 'Blue', percent: 40.0, color: Colors.blue),
    Data(name: 'Red', percent: 30.0, color: Colors.red),
    Data(name: 'Green', percent: 15.0, color: Colors.green),
    Data(name: 'Orange', percent: 15.0, color: Colors.orange),
  ];

  @override
  void initState() {
    super.initState();
    _chartSections(data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: TextAppbar(text: 'Chart'),
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 200,
                width: double.infinity,
                child: PieChart(
                  PieChartData(
                    sections: _chartSections(data),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                height: 200,
                width: double.infinity,
                child: BarChart(BarChartData(barGroups: _chartGroups())),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<PieChartSectionData> _chartSections(List<dynamic> sectors) {
    final List<PieChartSectionData> list = [];
    for (var sector in sectors) {
      // print(sector['percent']);
      const double radius = 40.0;
      final data = PieChartSectionData(
        color: sector.color,
        value: sector.percent,
        radius: radius,
        title: sector.name,
      );
      list.add(data);
    }
    return list;
  }

  List<BarChartGroupData> _chartGroups() {
    return data.map((point) {
      return BarChartGroupData(
        x: point.percent.toInt(),
        barRods: [
          BarChartRodData(
            toY: point.percent,
            color: point.color,
            width: 20,
            borderRadius: BorderRadius.circular(0),
          ),
        ],
      );
    }).toList();
  }
}
