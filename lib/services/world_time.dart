import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {
  String location;
  String time;
  String flag; // url to an assest
  String url; // location url for api endpoints
  bool isDaytime;

  WorldTime({this.location,this.flag,this.url});

  Future<void> getTime() async {

    try{
      // simulate network request
      Response response = await get('http://worldtimeapi.org/api/timezone/$url');
      Map data = jsonDecode(response.body);
      //print(data);

      //get properties from json
      String datetime = data['datetime'];
      String offset = data['utc_offset'].substring(1,3);
      // print(datetime);
      //(offset);

      //create a datetime object
      DateTime now = DateTime.parse(datetime);
      now = now.add(Duration(hours: int.parse(offset)));

      isDaytime = now.hour > 6 && now.hour < 20 ? true : false;
      //Set time property
      time = DateFormat.jm().format(now);

    }catch(e){
      print('Caught Error: $e');
      time = 'Could not get the time';
    }

  }
}