import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:timely_plan/src/utils/theme/themes.dart';
import 'package:timely_plan/src/utils/widgets/input_field.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({Key? key}) : super(key: key);

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  DateTime _selectedDate = DateTime.now();
  String _endTime = "9:30 PM";
  String _startTime = DateFormat("hhh:mm a").format(DateTime.now()).toString();
  int _selectedRemind = 5;
  List<int> remindList =[
    5,
    10,
    15,
    20
  ];

  String _selectedRepeat = "None";
  List<String> repeatList =[
    "None",
    "Daily",
    "Weekly",
    "Monthly",
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.backgroundColor,
      appBar: _appBar(context),
      body: Container(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Add Task",
                style: headingStyle,
              ),
              const MyInputField(title: "Title", hint: "Enter your Title"),
              const MyInputField(title: "Note", hint: "Enter your Note"),
              MyInputField(title: "Date", hint: DateFormat.yMd().format(_selectedDate),
              widget: IconButton(
                icon: const Icon(Icons.calendar_today_outlined,
                color: Colors.grey,),
                onPressed: (){
                  _getDateFromUser();
                },
              )),
              Row(
                children: [
                  Expanded(
                      child: MyInputField(
                        title: "Start date",
                        hint: _startTime,
                        widget: IconButton(
                          onPressed: (){
                            _getTimeFromUser(isStartTime:true);
                          },
                          icon: const Icon(
                            Icons.access_time_rounded,
                            color: Colors.grey,
                          ),

                        ),
                      )),
                  const SizedBox(width: 12,),
                  Expanded(
                      child: MyInputField(
                        title: "End date",
                        hint: _endTime,
                        widget: IconButton(
                          onPressed: (){
                            _getTimeFromUser(isStartTime:false);
                          },
                          icon: const Icon(
                            Icons.access_time_rounded,
                            color: Colors.grey,
                          ),

                        ),
                      )),
                ],
              ),
              MyInputField(title: "Remind", hint: "$_selectedRemind minutes early",
              widget: DropdownButton(
                  icon: const Icon(Icons.keyboard_arrow_down,
                  color: Colors.grey,),
                iconSize: 32,
                elevation: 4,
                style: subTitleStyle,
                underline: Container(
                  height:0
                ),
                items:remindList.map<DropdownMenuItem<String>>((int value){
                  return DropdownMenuItem<String>(
                    value: value.toString(),
                    child: Text(value.toString()),
                  );
                }
                ).toList(),
                onChanged: (String? newValue) {
                    setState(() {
                      _selectedRemind = int.parse(newValue!);
                    });
                },
              ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _appBar(BuildContext context){
    return AppBar(
      elevation: 0,
      backgroundColor: context.theme.backgroundColor,
      leading: GestureDetector(
        onTap:() {
          Get.back();
        },
        child: Icon(Icons.arrow_back_ios,
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
  _getDateFromUser() async{
    DateTime? _pickerDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate:DateTime(2015) ,
        lastDate: DateTime(2121));
    if (_pickerDate != null){
      setState(() {
        _selectedDate= _pickerDate;

      });
    }else{
      print("It's a null");
    }
  }
  _getTimeFromUser({required bool isStartTime}) async {
      var pickedTime = await _showTimePicker();
      String _formattedTime = pickedTime.format(context);
      if(pickedTime == null){
        print("Time Cancelled!");
      }else if(isStartTime==true){
        setState(() {
          _startTime=_formattedTime;
        });
      }else if(isStartTime== false){
        setState(() {
          _endTime=_formattedTime;
        });
      }
  }
  _showTimePicker(){
    return showTimePicker(
      initialEntryMode: TimePickerEntryMode.input,
        context: context,
        initialTime: TimeOfDay(
            hour: int.parse(_startTime.split(":")[0]),
            minute: int.parse(_startTime.split(":")[1].split(" ")[0]),
        ));
  }
}
