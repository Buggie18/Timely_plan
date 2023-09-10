import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:timely_plan/src/services/notification_services.dart';
import 'package:timely_plan/src/utils/theme/themes.dart';

import '../../../services/theme_servies.dart';
import '../../../utils/widgets/button.dart';
import 'add_task_bar.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  DateTime _selectedDate = DateTime.now();
  var notifyHelper;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    notifyHelper = NotifyHelper();
    notifyHelper.initializeNotification();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: Column(
       children: [
        _addTaskBar(),
         _addDateBar(),
       ],
      ),
    );
  }
  _addDateBar(){
    return Container(
      margin: const EdgeInsets.only(top: 20, left: 20),
      child: DatePicker(
          DateTime.now(),
          height: 100,
          width: 80,
          initialSelectedDate: DateTime.now(),
          selectedTextColor: Colors.white,
          selectionColor: primaryClr,
          dateTextStyle: GoogleFonts.lato(
              textStyle: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey
              )
          ),
          dayTextStyle: GoogleFonts.lato(
              textStyle: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey
              )
          ),
          monthTextStyle: GoogleFonts.lato(
              textStyle: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey
              )
          ),
          onDateChange: (date) {
            _selectedDate = date;
          }
      ),
    );
  }
  _addTaskBar(){
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(DateFormat.yMMMMd().format(DateTime.now()),
                    style: subHeadingStyle),
                Text("Today",
                  style: headingStyle,)
              ],
            ),
          ),
          MyButton(label: "+ Add Task", onTap: ()=> Get.to(const AddTaskPage()))
        ],
      ),
    );
  }
  _appBar(){
     return AppBar(
       elevation: 0,
       backgroundColor: context.theme.backgroundColor,
       leading: GestureDetector(
         onTap:() {
           ThemeServices().switchTheme();
           notifyHelper.displayNotification(
             title: "Theme Changed",
               body:Get.isDarkMode?"Activated Light Theme":"Activated Dark Theme"
           );
           notifyHelper.scheduledNotification();
         },
         child: Icon(Get.isDarkMode? Icons.wb_sunny_outlined:Icons.nightlight_round,
         size: 20,
         color: Get.isDarkMode ? Colors.white:Colors.black
         ),
       ) ,
       actions: const [
           Icon(Icons.person,
           size: 20,),
         SizedBox(width: 20,),
       ],
     );
  }
}



