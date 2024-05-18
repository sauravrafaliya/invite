import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:invitation/model/guest_model.dart';
import 'package:invitation/services/shared_preference_services.dart';
class HttpServices{

  static Future<List<Guest>> getGuestList()async{
    List<Guest> guest = [];
    try{
      List<String> invitedContact = await SharedPreferenceServices.instance.getInvitedContactFormPref();
      var request = http.MultipartRequest("GET", Uri.parse("API"));
      http.StreamedResponse response = await request.send();
      String dataString = await response.stream.bytesToString();
      if(response.statusCode == 200){
        List data = jsonDecode(dataString);
        for (var element in data) {
          guest.add(Guest(
            number: element["number"].toString(),
            name: element["name"],
            status: invitedContact.contains(element["number"].toString())
          ));
        }
      }
    }catch (_){}
    return guest;
  }

}