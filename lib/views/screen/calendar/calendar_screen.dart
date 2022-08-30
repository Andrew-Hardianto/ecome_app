import 'dart:convert';

import 'package:ecome_app/controllers/main_service.dart';
import 'package:ecome_app/views/screen/widget/text_appbar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:ecome_app/utils/extension.dart';

class CalendarScreen extends StatefulWidget {
  static const String routeName = '/calendar';
  const CalendarScreen({Key? key}) : super(key: key);

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  var mainService = MainService();

  DateTime currentDate = new DateTime.now();
  String? startTimeSheet;
  String? endTimeSheet;

  List<dynamic> dataTimeSheet = [];

  List<dynamic> datesOnTime = [0];
  List<dynamic> monthsOnTime = [];

  List<dynamic> datesNoCheckInOut = [0];
  List<dynamic> monthsNoCheckInOut = [];

  List<dynamic> datesLate = [0];
  List<dynamic> monthsLate = [];

  List<dynamic> datesOff = [0];
  List<dynamic> monthsOff = [];

  List<dynamic> datesAlpha = [0];
  List<dynamic> monthsAlpha = [];

  List<dynamic> datesHoliday = [0];
  List<dynamic> monthsHoliday = [];

  List<dynamic> datesLeave = [0];
  List<dynamic> monthsLeave = [];

  List<dynamic> datesSick = [0];
  List<dynamic> monthsSick = [];

  @override
  void initState() {
    super.initState();
    startTimeSheet = DateFormat('yyyy-MM-dd')
        .format(new DateTime(currentDate.year, currentDate.month, 1));
    endTimeSheet = DateFormat('yyyy-MM-dd')
        .format(new DateTime(currentDate.year, currentDate.month + 1, 0));
    getTimeShett(startTimeSheet!, endTimeSheet!);
  }

  getTimeShett(String start, String end) async {
    // var url = await mainService.urlApi() +
    //     '/api/v1/user/tm/timesheet?start=' +
    //     start +
    //     '&end=' +
    //     end;
    var url = 'https://ng-api-dev.gitsolutions.id/api/user/time-sheet?start=' +
        start +
        '&end=' +
        end;

    mainService.getUrl(url, (res) async {
      if (res.statusCode == 200) {
        var data = jsonDecode(res.body);
        // print(data);
        setState(() {
          dataTimeSheet = data;
        });
        onDayChange(currentDate);
      } else {
        mainService.errorHandling(res, context);
      }
    });
  }

  onDayChange(selectDate) {
    var day = DateFormat('dd').format(selectDate);
    var month = DateFormat('MM').format(selectDate);
    var year = DateFormat('yyyy').format(selectDate);
    var selectedDate = year + '-' + month + '-' + day;
    handleCalendar(dataTimeSheet, selectedDate);
  }

  handleCalendar(data, String? day) {
    var arrDateNoCheckInOut = [];
    var arrNoCheckInout = data
        .where((res) => !res['isDayOff'] && res['holiday'] == null)
        .toList();
    for (var i = 0; i < arrNoCheckInout.length; i++) {
      arrDateNoCheckInOut.add(DateFormat('d')
          .format(DateTime.parse(arrNoCheckInout[i]['startDate'])));
    }

    var arrAlpha = [];
    var alpha = data
        .where((res) => res['isAlpha'] != null && !res['isAlpha'] == true)
        .toList();
    for (var i = 0; i < alpha.length; i++) {
      arrAlpha
          .add(DateFormat('d').format(DateTime.parse(alpha[i]['startDate'])));
    }

    var arrDateOnTime = [];
    var onTimeDay = data
        .where((res) =>
            res['isDayOff'] == false &&
            res['isLateIn'] == false &&
            res['holiday'] == null &&
            res['actualInTime'] != null &&
            res['actualOutTime'] != null)
        .toList();
    for (var i = 0; i < onTimeDay.length; i++) {
      arrDateOnTime.add(
          DateFormat('d').format(DateTime.parse(onTimeDay[i]['startDate'])));
    }

    print(arrDateOnTime.length);

    setState(() {
      datesAlpha = arrAlpha;
      datesNoCheckInOut = arrDateNoCheckInOut;
      datesOnTime = arrDateOnTime;
    });
  }

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
            onPageChanged: (focusedDay) {
              print(focusedDay);
            },
            onDaySelected: (selectedDay, focusedDay) {
              print({'select': selectedDay, 'focus': focusedDay});
            },
            calendarBuilders: CalendarBuilders(
              defaultBuilder: (context, day, focusedDay) {
                var das = DateFormat('EEEE').format(day);
                Color warna;

                if (das == 'Saturday' || das == 'Sunday') {
                  warna = Colors.grey.shade400;
                } else if (datesOnTime.contains(day.day.toString())) {
                  warna = '#3DC0F0'.toColor();
                } else if (datesAlpha.contains(day.day.toString())) {
                  warna = '#FF7A00'.toColor();
                } else if (datesNoCheckInOut.contains(day.day.toString())) {
                  warna = '#CB84ED'.toColor();
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
