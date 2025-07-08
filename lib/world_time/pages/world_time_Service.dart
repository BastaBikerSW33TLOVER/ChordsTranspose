import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

class WorldTimeService {
  String? location;
  String? time;
  String? urlCont;
  String? urlCount;
  bool? isDaytime;

  WorldTimeService({this.location, this.urlCont, this.urlCount});

  Future<void> getTime() async {
    try {
      final url = 'https://www.timeapi.io/api/time/current/zone?timeZone=$urlCont/$urlCount';
      Response response = await get(Uri.parse(url));
      Map data = jsonDecode(response.body);

      String datetime = data['dateTime'];
      DateTime now = DateTime.parse(datetime);


      isDaytime = now.hour >= 6 && now.hour < 18;
      time = DateFormat.jm().format(now);
    } catch (e) {
      print('Error: $e');
      time = 'Error: time not available';
      isDaytime = false;
    }
  }
}