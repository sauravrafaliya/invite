import 'package:flutter/material.dart';
import 'package:invitation/application/send_invitation.dart';
import 'package:invitation/model/guest_model.dart';
import 'package:invitation/utils/size_utils.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin{

  late TabController tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 3,
        title: const Text("Contacts"),
        bottom: TabBar(
          padding: const EdgeInsets.only(top: 10),
          indicatorSize: TabBarIndicatorSize.tab,
          controller: tabController,
          tabs: const [
            Icon(Icons.person),
            Icon(Icons.check_circle)
          ],
        ),
      ),
      body: SizedBox(
        width: context.screenWidth,
        height: context.screenHeight,
        child: TabBarView(
          controller: tabController,
          children: [
            ValueListenableBuilder<List<Guest>>(
              valueListenable: SendInvitation.instance.reamingGuestList,
              builder: (context,value,child){
                return _buildGuestListView(value);
              }
            ),
            ValueListenableBuilder<List<Guest>>(
              valueListenable: SendInvitation.instance.invitedGuestList,
              builder: (context,value,child){
                return _buildGuestListView(value,true);
              }
            ),
          ],
        ),
      ),
      floatingActionButton: ValueListenableBuilder<bool>(
        valueListenable: SendInvitation.instance.invitationStart,
        builder: (context,status,child){
          return FloatingActionButton(
            child: !status ? const Icon(Icons.send) : const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: Text("STOP"),
            ),
            onPressed: ()async{
              if(!status){
                SendInvitation.instance.sendWhatsappInvitation();
              }else{
                SendInvitation.instance.changeInvitationFlag();
              }
            },
          );
        },
      ),
    );
  }

  Widget _buildGuestListView(List<Guest> value,[bool? isInvited]){
    return ListView.separated(
        padding: const EdgeInsets.all(12),
        separatorBuilder: (context,index){
          return const SizedBox(height: 8,);
        },
        itemCount: value.length,
        itemBuilder: (context,index){
          Guest guestObj = value[index];
          return _buildGuestCardWidget(guestObj,isInvited);
        }
    );
  }

  Widget _buildGuestCardWidget(Guest guest,[bool? isInvited]){
    return Card(
      child: ListTile(
        title: Text(guest.name??""),
        subtitle: Text("+91 ${guest.number}"),
        trailing: (isInvited??false) ? IconButton(
          icon: const Icon(Icons.delete),
          onPressed: (){
            SendInvitation.instance.updateGuestInvitationStatus(guest, false);
          },
        ) : null,
      ),
    );
  }
}
