import 'package:flutter/material.dart';

class AnalysisPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)!.settings.arguments as Map;
    final int dailyCigaretteCount = arguments['dailyCigaretteCount'];
    final int monthlyCigaretteCount = arguments['monthlyCigaretteCount'];
    final double dailyCigarettePrice = arguments['dailyCigarettePrice'];
    final double monthlyCigarettePrice = arguments['monthlyCigarettePrice'];

    return Scaffold(
      appBar: AppBar(
        title: Text('Analysis'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Daily Consumption: $dailyCigaretteCount cigarettes',
              style: TextStyle(fontSize: 18),
            ),
            Text(
              'Monthly Consumption: $monthlyCigaretteCount cigarettes',
              style: TextStyle(fontSize: 18),
            ),
            Text(
              'Daily Expenditure: \$${dailyCigarettePrice.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 18),
            ),
            Text(
              'Monthly Expenditure: \$${monthlyCigarettePrice.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
