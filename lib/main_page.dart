import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool button_state = false;
  String signalString = "";
  List<StreamSubscription<UserAccelerometerEvent>> _streamSubscriptions =
  <StreamSubscription<UserAccelerometerEvent>>[];

  sendDataToServer(){

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
           Material(
             color: button_state == false ?  Colors.green : Colors.red,
             child: Container(
               width: 139,
               decoration: BoxDecoration(
                 borderRadius: BorderRadius.circular(30),

               ),
               child: InkWell(
                 borderRadius: BorderRadius.circular(30),
                 onTap: (){
                   setState(() {
                     button_state = !button_state;
                   });
                   if(button_state == true){
                     _streamSubscriptions.add(
                         userAccelerometerEvents.listen(
                               (UserAccelerometerEvent event) {
                             setState(() {
                               signalString = signalString + "|" + (event.x.toString() + "~" + event.y.toString());

                             });
                             print(event);
                           },
                           onError: (error) {
                             // Logic to handle error
                             // Needed for Android in case sensor is not available
                           },
                           cancelOnError: true,
                         )

                     );

                   }else{

                     for (StreamSubscription<UserAccelerometerEvent> subscription in _streamSubscriptions) {
                       subscription.cancel();
                     }
                     sendDataToServer();
                     print(signalString);
                   }
                 },
                 child: Padding(
                   padding: const EdgeInsets.all(17.0),
                   child: Center(
                     child: Text(button_state == false ? "Start" : "Stop",
                     style: TextStyle(color: Colors.white, fontSize: 16),
                     ),
                   ),
                 ),
               ),
             ),
           )
          ],
        ),
      ),
    );
  }
}
