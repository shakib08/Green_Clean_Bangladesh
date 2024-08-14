

import 'package:green_clean_bangladesh/utils/report_feedback.dart';

class All_Opinion_Model {

  All_Opinion_Model({
    required this.u_id,
    required this.opinion,
  });

  String u_id;
  Report_Guideline_Model opinion;

  factory All_Opinion_Model.fromJson(Map<String, dynamic> json) => All_Opinion_Model(
    u_id: json['Date'],
    opinion: json['Description'],
  );


}