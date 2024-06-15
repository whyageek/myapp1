import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart' show SvgPicture;
import 'package:my_app1/models/cigaratte.dart'; 
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Map<String, int> cigaretteCountMap = {};

void _showCigaretteDialog() {
  String? tempSelectedCigarette; // Change to nullable String

  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text("Select Cigarette"),
        content: StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return DropdownButton<String>(
              isExpanded: true,
              value: tempSelectedCigarette,
              hint: Text("Select a brand"),
              onChanged: (String? value) {
                setState(() {
                  tempSelectedCigarette = value;
                });
              },
              items: cigarettes.map((Cigarette cigarette) {
                return DropdownMenuItem<String>(
                  value: cigarette.name,
                  child: Text(cigarette.name),
                );
              }).toList(),
            );
          },
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              if (tempSelectedCigarette != null) {
                setState(() {
                  if (!cigaretteCountMap.containsKey(tempSelectedCigarette!)) {
                    cigaretteCountMap[tempSelectedCigarette!] = 0;
                  }
                });
              }
              Navigator.of(context).pop();
            },
            child: Text("Add"),
          ),
        ],
      );
    },
  );
}


  void _incrementCigaretteCount(String name) {
    setState(() {
      cigaretteCountMap[name] = cigaretteCountMap[name]! + 1;
    });
  }

  void _decrementCigaretteCount(String name) {
    setState(() {
      if (cigaretteCountMap[name]! > 0) {
        cigaretteCountMap[name] = cigaretteCountMap[name]! - 1;
      }
    });
  }

  void _deleteCigarette(String name) {
    setState(() {
      cigaretteCountMap.remove(name);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Dashboard',
          style: TextStyle(
            color: Colors.black,
            fontSize: 25,
            fontWeight: FontWeight.bold
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0.0,
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {},
          child: Container(
            margin: const EdgeInsets.all(8),
            alignment: Alignment.center,
            child: SvgPicture.asset('asseticons/filter-svgrepo-com.svg'),
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 27, 153, 153),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () {},
            child: Container(
              margin: const EdgeInsets.all(8),
              alignment: Alignment.center,
              width: 37,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 36, 158, 158),
                borderRadius: BorderRadius.circular(10),
              ),
              child: SvgPicture.asset(
                'asseticons/filter-svgrepo-com.svg',
                height: 5,
                width: 5,
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (var entry in cigaretteCountMap.entries)
              _buildCigaretteContainer(entry.key, entry.value),
            SizedBox(height: 16),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showCigaretteDialog,
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _buildCigaretteContainer(String name, int count) {
    double price = cigarettes.firstWhere((cigarette) => cigarette.name == name).price;

     return GestureDetector(
      onLongPress: () {
        _showDeleteConfirmationDialog(name);
      },

    child: Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Brand: $name"),
                Text("Price: ₹${price.toStringAsFixed(2)}"),
              ],
            ),
            Row(
              children: [
                IconButton(
                  onPressed: () => _decrementCigaretteCount(name),
                  icon: Icon(Icons.remove),
                ),
                Text("$count"),
                IconButton(
                  onPressed: () => _incrementCigaretteCount(name),
                  icon: Icon(Icons.add),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
    );
  }
  
void _showDeleteConfirmationDialog(String cigaretteName) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Delete Cigarette?"),
          content: Text("Are you sure you want to delete $cigaretteName?"),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close dialog
              },
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                _deleteCigarette(cigaretteName); // Call delete function
                Navigator.of(context).pop(); // Close dialog
              },
              child: Text("Delete"),
            ),
          ],
        );
      },
    );
  }
}


