


class Pickup_Model {

  Pickup_Model({
    required this.name,
    required this.mobile,
    required this.location,
    required this.date,
    required this.time,
    required this.note,
    required this.status,
    required this.uid,
  });

  String name;
  String mobile;
  String location;
  String date;
  String time;
  String note;
  String status;
  String uid;


  factory Pickup_Model.fromJson(Map<String, dynamic> json) => Pickup_Model(
    name: json['Name'],
    mobile: json['Mobile'],
    location: json['Location'],
    date: json['Req_Date'],
    time: json['Time'],
    note: json['Note'],
    status: json['Status'],
    uid: json['U_ID'],

  );

  Map<String, dynamic> toJson() => {
    'U_ID': uid,
    'Status': status,
    'Note': note,
    'Time': time,
    'Req_Date': date,
    'Location': location,
    'Mobile': mobile,
    'Name': name,

  };



}