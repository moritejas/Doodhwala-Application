// // ignore_for_file: non_constant_identifier_names
//
// import 'dart:convert';
//
// List<UserDetails> UserDetailsFromJson(String str) => List<UserDetails>.from(json.decode(str).map((x) => UserDetails.fromJson(x)));
//
// String UserDetailsToJson(List<UserDetails> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
//
// class UserDetails {
//   String id;
//   double quantityLiter;
//   String dateAndTime;
//
//   UserDetails({
//     required this.id,
//     required this.quantityLiter,
//     required this.dateAndTime,
//   });
//
//   factory UserDetails.fromJson(Map<String, dynamic> json) => UserDetails(
//     id: json["Id "],
//     quantityLiter: json["Quantity (Liter)"].toDouble(),
//     dateAndTime: json["Date and Time"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "Id ": id,
//     "Quantity (Liter)": quantityLiter,
//     "Date and Time": dateAndTime,
//   };
// }
import 'dart:convert';
/*
List<UserDetails> userDetailsFromJson(String str) => List<UserDetails>.from(json.decode(str).map((x) => UserDetails.fromJson(x)));
// String userDetailsToJson(List<UserDetails> data) =>
//     json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
class UserDetails {
  String id;
  double quantityLiter;
  c sdate;
  int newtime;
  UserDetails({
    required this.id,
    required this.quantityLiter,
    required this.sdate,
    required this.newtime,
  });
  factory UserDetails.fromJson(Map<String, dynamic> json) {

    // DateTime time = DateTime.fromMillisecondsSinceEpoch(
    //     json["Date and Time"],isUtc:false);
    return UserDetails(
        id: json["Id "],
        quantityLiter: json["Quantity (Liter)"].toDouble(),
        sdate: json["Time"],
        newtime: json["Date"]
      );
  }
  // Map<String, dynamic> toJson() => {
  //       "Id ": id,
  //       "Quantity (Liter)": quantityLiter,
  //       "Date and Time": dateAndTime, // Convert DateTime to string
  //     };
}

*/
// /*
List<UserDetails> userDetailsFromJson(String str) =>
    List<UserDetails>.from(json.decode(str).map((x) =>
    UserDetails.fromJson(x)));

// String userDetailsToJson(List<UserDetails> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UserDetails {
  int uniqid;
  String id;
  double quantityLiter;
  String timeg;
  DateTime dateAndTime;

  UserDetails({
    required this.uniqid,
    required this.id,
    required this.quantityLiter,
    required this.timeg,
    required this.dateAndTime,
  });

  factory UserDetails.fromJson(Map<String, dynamic> json)
  {
    // Parse the time to a DateTime object and convert to local time
    // DateTime utcTime = DateTime.parse(json["Time"]);
    // DateTime localTime = utcTime.toLocal();
    return UserDetails(
    id: json["Id"],
    uniqid: json["Uniq-Id"],
    quantityLiter: json["Quantity (Liter)"].toDouble(),
    // timeg: DateTime.parse(json["Time"]),
    timeg: json["Time"],
    // timeg: localTime,
    dateAndTime: DateTime.parse(json["Date"]),
    // dateAndTime:json["Date"],
  );
  }
  // Map<String, dynamic> toJson() => {
  //   "Id": id,
  //   "Quantity (Liter)": quantityLiter,
  //   "Time": timeg,
  //   "Date": dateg,
  // };
}
// */