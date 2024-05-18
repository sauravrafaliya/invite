import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:invitation/services/http_services.dart';
import 'package:invitation/services/shared_preference_services.dart';
import 'package:invitation/services/url_launcher_services.dart';

import '../model/guest_model.dart';

class SendInvitation extends ChangeNotifier{

  static SendInvitation? _instance;

  SendInvitation._();

  factory SendInvitation.instanceFor(){
    return _instance ??= SendInvitation._();
  }

  static SendInvitation get instance{
    return SendInvitation.instanceFor();
  }

  AppLifecycleListener? _appLifecycleListener;

  Completer<bool>? completer;

  Future<void> init()async{
    allGuestList = await HttpServices.getGuestList();
    refreshList();
    initialAppLifeCycle();
    notifyListeners();
  }

  void initialAppLifeCycle(){
    _appLifecycleListener = AppLifecycleListener(
      onResume: (){
        if(completer != null){
          completer?.complete(true);
        }
      },
      onDetach: (){
        _appLifecycleListener?.dispose();
      }
    );
  }

  ValueNotifier<bool> invitationStart = ValueNotifier<bool>(false);

  List<Guest> allGuestList = [];
  ValueNotifier<List<Guest>> invitedGuestList = ValueNotifier<List<Guest>>([]);
  ValueNotifier<List<Guest>> reamingGuestList = ValueNotifier<List<Guest>>([]);

  bool isComplete = true;

  void refreshList(){
    updateInvitedGuestList();
    updateRemainingGuestList();
  }

  void updateInvitedGuestList(){
    invitedGuestList.value = allGuestList.where((element) => (element.status??false)).toList();
    notifyListeners();
  }

  void updateRemainingGuestList(){
    reamingGuestList.value = allGuestList.where((element) => !(element.status??false)).toList();
    notifyListeners();
  }

  Future<void> sendWhatsappInvitation()async{
    changeInvitationFlag();
    for (var guest in reamingGuestList.value) {
      completer = null;
      if(invitationStart.value){
        completer = Completer<bool>();
        await UrlLauncherServices.instance.sendToWhatsApp(guest);
        final status = await completer?.future;
        completer = null;
        if(invitationStart.value && (status??false)){
          await updateGuestInvitationStatus(guest,true);
          await Future.delayed(const Duration(seconds: 5));
        }else{
          break;
        }
      }else{
        break;
      }
      if(reamingGuestList.value.isEmpty){
        changeInvitationFlag();
      }
    }
  }

  Future<void> updateGuestInvitationStatus(Guest guest,bool status)async{
    int index = allGuestList.indexWhere((element) => element.number == guest.number);
    if(index >= 0){
      allGuestList[index].status = status;
      if(status){
        await SharedPreferenceServices.instance.setInvitedContactToPref(allGuestList[index]);
      }else{
        await SharedPreferenceServices.instance.removeContactFromPreference(allGuestList[index]);
      }
    }
    refreshList();
  }

  void changeInvitationFlag(){
    invitationStart.value = !invitationStart.value;
    notifyListeners();
  }

}