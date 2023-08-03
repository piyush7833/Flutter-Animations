import 'dart:async';

import 'package:animations/hero.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MyHomePage(title:"Animations"),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with TickerProviderStateMixin {  //for using tween animations
  double _width=200;
  double _height=200;
  BoxShape _shape=BoxShape.rectangle;

  double _opacity=1;

  bool isFirst=true;

  late Animation animation;
  late AnimationController animationController;
  late Animation animationColor;
  late Animation animationRipple;
  late AnimationController animationControllerRipple;
  var listRadius=[150.0,200.0,250.0,300.0,350.0];
  @override
  void initState(){  //init state ke andr kbhi v set state ko mt call kro kyuki init state state bnne se pehle hi call ho jata h
    super.initState();

    //ripple effect
    animationControllerRipple=AnimationController(vsync: this,duration: Duration(seconds: 4));
    animationRipple=Tween(begin: 0.0,end: 1.0).animate(animationControllerRipple);
    animationControllerRipple.addListener(() {
      setState(() {

      });
    });
    animationControllerRipple.forward();


    // tween animation
    animationController=AnimationController(vsync: this,duration: Duration(seconds: 5)); //this provides singleTickerProviderStateMixin reference  //use ticker provider if you want to make two animation controller
    animation=Tween(begin:0.0,end:200.0).animate(animationController);
    animationColor=ColorTween(begin: Colors.blue,end: Colors.pink).animate(animationController);
    animationController.addListener(() {
      setState(() {

      });
    });
    animationController.forward();



    //cross fade animation
    Timer.periodic(Duration(seconds: 6), (timer) {
      reload();
    });

  }
  void reload(){
    isFirst=!isFirst;
    setState(() {

    });
  }
  Widget myContainer(radius){
    return Container(
      width: radius * animationRipple.value,
      height: radius * animationRipple.value,
      decoration:BoxDecoration (
        shape: BoxShape.circle,
        color: Colors.blue.withOpacity(1.0-animationRipple.value),
      ),
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
       child: SingleChildScrollView(
         scrollDirection: Axis.vertical,
         child: Column(
           children: [
             Text('Animations',style: TextStyle(fontSize: 55,color: Colors.red),),
             Text('Default animations Provided by flutter (FOO)',style: TextStyle(fontSize: 18),),

             //ripple effect //using tween animation
             Stack(
               alignment: Alignment.center,
               children: [
                    myContainer(listRadius[0]),
                    myContainer(listRadius[1]),
                    myContainer(listRadius[2]),
                    myContainer(listRadius[3]),
                    myContainer(listRadius[4]),
                    Icon(Icons.add_call,size: 45,color: Colors.white,),
               ],
             ),


             //using list
             // Stack(
             //   alignment: Alignment.center,
             //   children: listRadius.map((radius) =>
             //   Container(
             //     width: radius * animationRipple.value,
             //     height: radius * animationRipple.value,
             //     decoration:BoxDecoration (
             //     shape: BoxShape.circle,
             //       color: Colors.blue.withOpacity(1.0-animationRipple.value),
             //     ),
             //   )
             //   ).toList()
             // ),


             Text("Ripple Effect"),




             //twwen animations //between animation //start-end //requirement :-tween animation ,controller,single take provider mixing class
             Container(
               width: animation.value,
               height: animation.value,
               color: animationColor.value,
             ),
             Text("Tween Animation (Between Animation)"),



             InkWell(
                 onTap: (){
                   Navigator.push(context, MaterialPageRoute(builder: (context)=>hero()));
                 },
                 child: Hero(
                     tag: "Hero",
                     child: Image.network("https://womensfitness.co.uk/wp-content/uploads/sites/3/2022/11/Shutterstock_1675475479.jpg?w=900",width: 100,height: 100,))),
             Text("Hero Animations"),


             AnimatedCrossFade(
               firstChild: Container(
                 height: 200,
                 width: 200,
                 color: Colors.orange,
               ),
               secondChild: Container(
                 height: 200,
                 width: 200,
                 color: Colors.blue,
                 child: Image.network("https://womensfitness.co.uk/wp-content/uploads/sites/3/2022/11/Shutterstock_1675475479.jpg?w=900",width: 150,height: 150,),
               ),
               crossFadeState: isFirst ?CrossFadeState.showFirst:CrossFadeState.showSecond,
               duration: Duration(seconds: 2),
               firstCurve: Curves.bounceInOut,
               secondCurve: Curves.slowMiddle,

             ),
             Text("Animated crossfade"),
             ElevatedButton(onPressed: (){
               setState(() {
                 isFirst=!isFirst;
               });
             }, child: Text("Animate")),



             AnimatedOpacity(opacity: _opacity, duration: Duration(seconds: 2),curve: Curves.bounceInOut,
               child: Container(
                 width: 200,
                 height: 200,
                 color: Colors.red,
               ),
             ),
             Text("Animated Opacity"),
             ElevatedButton(onPressed: (){
               if(_opacity==1)_opacity=0;
               else  _opacity=1;
               setState(() {

               });
             }, child: Text("Animate")),




             AnimatedContainer(duration: Duration(seconds: 2),  //it is used for creating animations in case of screen size change or container size change
               width: _width,
               height: _height,
               curve: Curves.bounceOut,  //controls speed of animation

               decoration: BoxDecoration(
                   color: Colors.green,
                 // borderRadius: BorderRadius.all(Radius.circular(11.0)),
                 shape: _shape,
               ),
             ),
             Text("Animated container"),
             ElevatedButton(onPressed: (){
               if(_width==200){
                 _height=300;
                 _width=300;
                 _shape=BoxShape.circle;
               }
               else{
                 _height=200;
                 _width=200;
                 _shape=BoxShape.rectangle;
               }
                setState(() {

                });
             }, child: Text("Animate")),

           ],
         ),
       ),
      ),
    );
  }
}


