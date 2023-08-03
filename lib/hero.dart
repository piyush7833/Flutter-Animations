import 'package:animations/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class hero extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
       title: Text("Hero"),
        backgroundColor: Colors.deepPurple.shade200,
      ),
      body:Center(
        child: InkWell(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>MyHomePage(title: "Animations")));
          },
          child: Hero(
            child: Image.network("https://womensfitness.co.uk/wp-content/uploads/sites/3/2022/11/Shutterstock_1675475479.jpg?w=900",),
            tag: "Hero",
          ),
        ),
      ) ,
    );
  }

}