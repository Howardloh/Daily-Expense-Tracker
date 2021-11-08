import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/gestures.dart';
import 'package:app/Controller/event_controller.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

class GeneratePieChart extends StatefulWidget {
  const GeneratePieChart({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _GeneratePieChart();
}

class _GeneratePieChart extends State {
  int touchedIndex = 0;
  EventController event = Get.find();

  @override
  void initState() {
    event.getTodayChart();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.3,
      child: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: [Color(0xff0e0023), Color(0xff3a1e54)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter)),
        child: Column(
          children: <Widget>[
            const SizedBox(height: 70),
            const Text(
              "CHART",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 50,
                  fontWeight: FontWeight.bold),
            ),
            Card(
              color: Colors.transparent,
              child: AspectRatio(
                aspectRatio: 1,
                child: PieChart(
                  PieChartData(
                      pieTouchData: PieTouchData(touchCallback:
                          (FlTouchEvent event, pieTouchResponse) {
                        setState(() {
                          if (!event.isInterestedForInteractions ||
                              pieTouchResponse == null ||
                              pieTouchResponse.touchedSection == null) {
                            touchedIndex = -1;
                            return;
                          }
                          touchedIndex = pieTouchResponse
                              .touchedSection!.touchedSectionIndex;
                        });
                      }),
                      borderData: FlBorderData(
                        show: false,
                      ),
                      sectionsSpace: 0,
                      centerSpaceRadius: 0,
                      sections: showingSections()),
                ),
              ),
            ),
            const SizedBox(height: 0),
            Row(
              children: <Widget>[
                const SizedBox(width: 250),
                Container(
                  width: 30,
                  height: 30,
                  color: Colors.red,
                ),
                const SizedBox(width: 12),
                const Text("Expense",
                    style: TextStyle(color: Colors.white, fontSize: 20)),
              ],
            ),
            Row(
              children: <Widget>[
                const SizedBox(width: 250),
                Container(
                  width: 30,
                  height: 30,
                  color: Colors.green,
                ),
                const SizedBox(width: 12),
                const Text("Income",
                    style: TextStyle(color: Colors.white, fontSize: 20)),
              ],
            ),
            const SizedBox(height: 50),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, "/calendar");
              },
              child: const Text(
                "BACK",
                style: TextStyle(color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                // returns ButtonStyle
                primary: HexColor("#F7B83B"),
                onPrimary: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<PieChartSectionData> showingSections() {
    event.getTodayChart();
    return List.generate(2, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 20.0 : 16.0;
      final radius = isTouched ? 110.0 : 100.0;
      final widgetSize = isTouched ? 55.0 : 40.0;
      final incomeTotal = event.chartIncome.value / event.total.value * 100;
      final expenseTotal = event.chartExpense.value / event.total.value * 100;
      print(event.chartExpense.value);
      print(event.chartIncome.value);

      switch (i) {
        case 0:
          return PieChartSectionData(
            color: Colors.green,
            value: event.chartIncome.value,
            title: incomeTotal.toStringAsFixed(2) + "%",
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        case 1:
          return PieChartSectionData(
            color: Colors.red,
            value: event.chartExpense.value,
            title: expenseTotal.toStringAsFixed(2) + "%",
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );

        default:
          throw 'Oh no';
      }
    });
  }
}

class _Badge extends StatelessWidget {
  final String svgAsset;
  final double size;
  final Color borderColor;

  const _Badge(
    this.svgAsset, {
    Key? key,
    required this.size,
    required this.borderColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: PieChart.defaultDuration,
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        border: Border.all(
          color: borderColor,
          width: 2,
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withOpacity(.5),
            offset: const Offset(3, 3),
            blurRadius: 3,
          ),
        ],
      ),
      padding: EdgeInsets.all(size * .15),
      child: Center(
        child: SvgPicture.asset(
          svgAsset,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
