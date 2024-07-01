import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyBarChart extends StatefulWidget {
  const MyBarChart({super.key});

  @override
  State<MyBarChart> createState() => _MyBarChartState();
}

class _MyBarChartState extends State<MyBarChart> {
  @override
  Widget build(BuildContext context) {
    return Container(
        transform: Matrix4.translationValues(0, -80, 0),
        height: 320,
        child: Card(
          margin: const EdgeInsets.all(10),
          color: Colors.grey.shade100,
          elevation: 5,
          child: Padding(
            padding: const EdgeInsets.only(right: 20, top: 10, bottom: 10),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Weekly Revenue",
                      style: GoogleFonts.aBeeZee(
                        fontWeight: FontWeight.bold,
                        color: Colors.indigo.shade900,
                        fontSize: 20,
                        letterSpacing: 1.3
                      ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "₹14,750",
                            style: GoogleFonts.aBeeZee(
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                            ),
                          ),
                          Text(
                            "Total Revenue",
                            style: GoogleFonts.aBeeZee(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              color: Colors.black45
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 20,),
                Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left:8.0),
                      child: BarChart(BarChartData(
                        gridData: const FlGridData(show: false),
                        borderData: FlBorderData(
                          show: false
                        ),
                        titlesData: FlTitlesData(
                          rightTitles: const AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: false
                      
                            )
                          ),
                          topTitles: const AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: false
                            )
                          ),
                          leftTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            interval: 1,
                            reservedSize: 30,
                            getTitlesWidget: (value, meta) {
                              return Text("${value.toInt()}k",
                              style: GoogleFonts.aBeeZee(
                                fontWeight: FontWeight.bold,
                              ),
                              );
                            }
                          )
                        ),
                          bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            reservedSize: 20,
                            interval: 1,
                            getTitlesWidget: (value, meta) {
                              late String val;
                              value == 0 ?  val = "      Sun"
                              : value == 1 ? val = "  Mon"
                              : value == 2 ? val = "Tue"
                              : value == 3 ? val = "Wed"
                              : value == 4 ? val = "Thu"
                              : value == 5 ? val = "Fri"
                              :  val = "Sat" ;
                      
                              return Text(val, 
                              style: GoogleFonts.aBeeZee(
                                fontWeight: FontWeight.bold,
                              )
                              ,);
                            },
                          )
                        )
                        ),
                        
                          alignment: BarChartAlignment.center,
                          maxY: 5,
                          minY: 0,
                          groupsSpace: 100,
                          barTouchData: BarTouchData(enabled: true),
                          barGroups: [
                        // BarChartGroupData(x: 0, barRods: [
                        //   BarChartRodData(
                        //     toY: 20,
                        //     width: 20,
                        //     borderRadius: BorderRadius.only(
                        //         topLeft: Radius.circular(10),
                        //         topRight: Radius.circular(10)),
                        //   )
                        // ]),
                        BarChartGroupData(x: 1, barRods: [
                          BarChartRodData(
                            toY: 3.75,
                            width: 20,
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10)),
                          )
                        ]),
                        BarChartGroupData(x: 2, barRods: [
                          BarChartRodData(
                            toY: 2,
                            width: 20,
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10)),
                          )
                        ]),
                        BarChartGroupData(x: 3, barRods: [
                          BarChartRodData(
                            toY: 1.25,
                            width: 20,
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10)),
                          )
                        ]),
                        BarChartGroupData(x: 4, barRods: [
                          BarChartRodData(
                            toY: 2.5,
                            width: 20,
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10)),
                          )
                        ]),
                        BarChartGroupData(x: 5, barRods: [
                          BarChartRodData(
                            toY: 2,
                            width: 20,
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10)),
                          )
                        ]),
                        BarChartGroupData(x: 6, barRods: [
                          BarChartRodData(
                            toY: 3.25,
                            width: 20,
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10)),
                          )
                        ]),
                      ])),
                    ))
              ],
            ),
          ),
        ));
  }
}
