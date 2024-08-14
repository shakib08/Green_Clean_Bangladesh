
class Report_Guideline_Model {

  Report_Guideline_Model({
    required this.date,
    required this.description,
    required this.image,
    required this.location,
    required this.p_id,
    required this.submitted_as,
    required this.time,
    required this.u_id,
    required this.title,
  });

  String date;
  String description;
  String image;
  String location;
  String p_id;
  String submitted_as;
  String time;
  String u_id;
  String title;


  factory Report_Guideline_Model.fromJson(Map<String, dynamic> json) => Report_Guideline_Model(
    date: json['Date'],
    description: json['Description'],
    image: json['Image'],
    location: json['Location'],
    p_id: json['P_ID'],
    submitted_as: json['Submitted_As'],
    time: json['Time'],
    u_id: json['U_ID'],
    title: json['Title'],
  );

  Map<String, dynamic> toJson() => {
    'Date': date,
    'Description': description,
    'Image': image,
    'Location': location,
    'P_ID': p_id,
    'Submitted_As': submitted_as,
    'Time': time,
    'U_ID': u_id,
    'Title': title,
  };

}