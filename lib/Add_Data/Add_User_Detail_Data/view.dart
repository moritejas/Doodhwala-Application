// ignore_for_file: unused_import, avoid_print, library_private_types_in_public_api, non_constant_identifier_names, file_names, use_build_context_synchronously, unused_element, unused_field, deprecated_member_use
// import 'package:share_plus/share_plus.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:auto_size_text/auto_size_text.dart';
import '../../model/User_Details_model_class/model_user_detail.dart';
import 'package:intl/intl.dart';

class UserDetailsPage extends StatefulWidget {
  const UserDetailsPage(
      {super.key, required this.name, required this.id, required this.phones});
  final String name;
  final String id;
  final dynamic phones;
  @override
  _UserDetailsPageState createState() => _UserDetailsPageState();
}

class _UserDetailsPageState extends State<UserDetailsPage> {
  List<UserDetails> userDetailsList = []; // Placeholder for fetched data
  late DateTime _selectedDate;
  double _TotalRupees = 0.0;
  bool _isLoading = true;
  bool isSorted = false;

//   Sort Item Function
  void _sortItems() {
    setState(() {
      userDetailsList.sort(
        (a, b) => a.dateAndTime.compareTo(b.dateAndTime),
      );
    });
  }

//  Fetch Data
  Future<void> fetchDatasFromApi(
      String userid, int selectedMonth, int selectedYear) async {
    try {
      var baseUrl =
          'https://script.google.com/macros/s/AKfycbwIYwpGhRzOBE8204JqDjK4fWwnp-2MBIGIPGB0yHVWT2Q7dVgE1i2Tpyj9am9AlPrJ/exec';

      final Uri uri = Uri.parse('$baseUrl?action=getUserdetails&idno=$userid&');
      final response = await http.get(uri, headers: {});

      if (response.statusCode == 200) {
        final tempList = userDetailsFromJson(response.body);
        // Filter data by selected month and year
        setState(() {
          userDetailsList = tempList
              .where((user) =>
                  user.dateAndTime.month == selectedMonth &&
                  user.dateAndTime.year == selectedYear)
              .toList();
          _TotalRupees = calculateTotalQuantity() * 60;
          _isLoading = false;
        });
      }
      else {
        throw Exception('Failed to load data from API');
        // Center(
        //   child: CircularProgressIndicator,
        // );
      }
    }
    catch (error) {
      print(error.toString()); // Print error for debugging purposes
      // Handle errors appropriately
    }
  }







//  Calculate Quantity
  double calculateTotalQuantity() {
    double total = 0.0;
    for (var user in userDetailsList) {
      total += user.quantityLiter;
    }
    return total;
  }

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now();
    // Fetch data for the current month initially
    fetchDatasFromApi(widget.id, DateTime.now().month, DateTime.now().year);
  }

  @override
  Widget build(BuildContext context) {
// Scaffold
    return Scaffold(
      backgroundColor: Colors.deepPurpleAccent,

//  AppBar
      appBar: AppBar(
        backgroundColor: Colors.white,
        // Back Button
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.arrow_back_sharp),
        ),
        title: Text(
          widget.name,
          style: const TextStyle(
              // color:Colors.white,
              fontSize: 27,
              fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
        actions: [
          // Icon(CupertinoIcons.),

          IconButton(
            icon: const Icon(Icons.sort_rounded,
              // color: Colors.deepPurple,
            ),
            onPressed: _sortItems,
          ),
          IconButton(
            onPressed: () {
              final url = 'https://wa.me/${widget.phones}?text='
                  '${Uri.encodeComponent('The total milk of "${_selectedDate.month}" Month ${_selectedDate.year}Year has been ${calculateTotalQuantity()}'
                      'liters and its cost is $_TotalRupees Rupees')}';
              launchUrl(
                Uri.parse(url),
              );
            },
            icon: SvgPicture.asset('assets/icons/whatsappsv.svg', height: 28, width:28,
              // color: Colors.deepPurple,
            ),
            // icon: Image.asset('assets/icons/whatsappsv.svg'),

            // iconSize:25 ,
          ),
        ],
      ),

