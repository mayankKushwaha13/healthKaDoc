import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyLineChart extends StatelessWidget {
  const MyLineChart({
    super.key,
  });

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
          padding: const EdgeInsets.only(right: 20, top: 10, bottom: 10,),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    "Daily Patients",
                    style: GoogleFonts.aBeeZee(
                      letterSpacing: 1.3,
                      color: Colors.blue.shade900,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  Column(
                    children: [
                      Row(
                        children: [
                          const CircleAvatar(
                            backgroundColor: Colors.red,
                            radius: 10,
                          ),
                          const SizedBox(width: 10,),
                          Text("This Week",
                          style: GoogleFonts.aBeeZee(
                          ),
                          )
                        ],
                      ),
                      const SizedBox(height: 5,),
                      Row(
                        children: [
                          const CircleAvatar(
                            backgroundColor: Colors.blue,
                            radius: 10,
                          ),
                          const SizedBox(width: 10,),
                          Text("Last Week",
                          style: GoogleFonts.aBeeZee(
                          ),
                          )
                        ],
                      ),
                    ],
                  )
                ],
              ),
              const SizedBox(height: 20,),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: LineChart(
                    LineChartData(
                      clipData: const FlClipData.all(
                      ),
                      minX: 1,
                      maxX: 6,
                      minY: 0,
                      maxY: 60,
                      titlesData: FlTitlesData(
                        show: true,
                        topTitles: const AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: false
                          )
                        ),
                        rightTitles: const AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: false
                          )
                        ),
                        leftTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            interval: 10,
                            reservedSize: 40,
                            getTitlesWidget: (value, meta) {
                              return Text("${value.toInt()}",
                              style: GoogleFonts.aBeeZee(
                                fontWeight: FontWeight.bold,
                              ),
                              );
                            },
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
                      gridData: const FlGridData(
                        show: false
                      ),
                      borderData: FlBorderData(
                        show: false
                      ),
                      lineBarsData: [
                        LineChartBarData(
                          barWidth: 5,
                          dotData: const FlDotData(
                            show: false
                          ),
                          isCurved: true,
                          spots: [
                            const FlSpot(0, 10),
                            const FlSpot(1, 20),
                            const FlSpot(2, 40),
                            const FlSpot(3, 20),
                            const FlSpot(4, 10),
                            const FlSpot(5, 15),
                            const FlSpot(6, 30),
                                  
                          ]
                        ),
                        LineChartBarData(
                          dotData: const FlDotData(
                            show: false
                          ),
                          barWidth: 5,
                          isCurved: true,
                          color: Colors.red,
                          spots: [
                            const FlSpot(0, 20),
                            const FlSpot(1, 10),
                            const FlSpot(2, 30),
                            const FlSpot(3, 10),
                            const FlSpot(4, 30),
                            const FlSpot(5, 19),
                            const FlSpot(6, 20),
                                  
                          ]
                        )
                      ]
                    )
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

