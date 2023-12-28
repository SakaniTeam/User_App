// ignore_for_file: use_key_in_widget_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project_second/Pages/home_page.dart';
import 'package:table_calendar/table_calendar.dart';

class TourRequestPage extends StatefulWidget {
  TourRequestPage({Key? key, required this.request});

  final Map<String, dynamic> request;

  @override
  State<TourRequestPage> createState() => _TourRequestPageState();
}

final selectedTourTimeController = TextEditingController();

class _TourRequestPageState extends State<TourRequestPage> {
  DateTime today = DateTime.now();
  String selectedTourTime = '';
  DateTime selectedDay = DateTime.now(); // Initialize with the current date
  ValueNotifier<bool> isVirtualSelected = ValueNotifier<bool>(false);
  String pervertula = "";

  @override
  Widget build(BuildContext context) {
    void _handleTourTimeChange(String value) {
      setState(() {
        selectedTourTime = value;
      });
    }

    void _handleInPersonTap() {
      setState(() {
        isVirtualSelected.value = false;
        pervertula = "person";
      });
    }

    void _handleVirtualTap() {
      setState(() {
        isVirtualSelected.value = true;
        pervertula = "virtual";
      });
    }

    void _handleSubmit() {
      // Handle form submission here
      print('Form submitted!');
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              alignment: Alignment.topLeft,
              padding: EdgeInsets.only(top: 20.0, left: 8.0),
              child: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  size: 30.0,
                  color: Color.fromRGBO(118, 165, 209, 1),
                ),
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomePage(),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              'Tour Request',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 33,
                color:  Color.fromRGBO(65, 73, 106, 1),
                fontFamily: "Inria Serif"
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: _handleInPersonTap,
                  child: Container(
                    height: 50,
                    width: 160,
                    decoration: BoxDecoration(
                      color: isVirtualSelected.value
                          ? Colors.grey
                          : Colors.blue[600],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Center(
                      child: Text(
                        'In person',
                        style: TextStyle(fontFamily: "Inria Serif" ,
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 40,
                ),
                GestureDetector(
                  onTap: _handleVirtualTap,
                  child: Container(
                    height: 50,
                    width: 160,
                    decoration: BoxDecoration(
                      color: isVirtualSelected.value
                          ? Colors.blue[600]
                          : Colors.grey,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Center(
                      child: Text(
                        'Virtual',
                        style: TextStyle(
                          fontFamily: "Inria Serif" ,
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            const Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Icon(Icons.calendar_month),
                ),
                Text(
                  ' Select tour date',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18 ,fontFamily: "Inria Serif"),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              height: 300,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                border: Border.all(color: Colors.blue[600]!),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: TableCalendar(
                  locale: 'en_us',
                  headerStyle: const HeaderStyle(
                    formatButtonVisible: false,
                    titleCentered: true,
                  ),
                  rowHeight: 35,
                  selectedDayPredicate: (day) =>
                      isSameDay(day, selectedDay), // Updated predicate
                  focusedDay: today,
                  firstDay: today,
                  lastDay: DateTime.utc(2030, 01, 01),
                  onDaySelected: (selected, focused) {
                    setState(() {
                      selectedDay = selected;
                    });
                  },
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            const Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Icon(Icons.access_time),
                ),
                Text(
                  ' Select tour time',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18 ,fontFamily: "Inria Serif"),
                ),
              ],
            ),
            const SizedBox(
              height: 4,
            ),
            Row(
              children: [
                const SizedBox(width: 10),
                Radio(
                  value: '12:00 PM',
                  groupValue: selectedTourTime,
                  onChanged: (value) => _handleTourTimeChange(value as String),
                ),
                const Text('12:00 PM' , style: TextStyle(fontFamily: "Inria Serif") ,),
                const SizedBox(width: 20),
                Radio(
                  value: '11:00 AM',
                  groupValue: selectedTourTime,
                  onChanged: (value) => _handleTourTimeChange(value as String),
                ),
                const Text('11:00 AM', style: TextStyle(fontFamily: "Inria Serif")),
                const SizedBox(width: 20),
                Radio(
                  value: '7:00 PM',
                  groupValue: selectedTourTime,
                  onChanged: (value) => _handleTourTimeChange(value as String),
                ),
                const Text('7:00 PM', style: TextStyle(fontFamily: "Inria Serif")),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 80, right: 80),
              child: MaterialButton(
                height: 50,
                minWidth: double.infinity,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                color: Colors.blue[600],
                onPressed: _handleSubmit,
                child: GestureDetector(
                  onTap: () async {
                    final CollectionReference collRef =
                        FirebaseFirestore.instance.collection('requests');
                    await collRef.add({
                      "id": FirebaseAuth.instance.currentUser!.uid,
                      'selectedTourTime': selectedTourTime,
                      'selectedDay': selectedDay,
                      'pervertula': pervertula,
                      'image': '${widget.request['image']}',
                      'propertyType': '${widget.request['propertyType']}',
                      'latitude': '${widget.request['latitude']}',
                      'longitude': '${widget.request['latitude']}',
                      'address': '${widget.request['propertyAdress']}',
                      'oldphoneNumber': '${widget.request['phoneNumber']}',
                      'propertyDetails': '${widget.request['propertyDetails']}',
                      'propertyPrice': '${widget.request['propertyPrice']}',
                      'propertyRentDuration':
                          '${widget.request['propertyRentDuration']}',
                      'propertyStatus': '${widget.request['propertyStatus']}',
                    });

                    Navigator.pop(context);
                  },
                  child: const Text(
                    'Submit',
                    style: TextStyle(
                      fontFamily: "Inria Serif" ,
                      
                        fontWeight: FontWeight.bold,
                        fontSize: 26,
                        color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
