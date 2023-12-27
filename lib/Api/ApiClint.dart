import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/prayersTimeDataFromApi.dart';

Future<PrayerTimes> fetchPrayerTimes(var dis, var div) async {
  //var widget;
  final response = await http.get(Uri.parse(
      'https://api.aladhan.com/v1/timingsByAddress?address=$dis,$div,Bangladesh&method=1'));

  if (response.statusCode == 200) {
    final json = jsonDecode(response.body);
    final data = json['data'];
    return PrayerTimes.fromJson(data['timings']);
  } else {
    throw Exception('Failed to load prayer times');
  }
}
