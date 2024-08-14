
class Tips_Guideline {

  Tips_Guideline({
    required this.date,
    required this.description,
    required this.image,
    required this.title,
    required this.p_id
  });

  String date;
  String description;
  String image;
  String title;
  String p_id;


  factory Tips_Guideline.fromJson(Map<String, dynamic> json) => Tips_Guideline(
    date: json['Date'],
    description: json['Description'],
    image: json['Image'],
    title: json['Title'],
    p_id: json['P_ID'],

  );

  Map<String, dynamic> toJson() => {
    'Date': date,
    'Description': description,
    'Image': image,
    'Title': title,
    'P_ID': p_id,

  };

}