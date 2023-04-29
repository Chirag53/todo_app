import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/to_do_modal.dart';
import '../res/common/Container.dart';
import '../res/common/button.dart';
import '../res/common/textfield.dart';
import '../res/constant/app_strings.dart';

class AddToDoScreen extends StatefulWidget {
  final List<ToDoModel>? toDoList;
  final int? index;
  const AddToDoScreen({
    Key? key,
    this.toDoList,
    this.index,
  }) : super(key: key);

  @override
  State<AddToDoScreen> createState() => _AddToDoScreenState();
}

class _AddToDoScreenState extends State<AddToDoScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController desController = TextEditingController();

  DateTime selectedDate = DateTime.now();
  bool? dateIsSelect = false;
  TimeOfDay selectedTime = TimeOfDay.now();
  bool? timeIsSelect = false;
  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    debugPrint("picked ---->> $selectedDate");
    debugPrint("picked ---->> $picked");

    if (picked != null && picked != selectedDate) {
      selectedDate = picked;
      dateIsSelect = true;
      setState(() {});
    }
  }

  Future<void> selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );

    debugPrint("picked ---->> $selectedTime");
    debugPrint("picked ---->> $picked");

    if (picked != null && picked != selectedTime) {
      selectedTime = picked;
      timeIsSelect = true;
      setState(() {});
    }
  }

  List<ToDoModel> toDoList = [];
  SharedPreferences? prefs;

  setInstant() async {
    prefs = await SharedPreferences.getInstance();
  }

  setData() {
    List<String> data = [];

    for (int i = 0; i < toDoList.length; i++) {
      data.add(jsonEncode(toDoList[i].toJson()));
    }
    debugPrint(data.toString());
    prefs!.setStringList('key', data);
  }

  @override
  void initState() {
    toDoList = widget.toDoList!;
    if (widget.index != null) {
      titleController.text = toDoList[widget.index!].title!;
      desController.text = toDoList[widget.index!].des!;
      selectedDate = DateFormat('d/M/y').parse(toDoList[widget.index!].date!);
      dateIsSelect = true;
      var hour =
          toDoList[widget.index!].time!.split(" ").first.split(":").first;
      var minute = toDoList[widget.index!].time!.split(" ").first.split(":")[1];
      selectedTime =
          TimeOfDay(hour: int.parse(hour), minute: int.parse(minute));
      timeIsSelect = true;
    }
    setInstant();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade50,
      appBar: AppBar(
        title:
            const Text(AppStings.addToDo, style: TextStyle(color: Colors.blue)),
        centerTitle: true,
        backgroundColor: Colors.blue.shade50,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: ListView(
          scrollDirection: Axis.vertical,
          physics: const BouncingScrollPhysics(),
          children: [
            // Text('WElCOME !'),
            Column(
              children: [
                AppTextField(
                  controller: titleController,
                  hintText: AppStings.enterTitle,
                ),
                const SizedBox(height: 15),
                Row(
                  children: [
                    const SizedBox(
                      width: 10,
                    ),
                    GestureDetector(
                      onTap: () => selectDate(context),
                      child: AppContainer(
                        icon: Icons.date_range,
                        hintText: dateIsSelect!
                            ? DateFormat.yMd().format(selectedDate)
                            : "Select Date",
                        isData: dateIsSelect!,
                      ),
                    ),
                    const SizedBox(width: 15),
                    GestureDetector(
                      onTap: () => selectTime(context),
                      child: AppContainer(
                        icon: Icons.timelapse,
                        hintText: timeIsSelect!
                            ? selectedTime.format(context)
                            : "Select Time",
                        isData: timeIsSelect!,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                AppTextField(
                  controller: desController,
                  hintText: AppStings.enterDescription,
                  isDes: true,
                  textInputAction: TextInputAction.done,
                ),
                const SizedBox(height: 15),
                GestureDetector(
                  onTap: () {
                    if (widget.index != null) {
                      toDoList[widget.index!] = ToDoModel(
                        title: titleController.text,
                        date: DateFormat.yMd().format(selectedDate),
                        time: selectedTime.format(context),
                        des: desController.text,
                      );
                    } else {
                      toDoList.add(
                        ToDoModel(
                          title: titleController.text,
                          date: DateFormat.yMd().format(selectedDate),
                          time: selectedTime.format(context),
                          des: desController.text,
                        ),
                      );
                    }
                    setData();
                    Navigator.pop(context, toDoList);
                  },
                  child: const AppButton(
                    width: 180,
                    title: AppStings.addToDo,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
