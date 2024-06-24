import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:task_4_todo_app_using_sqlite/Database/DBHelperClass.dart';

class TaskCalendar extends StatefulWidget {
  const TaskCalendar({Key? key}) : super(key: key);

  @override
  _TaskCalendarState createState() => _TaskCalendarState();
}

class _TaskCalendarState extends State<TaskCalendar> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  List<Map<String, dynamic>> _tasks = [];

  @override
  void initState() {
    super.initState();
    _refreshTasks();
  }

  void _refreshTasks() async {
    final data = await SQLHelper.getTasks();
    setState(() {
      _tasks = data;
    });
  }

  List<DateTime> _getTaskDates() {
    return _tasks.map((task) => DateTime.parse(task['completionDate'])).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Task Calendar'),
      ),
      body: TableCalendar(
        firstDay: DateTime(2000),
        lastDay: DateTime(2100),
        focusedDay: _focusedDay,
        selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
        onDaySelected: (selectedDay, focusedDay) {
          setState(() {
            _selectedDay = selectedDay;
            _focusedDay = focusedDay;
          });
        },
        calendarFormat: CalendarFormat.month,
        calendarStyle: CalendarStyle(
          todayDecoration: BoxDecoration(
            color: Colors.blue,
            shape: BoxShape.circle,
          ),
          selectedDecoration: BoxDecoration(
            color: Colors.red,
            shape: BoxShape.circle,
          ),
          markerDecoration: BoxDecoration(
            color: Colors.green,
            shape: BoxShape.circle,
          ),
        ),
        eventLoader: (day) {
          List<DateTime> taskDates = _getTaskDates();
          return taskDates.where((taskDate) => isSameDay(taskDate, day)).toList();
        },
      ),
    );
  }
}
