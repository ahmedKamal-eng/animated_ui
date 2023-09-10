import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

import '../models/menu.dart';
class SideMenuTile extends StatelessWidget {

  final Menu menu;
  final VoidCallback press;
  final ValueChanged<Artboard> riveonInit;
  final bool isActive;

  SideMenuTile({required this.menu,required this.press,required this.riveonInit,required this.isActive});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
      AnimatedPositioned(
          width:isActive? 288 : 0,
          height: 56,
          child: Container(

          decoration: BoxDecoration(
            color: Color(0xff6792ff),
            borderRadius: BorderRadius.circular(10),
          ),
        ), duration: Duration(milliseconds: 300)) ,
        Column(
          children: [
            Divider(height: 5,color: Colors.white54,),
            ListTile(
              onTap: press,
              leading: SizedBox(
              height: 34,
              width: 34,
              child: RiveAnimation.asset(menu.rive.src,
                artboard: menu.rive.artboard,
                onInit: riveonInit,
              ),
            ),
              title: Text(menu.title,style: TextStyle(color: Colors.white),),
            ),
          ],
        ),
      ],
    );
  }
}

