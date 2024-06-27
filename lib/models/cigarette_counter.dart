import 'package:flutter/material.dart';

class CigaretteCounter extends StatelessWidget {
  final String name;
  final int count;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;
  final VoidCallback onDelete;

  CigaretteCounter({
    required this.name,
    required this.count,
    required this.onIncrement,
    required this.onDecrement,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6.0,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            name,
            style: TextStyle(fontSize: 18),
          ),
          Row(
            children: [
              IconButton(
                onPressed: onDecrement,
                icon: Icon(Icons.remove),
              ),
              Text(
                count.toString(),
                style: TextStyle(fontSize: 18),
              ),
              IconButton(
                onPressed: onIncrement,
                icon: Icon(Icons.add),
              ),
              IconButton(
                onPressed: onDelete,
                icon: Icon(Icons.delete),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
