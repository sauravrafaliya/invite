import 'package:invitation/const/preference_keys.dart';
import 'package:invitation/model/guest_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceServices{

  static SharedPreferenceServices? _instance;

  SharedPreferenceServices._();


  factory SharedPreferenceServices.instanceFor(){
    return _instance ??= SharedPreferenceServices._();
  }

  static SharedPreferenceServices get instance{
    return SharedPreferenceServices.instanceFor();
  }

  Future<List<String>> getInvitedContactFormPref()async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final invitedContact = preferences.getStringList(SharedPref.invitedContact);
    return invitedContact??[];
  }

  Future<bool> setInvitedContactToPref(Guest guest)async{
    List<String> oldContact = await getInvitedContactFormPref();
    oldContact.add(guest.number??"");
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setStringList(SharedPref.invitedContact, oldContact);
  }

  Future<bool> removeContactFromPreference(Guest guest)async{
    List<String> oldContact = await getInvitedContactFormPref();
    oldContact.remove(guest.number??"");
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setStringList(SharedPref.invitedContact, oldContact);
  }

}