//  Drawer
//       drawer: Drawer(
//         child: IconButton(
//           icon: const Icon(Icons.ac_unit),
//           onPressed: _sortItems,
//         ),
//       ),

//  Body
      body:
          // Add Background image

          // DecoratedBox (
          //     decoration: const BoxDecoration(
          //       image:  DecorationImage(
          //       image: AssetImage('images/image01.png.jpg'),
          //         fit: BoxFit.cover,
          //     ),),

          // child:
          Column(
        children: [
//  Selected Month
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              // color: Colors.white,
              height: 200,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: CupertinoDatePicker(
                // maximumYear: DateTime.now(),
                // maximumDate: DateTime.now(),
                initialDateTime: DateTime.now(),
                mode: CupertinoDatePickerMode.monthYear,
                onDateTimeChanged: (DateTime newDateTime) {
                  setState(() {
                    _isLoading = true;
                    fetchDatasFromApi(
                        widget.id, newDateTime.month, newDateTime.year);
                    if (userDetailsList.isEmpty) {
                      const Row(
                        children: [Text("Is Empty")],
                      );
                    }
                  });
                },
              ),
            ),
          ),
          _isLoading
              ? const CircularProgressIndicator()
              : const SizedBox(), // Show CircularProgressIndicator if data is loading

//  Show Total Quantity and Total rupees
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 8, 15, 8),
            child: Card(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  // crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        // const Icon(Icons.today),
                        Image.asset(
                          'assets/icons/clipboard.png',
                          height: 30,
                          width: 30,
                        ),
                        Text(
                          calculateTotalQuantity().toStringAsFixed(2),
                          style: const TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Icon(Icons.attach_money_rounded,size: 32,),
                        Text(
                          _TotalRupees.toStringAsFixed(2),
                          style: const TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),

// Show Selected Month Data
          Expanded(
            child: ListView.builder(
              itemCount: userDetailsList.length,
              itemBuilder: (context, index) {
                UserDetails user = userDetailsList[index];
                String formatedDate = DateFormat('dd-MM-yyyy').format(user.dateAndTime);
                // TimeOfDayFormat formatedTime = TimeOfDayFormat('hh:mm:a').format(user.timeg);
             // DateTime time = user.timeg; // Assuming user.timeg is a TimeOfDay object
                // DateTime time = DateTime.now(); // Assuming user.timeg is a TimeOfDay object
                // DateTime now = DateTime.now();
                // DateTime dateTime = DateTime(now.year, now.month, now.day, time.hour, time.minute);
                // String formattedTime = DateFormat('h:mm a').format(user.timeg);
                return Padding(
                  padding: const EdgeInsets.all(8),
                  child: Card(
                    color: Colors.white,
                    elevation: 10,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15),
                          bottomLeft: Radius.circular(15),
                          bottomRight: Radius.circular(15),),
                    ),
                    child: ListTile(
                        // title: Text('ID: ${user.id}'),
                        subtitle:
                             Column(
                              children: [
                              Row(
                                children: [
                             SvgPicture.asset('assets/icons/milk_icon.svg', height: 28, width:28,
                               // color: Colors.deepPurple,
                             ),
                                  const SizedBox(width:2),
                                  Text(" ${user.quantityLiter.toStringAsFixed(2)} liters ",style: const TextStyle(
                                    // color:Colors.deepPurpleAccent,
                                      fontSize: 17),)
                                ],
                              ),
                                Row(
                                  children: [
                                    const Icon(Icons.calendar_month_outlined,
                                      color: Colors.black, ),
                                    const SizedBox(width:10),
                                    Text(formatedDate,style: const TextStyle(
                                      // color:Colors.deepPurpleAccent,
                                        fontSize: 17),)
                                  ],
                                ),
                                Row(
                                  children: [
                                    const Icon(Icons.access_time_sharp,color: Colors.black,),
                                    const SizedBox(width:10),
                                    Text(user.timeg,
                                      style: const TextStyle(
                                        // color:Colors.deepPurpleAccent,
                                          fontSize: 17),)
                                  ],
                                ),
                              ],
                            ),
  /*                          
                        Text(
                            '\tQuantity: ${user.quantityLiter.toStringAsFixed(2)} liters'
                                '\n Date: $formatedDate '
                                '\n Time: $formattedTime'
                                '\n Uniq Id: ${user.uniqid}'
                        ),
*/
                        onLongPress: () {
                          // delete operation
                          Get.defaultDialog(
                            backgroundColor: Colors.deepPurpleAccent,
                            barrierDismissible: false,
                            title: "Confirm Delete Item",
                              titleStyle:const TextStyle(color:Colors.white),
                            content: Text("Are you sure you want to Delete Quantity: ${userDetailsList[index].quantityLiter} Liter ?",
                              style: const TextStyle(color:Colors.white),),

                              cancel : ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  elevation:8,
                                  // foregroundBuilder:Colors.white ,
                                  // backgroundColor: Colors.deepPurpleAccent,
                                ),
                                  onPressed: (){
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text("Cancel")),

                           confirm:   ElevatedButton(
                                  onPressed: (){

                                    _deleteItem(
                                        // quantitys, ids, date, time
                                        // userDetailsList[index].quantityLiter,
                                        // userDetailsList[index].id,
                                        // userDetailsList[index].dateAndTime,
                                        userDetailsList[index].uniqid,
                                    );
                                    // Navigator.of(context).pop;
                                    Get.back();
                                  },
                                  style: ElevatedButton.styleFrom(
                                    elevation:8,
                                  ),
                                  child: const Text("Ok"))
                          );
                        }),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      // ),
    );
  }

// Delete User Data
  void _deleteItem(int uniqueid) async {
    try {
      // String dateString = date.toIso8601String();
      // String timeString = time.toIso8601String();

      String scriptUrl =
          'https://script.google.com/macros/s/AKfycbwIYwpGhRzOBE8204JqDjK4fWwnp-2MBIGIPGB0yHVWT2Q7dVgE1i2Tpyj9am9AlPrJ/exec';
      // final Uri uri = Uri.parse('$scriptUrl?action=deleteUserData&quantityLiter=$Quantitys&id=$ids&dateAndTime=$dateandtime');
      final Uri uri = Uri.parse('$scriptUrl?action=deleteUserData&uniqid=$uniqueid');
      final response = await http.get(uri, headers: {});
      if (response.statusCode == 200) {
        setState(() {
          userDetailsList.removeWhere((element) => element.uniqid ==uniqueid);
          Get.snackbar(
            "Data",
            'Delete Successfully',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.black45, // Background color
            colorText: Colors.white,
            // backgroundColor: Colors.white,
            borderRadius: 7,
            animationDuration: const Duration(milliseconds: 1300),
          ); // milliseconds:1500
        });
      } else {
        throw Exception('Failed to delete item');
      }
    }
    catch (error) {
      print('Error deleting item: $error');
      Get.snackbar(
        'Error',
        'Failed to delete item',
        titleText: const Text(
          'Error',
          style: TextStyle(color: Colors.white),
        ),
        messageText: const Text(
          'Failed to delete item',
          style: TextStyle(color: Colors.white),
        ),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.black45,
        borderRadius: 7,
        animationDuration: const Duration(milliseconds: 1300),
      );
    }
  }
/*
  Widget buildBody() {
    if (userDetailsList.isEmpty) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else {
      if (!isSorted) {
        isSorted = true;
      }
      return
        ListView.builder(
          itemCount: userDetailsList.length,
          itemBuilder: (context, index) {
            UserDetails user = userDetailsList[index];
            return Padding(
              padding: const EdgeInsets.fromLTRB(25, 10, 25, 10),
              child: Card(
                elevation: 10,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.zero,
                      topRight: Radius.circular(25),
                      bottomLeft: Radius.circular(25),
                      bottomRight: Radius.zero),
                ),
                child: ListTile(
                    title: Text('ID: ${user.id}'),
                    subtitle: Text(
                        '\tQuantity: ${user.quantityLiter.toStringAsFixed(2)} liters\n Date Time: ${user.dateAndTime} '),
                    // trailing: Text('Price: ${user.price}'),
                    onLongPress: () {
                      // delete operation
                      _deleteItem(
                          userDetailsList[index].quantityLiter,
                          userDetailsList[index].id,
                          userDetailsList[index].newtime);
                    }),
              ),
            );
          },
        );
    }
  }
*/
}
