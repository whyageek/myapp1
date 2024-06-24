import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_app1/models/cigaratte.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CalendarPage extends StatefulWidget {
  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  final user = FirebaseAuth.instance.currentUser!;
  Map<DateTime, List<Map<String, dynamic>>> _events = {};
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();

  @override
  void initState() {
    super.initState();
    _loadEvents();
    _addListener();
  }

  void _addListener() {
    FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .collection('cigarettes')
        .snapshots()
        .listen((querySnapshot) {
      _loadEvents();
    });
  }

  void _loadEvents() async {
    final userId = user.uid;
    final querySnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('cigarettes')
        .get();

    Map<DateTime, List<Map<String, dynamic>>> events = {};

    for (var doc in querySnapshot.docs) {
      var data = doc.data();
      var timestamps = List<Timestamp>.from(data['timestamps']);
      var name = doc.id;
      var price = cigarettes.firstWhere((c) => c.name == name).price;

      for (var timestamp in timestamps) {
        DateTime date = timestamp.toDate();
        DateTime eventDay = DateTime(date.year, date.month, date.day);

        if (!events.containsKey(eventDay)) {
          events[eventDay] = [];
        }

        events[eventDay]!.add({'name': name, 'price': price});
      }
    }

    setState(() {
      _events = events;
    });
  }

  List<Map<String, dynamic>> _getEventsForDay(DateTime day) {
    return _events[day] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calendar'),
      ),
      body: Column(
        children: [
          TableCalendar(
            focusedDay: _focusedDay,
            firstDay: DateTime.utc(2020, 1, 1),
            lastDay: DateTime.utc(2030, 12, 31),
            eventLoader: _getEventsForDay,
            selectedDayPredicate: (day) {
              return isSameDay(_selectedDay, day);
            },
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });
            },
            calendarStyle: CalendarStyle(
              todayDecoration: BoxDecoration(
                color: Colors.blue[200],
                shape: BoxShape.circle,
              ),
              selectedDecoration: BoxDecoration(
                color: Colors.blue,
                shape: BoxShape.circle,
              ),
              markerDecoration: BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),
            ),
          ),
          Expanded(
            child: _buildEventList(),
          ),
        ],
      ),
    );
  }

  Widget _buildEventList() {
    final events = _getEventsForDay(_selectedDay);

    if (events.isEmpty) {
      return Center(
        child: Text('No cigarettes tracked for this day.'),
      );
    }

    double total = events.fold(
        0.0, (sum, event) => sum + (event['price'] ?? 0.0));

    return ListView(
      children: [
        ...events.map((event) => ListTile(
              title: Text(event['name']),
              trailing: Text('\$${event['price'].toStringAsFixed(2)}'),
            )),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'Total: \$${total.toStringAsFixed(2)}',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
