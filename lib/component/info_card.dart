
import 'package:flutter/material.dart';

class InfoCard extends StatelessWidget {

  InfoCard({required this.name,required this.profession});
  final String name,profession;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.white24,
        child: Icon(
          Icons.person,
          color: Colors.white,
        ),
      ),
      title: Text(name,
        style: TextStyle(color: Colors.white),
      ),
      subtitle: Text(profession,style: TextStyle(color: Colors.white),),

    );
  }
}
