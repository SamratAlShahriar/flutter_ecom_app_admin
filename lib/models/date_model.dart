import 'package:cloud_firestore/cloud_firestore.dart';

const String collectionDate = 'Date';
const String dateFieldTimestamp = 'date_timestamp';
const String dateFieldDay = 'date_day';
const String dateFieldMonth = 'date_month';
const String dateFieldYear = 'date_year';

class DateModel {
  Timestamp timestamp;
  num day;
  num month;
  num year;

  DateModel({
    required this.timestamp,
    required this.day,
    required this.month,
    required this.year,
  });

  //TODO: with timestamp
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      dateFieldTimestamp: timestamp,
      dateFieldDay: day,
      dateFieldMonth: month,
      dateFieldYear: year,
    };
  }

  //TODO: with timestamp
  factory DateModel.fromMap(Map<String, dynamic> map) {
    return DateModel(
        timestamp: map[dateFieldTimestamp],
        day: map[dateFieldDay],
        month: map[dateFieldMonth],
        year: map[dateFieldYear],);
  }
}
