import 'package:ecome_app/views/screen/widget/text_appbar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarScreen extends StatefulWidget {
  static const String routeName = '/calendar';
  const CalendarScreen({Key? key}) : super(key: key);

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: TextAppbar(text: 'Calendar'),
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: TableCalendar(
            focusedDay: DateTime.now(),
            firstDay: DateTime(2010),
            lastDay: DateTime(2040),
            calendarBuilders: CalendarBuilders(
              defaultBuilder: (context, day, focusedDay) {
                var da = day.day;
                var das = DateFormat('EEEE').format(day);
                Color warna;

                if (da == 8) {
                  warna = Colors.orange;
                } else if (das == 'Saturday' ||
                    das == 'Sunday' && day.month == DateTime.now().month) {
                  warna = Colors.grey.shade400;
                } else {
                  warna = Colors.green;
                }

                return Container(
                  child: Center(
                    child: Text(
                      '${day.day}',
                      style: TextStyle(color: warna),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
