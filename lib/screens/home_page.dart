import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_app1/models/cigaratte.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Map<String, int> cigaretteCountMap = {};
  Map<String, DateTime> cigaretteTimestamps = {};

  @override
  void initState() {
    super.initState();
    _loadCigaretteData();
  }

  final user = FirebaseAuth.instance.currentUser!;

  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  void _loadCigaretteData() async {
    final userId = user.uid;
    final querySnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('cigarettes')
        .get();

    Map<String, int> countMap = {};

    for (var doc in querySnapshot.docs) {
      var data = doc.data();
      var timestamps = List<Timestamp>.from(data['timestamps']);
      countMap[doc.id] = timestamps.length;
    }

    setState(() {
      cigaretteCountMap = countMap;
    });
  }

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
                      cigaretteCountMap[tempSelectedCigarette!] = -1;
                    }
                    _incrementCigaretteCount(tempSelectedCigarette!);
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

  void _incrementCigaretteCount(String name) async {
   setState(() {
     if (!cigaretteCountMap.containsKey(name)) {
        cigaretteCountMap[name] = 0;
      }
      cigaretteCountMap[name] = cigaretteCountMap[name]! + 1;
     cigaretteTimestamps[name] = DateTime.now();
    });

   final userId = user.uid;
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
       .collection('cigarettes')
       .doc(name)
       .set({
     'timestamps': FieldValue.arrayUnion([Timestamp.fromDate(DateTime.now())])
    }, SetOptions(merge: true));
  }

  void _decrementCigaretteCount(String name) async {
    if (cigaretteCountMap.containsKey(name) && cigaretteCountMap[name]! > 0) {
      final currentTimestamp = DateTime.now();
      final lastAddedTimestamp = cigaretteTimestamps[name];

      if (lastAddedTimestamp != null &&
          currentTimestamp.difference(lastAddedTimestamp).inSeconds <= 30) {
        setState(() {
          cigaretteCountMap[name] = cigaretteCountMap[name]! - 1;
          cigaretteTimestamps.remove(name);
        });

        final userId = user.uid;
        await FirebaseFirestore.instance
            .collection('users')
            .doc(userId)
            .collection('cigarettes')
            .doc(name)
            .update({
          'timestamps': FieldValue.arrayRemove([Timestamp.fromDate(lastAddedTimestamp)])
        });
      }
    }
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
              Navigator.of(context).pop();
            },
            child: Text("Cancel"),
          ),
          TextButton(
            onPressed: () async {
              Navigator.of(context).pop();

              setState(() {
                cigaretteCountMap.remove(name);
              });

              final userId = user.uid;
              await FirebaseFirestore.instance
                  .collection('users')
                  .doc(userId)
                  .collection('cigarettes')
                  .doc(name)
                  .delete();
             },
             child: Text("Delete"),
            ),
         ],
       );
      },
    );
  }

  void _navigateToAnalysisPage() {
    double dailyCigarettePrice = calculateDailyCigarettePrice();
    double monthlyCigarettePrice = calculateMonthlyCigarettePrice();

    Navigator.pushNamed(
      context,
      '/analysis',
      arguments: {
        'dailyCigaretteCount': calculateDailyCigaretteCount(),
        'monthlyCigaretteCount': calculateMonthlyCigaretteCount(),
        'dailyCigarettePrice': dailyCigarettePrice,
        'monthlyCigarettePrice': monthlyCigarettePrice,
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
    return calculateDailyCigaretteCount() * 30;
  }

  double calculateDailyCigarettePrice() {
    double total = 0.0;
    cigaretteCountMap.forEach((name, count) {
      double price = cigarettes.firstWhere((c) => c.name == name).price;
      total += price * count;
    });
    return total;
  }

  double calculateMonthlyCigarettePrice() {
    return calculateDailyCigarettePrice() * 1;
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
            color: Colors.black,
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
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'hej',
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
                Navigator.pop(context); // Close the drawer
              },
            ),
            ListTile(
              leading: Icon(Icons.calendar_today),
              title: Text('Calendar'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                Navigator.pushNamed(context, '/calendar');
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
              },
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('SignOut'),
              onTap: signUserOut,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCigaretteContainer(String name, int count) {
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
                onPressed: () => _decrementCigaretteCount(name),
                icon: Icon(Icons.remove),
              ),
              Text(
                count.toString(),
                style: TextStyle(fontSize: 18),
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
