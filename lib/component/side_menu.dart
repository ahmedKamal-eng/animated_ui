import 'package:animated_ui/component/side_menu_tile.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import '../models/menu.dart';
import '../utils/rive_utils.dart';
import 'info_card.dart';

class SideMenu extends StatefulWidget {

  Menu selectedMenu=sidebarMenus.first;

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: 288,
        height: double.infinity,
        color: Color(0xff17203a),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 30,),
              InfoCard(
                name: "Ahmed Kamal",
                profession: "Developer",
              ),
              Padding(
                padding: const EdgeInsets.only(left: 24, right: 32, bottom: 16),
                child: Text(
                  "Browse".toUpperCase(),
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(color: Colors.white70),
                ),
              ),
              ...sidebarMenus.map((menu) =>SideMenuTile(menu: menu, press: (){
                setState(() {
                  widget.selectedMenu=menu;
                });
                menu.rive.status!.change(true);
                Future.delayed(Duration(milliseconds: 500),(){
                  menu.rive.status!.change(false);
                });
              }, riveonInit: (artboard){
                StateMachineController controller= RiveUtils.getRiveController(artboard,menu.rive.stateMachineName);
                menu.rive.status = controller.findSMI("active") as SMIBool;
              }, isActive:widget.selectedMenu == menu ?true:false),),
              Padding(
                padding: const EdgeInsets.only(left: 24, right: 32, bottom: 16),
                child: Text(
                  "history".toUpperCase(),
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(color: Colors.white70),
                ),
              ),
              ...sidebarMenus2.map((menu) =>SideMenuTile(menu: menu, press: (){
                setState(() {
                  widget.selectedMenu=menu;
                });
                menu.rive.status!.change(true);
                Future.delayed(Duration(milliseconds: 500),(){
                  menu.rive.status!.change(false);
                });
              }, riveonInit: (artboard){
                StateMachineController controller= RiveUtils.getRiveController(artboard,menu.rive.stateMachineName);
                menu.rive.status = controller.findSMI("active") as SMIBool;
              }, isActive:widget.selectedMenu == menu ?true:false),),
            ],
          ),
        ),
      ),
    );
  }
}
