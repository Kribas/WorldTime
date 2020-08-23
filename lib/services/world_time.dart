import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {

  String time;
  String location;
  String flag;
  String url;
  bool isDaytime;

  WorldTime({this.location,this.flag,this.url});


  Future<void> getTime() async {

    try {

      Response response = await get('http://worldtimeapi.org/api/timezone/$url');
      Map data = jsonDecode(response.body);

      print(response.body);

      String datetime = data['datetime'];
      String offset = data['utc_offset'].substring(1,3);

      DateTime now = DateTime.parse(datetime);
      now = now.add(Duration(hours: int.parse(offset)));

      time = DateFormat.jm().format(now);
      isDaytime = now.hour > 6 && now.hour < 20 ? true : false;

    }catch(e) {
      print('caught error: $e' );
      time = 'could not get time data';

    }

  }

}