import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_app1/models/cigaratte.dart';
import 'package:my_app1/screens/analysis_page.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Map<String, int> cigaretteCountMap = {};

  void _showCigaretteDialog() {
    String? tempSelectedCigarette;

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
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Confirm Deletion"),
          content: Text("Are you sure you want to delete the cigarette container for '$name'?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  cigaretteCountMap.remove(name);
                });
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text("Delete"),
            ),
          ],
        );
      },
    );
  }

  void _navigateToAnalysisPage() {
    Navigator.pushNamed(
      context,
      '/analysis',
      arguments: {
        'dailyCigaretteCount': calculateDailyCigaretteCount(),
        'monthlyCigaretteCount': calculateMonthlyCigaretteCount(),
      },
    );
  }

  int calculateDailyCigaretteCount() {
    int count = 0;
    cigaretteCountMap.values.forEach((value) {
      count += value;
    });
    return count;
  }

  int calculateMonthlyCigaretteCount() {
    // Adjust as per your requirement
    return calculateDailyCigaretteCount() * 30;
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
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0.0,
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: _navigateToAnalysisPage,
            icon: Icon(Icons.analytics),
            color: Colors.black, // Adjust icon color as needed
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
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Navigation',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('Profile'),
              onTap: () {
                // Handle navigation to Profile screen
                Navigator.pop(context); // Close the drawer
              },
            ),
            ListTile(
              leading: Icon(Icons.calendar_today),
              title: Text('Calendar'),
              onTap: () {
                // Handle navigation to Calendar screen
                Navigator.pop(context); // Close the drawer
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
              onTap: () {
                // Handle navigation to Settings screen
                Navigator.pop(context); // Close the drawer
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCigaretteContainer(String name, int count) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      border: Border.all(color: Colors.grey),
      borderRadius: BorderRadius.circular(10),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          name,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        Row(
          children: [
            IconButton(
              onPressed: () => _decrementCigaretteCount(name),
              icon: Icon(Icons.remove),
              // Disable the button when count is zero
              color: count > 0 ? null : Colors.grey,
            ),
            Text(
              count.toString(),
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            IconButton(
              onPressed: () => _incrementCigaretteCount(name),
              icon: Icon(Icons.add),
            ),
            IconButton(
              onPressed: () => _deleteCigarette(name),
              icon: Icon(Icons.delete),
            ),
          ],
        ),
      ],
    ),
  );
}
}
