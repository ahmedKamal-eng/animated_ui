import 'dart:math';

import 'package:animated_ui/screens/home/home_screen.dart';
import 'package:animated_ui/utils/rive_utils.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

import 'component/animated_bar.dart';
import 'component/menu_btn.dart';
import 'component/side_menu.dart';
import 'constants.dart';
import 'models/menu.dart';
import 'models/rive_asset.dart';

class EntryPoint extends StatefulWidget {
  const EntryPoint({Key? key}) : super(key: key);

  @override
  State<EntryPoint> createState() => _EntryPointState();
}

class _EntryPointState extends State<EntryPoint>
    with SingleTickerProviderStateMixin {
  late SMIBool searchTigger;

  Menu selectedBottomNav = bottomNavs.first;
  late SMIBool isSideBarClose;
  bool isSideMenuClose = true;

  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 200),
    )..addListener(() {
        setState(() {});
      });
    _animation = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
        parent: _animationController, curve: Curves.fastOutSlowIn));

    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor2,
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          AnimatedPositioned(
            duration: Duration(milliseconds: 300),
            width: 288,
            left: isSideMenuClose ? -288 : 0,
            height: MediaQuery.of(context).size.height,
            child: SideMenu(),
          ),
          Transform(
            alignment: Alignment.center,
            transform: Matrix4.identity()..setEntry(3, 2, 0.001)..rotateY(_animation.value - 30 * _animation.value * pi / 180),
            child: Transform.translate(
                offset: Offset(_animation.value* 288, 0),
                child: Transform.scale(
                  scale: isSideMenuClose ? 1 : .8,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(20), child: HomePage()),
                )),
          ),
          AnimatedPositioned(
            duration: Duration(milliseconds: 200),
            left: isSideMenuClose ? 0 : 220,
            child: MenuBtn(
              riveOnInit: (artboard) {
                StateMachineController controller =
                    RiveUtils.getRiveController(artboard, "State Machine");
                isSideBarClose = controller.findSMI("isOpen") as SMIBool;
                isSideBarClose.value = true;
              },
              press: () {
                isSideBarClose.value = !isSideBarClose.value;
                if(isSideMenuClose){
                  _animationController.forward();
                }
                else{
                  _animationController.reverse();
                }
                setState(() {
                  isSideMenuClose = !isSideMenuClose;
                });
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: Transform.translate(
        offset: Offset(0, 100* _animation.value),
        child: SafeArea(
          child: Container(
            padding: const EdgeInsets.all(12),
            margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
            decoration: BoxDecoration(
              color: backgroundColor2.withOpacity(.8),
              borderRadius: BorderRadius.circular(24),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ...List.generate(bottomNavs.length, (index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        bottomNavs[index].rive.status!.change(true);
                        Future.delayed(const Duration(seconds: 1), () {
                          bottomNavs[index].rive.status!.change(false);
                        });
                        selectedBottomNav = bottomNavs[index];
                      });
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        AnimatedBar(
                            isActive: bottomNavs[index] == selectedBottomNav),
                        SizedBox(
                          height: 36,
                          width: 36,
                          child: Opacity(
                            opacity:
                                bottomNavs[index] == selectedBottomNav ? 1 : .5,
                            child: RiveAnimation.asset(
                              bottomNavs[index].rive.src,
                              artboard: bottomNavs[index].rive.artboard,
                              onInit: (artboard) {
                                StateMachineController controller =
                                    RiveUtils.getRiveController(artboard,
                                        bottomNavs[index].rive.stateMachineName);
                                bottomNavs[index].rive.status =
                                    controller.findSMI("active") as SMIBool;
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
