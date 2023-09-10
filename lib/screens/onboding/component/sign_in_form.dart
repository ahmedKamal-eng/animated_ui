import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rive/rive.dart';

import '../../../entry_point.dart';

import 'package:animated_ui/utils/rive_utils.dart';

class SignInForm extends StatefulWidget {
  const SignInForm({
    Key? key,
  }) : super(key: key);

  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  GlobalKey<FormState> _formKey = GlobalKey();

  bool isShowLoading = false;
  bool isShowConfetti=false;


  late SMITrigger check;
  late SMITrigger error;
  late SMITrigger reset;

  late SMITrigger confetti;



  void signIn(BuildContext context){
    setState(() {
      isShowLoading=true;
      isShowConfetti=true;
    });
    Future.delayed(Duration(seconds: 1), () {
      if (_formKey.currentState!.validate()) {
        check.fire();
        Future.delayed(Duration(seconds: 2), () {
          isShowLoading = false;


          confetti.fire();

          setState(() {});

          Future.delayed(Duration(seconds: 1),(){
            Navigator.push(context, MaterialPageRoute(builder: (context){
              return EntryPoint();
            }));
          });
        });
      } else {
        error.fire();
        Future.delayed(Duration(seconds: 2), () {
          isShowLoading = false;
          setState(() {});
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Email",
                  style: TextStyle(
                    color: Colors.black54,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "";
                      } else {
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                      prefixIcon: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: SvgPicture.asset("assets/icons/email.svg"),
                      ),
                    ),
                  ),
                ),
                const Text(
                  "Password",
                  style: TextStyle(
                    color: Colors.black54,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                   obscureText: true,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "";
                      } else {
                        return null;
                      }
                    },
                    decoration: InputDecoration(

                      prefixIcon: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: SvgPicture.asset("assets/icons/password.svg"),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 0, bottom: 10),
                  child: ElevatedButton.icon(
                    onPressed: () {
                        signIn(context);
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFF77D8E),
                        minimumSize: const Size(double.infinity, 56),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(25),
                            bottomRight: Radius.circular(25),
                            bottomLeft: Radius.circular(25),
                          ),
                        )),
                    icon: const Icon(
                      CupertinoIcons.arrow_right,
                      color: Color(0xFFFE0037),
                    ),
                    label: const Text("Sign In"),
                  ),
                ),
              ],
            ),
          ),
        ),
        isShowLoading
            ? CustomPositioned(
                child: RiveAnimation.asset(
                  "assets/RiveAssets/check.riv",
                  onInit: (artboard) {
                    StateMachineController controller =
                        RiveUtils.getRiveController(artboard,"State Machine 1");
                    check = controller.findSMI("Check") as SMITrigger;
                    error = controller.findSMI("Error") as SMITrigger;
                    reset = controller.findSMI("Reset") as SMITrigger;
                  },
                ),
              )
            : SizedBox(),
        isShowConfetti ?
        CustomPositioned(child: Transform.scale(
          scale: 8,
          child: RiveAnimation.asset("assets/RiveAssets/confetti.riv",

            onInit: (artboard){
              StateMachineController controller=RiveUtils.getRiveController(artboard,"State Machine 1");

              confetti =controller.findSMI("Trigger explosion") as SMITrigger;

            },

          ),
        ),):SizedBox()
        ,

      ],
    );
  }
}

class CustomPositioned extends StatelessWidget {
  CustomPositioned({required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Column(
        children: [
          Spacer(),
          SizedBox(
            height: 100,
            width: 100,
            child: child,
          ),
          Spacer(
            flex: 2,
          ),
        ],
      ),
    );
  }
}
