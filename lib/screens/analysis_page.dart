import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class AnalysisPage extends StatelessWidget {
  final int dailyCigaretteCount;
  final int monthlyCigaretteCount;

  AnalysisPage({required this.dailyCigaretteCount, required this.monthlyCigaretteCount});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cigarette Smoking Analysis"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Daily Cigarette Count: $dailyCigaretteCount"),
            Text("Monthly Cigarette Count: $monthlyCigaretteCount"),
            SizedBox(height: 20),
            PieChart(
              PieChartData(
                sections: [
                  PieChartSectionData(
                    value: dailyCigaretteCount.toDouble(),
                    title: "Daily",
                    color: Colors.blue,
                    titleStyle: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  PieChartSectionData(
                    value: monthlyCigaretteCount.toDouble(),
                    title: "Monthly",
                    color: Colors.green,
                    titleStyle: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
                sectionsSpace: 0,
                centerSpaceRadius: 40,
                borderData: FlBorderData(show: false),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Navigate back to previous page
              },
              child: Text("Go Back"),
            ),
          ],
        ),    
      ),
    );
  }
  
}

