import 'dart:async';
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:accelerometer_app/api_connection/api_connection.dart';
import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:http/http.dart' as http;

class ClassifyPage extends StatefulWidget {
  const ClassifyPage({super.key, required this.title});

  final String title;

  @override
  State<ClassifyPage> createState() => _ClassifyPageState();
}

class _ClassifyPageState extends State<ClassifyPage> {
  bool button_state = false;
  String signalString = "";
  // String signalStringgyro = "";

  String classificationString = "";
  String probability = "";


  List<StreamSubscription<UserAccelerometerEvent>> _streamSubscriptions =
  <StreamSubscription<UserAccelerometerEvent>>[];
  // List<StreamSubscription<GyroscopeEvent>> _streamSubscriptionsgyro =
  // <StreamSubscription<GyroscopeEvent>>[];

  Future<void> sendDataToServer() async{
    try{
      var response  = await http.post(
        Uri.parse(API.hostConnectClassify),
          headers: {"Content-Type": "application/json"},
        body: jsonEncode(
            {
              "input_string" : signalString.toString(),
              // "gyro_string" : signalStringgyro.toString()
            }
        )
      );
       print(response.body);

       if(response.statusCode == 200){
         var decodedResBody = jsonDecode(response.body);
         if(decodedResBody["success"] == true){
            Fluttertoast.showToast(msg: "Successfully classified");
            setState(() {
              classificationString = decodedResBody["template_name"].toString();
              probability = decodedResBody["probability"].toString();

            });
         }else{
           Fluttertoast.showToast(msg: "error while classifying");
         }

       }


    } catch(e){
      print(e.toString());
    }

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
                 onTap: () async{
                   setState(() {
                     button_state = !button_state;
                   });
                   if(button_state == true){
                     _streamSubscriptions.add(
                         userAccelerometerEvents.listen(
                               (UserAccelerometerEvent event) {
                             setState(() {
                               signalString = signalString + "|" + (event.x.toString() + "~" + event.y.toString() +  "~" + event.z.toString());

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



                     // _streamSubscriptionsgyro.add(
                     //     gyroscopeEvents.listen(
                     //           (GyroscopeEvent event) {
                     //         setState(() {
                     //           signalStringgyro = signalStringgyro + "|" + (event.x.toString() + "~" + event.y.toString() + "~" + event.z.toString());
                     //
                     //         });
                     //         print(event);
                     //       },
                     //       onError: (error) {
                     //         // Logic to handle error
                     //         // Needed for Android in case sensor is not available
                     //       },
                     //       cancelOnError: true,
                     //     )
                     //
                     // );

                   }else{

                     for (StreamSubscription<UserAccelerometerEvent> subscription in _streamSubscriptions) {
                       subscription.cancel();
                     }

                     // for (StreamSubscription<GyroscopeEvent> subscriptiongyro in _streamSubscriptionsgyro) {
                     //   subscriptiongyro.cancel();
                     // }
                     print(signalString);
                     // print(signalStringgyro);


                     await sendDataToServer();

                     // sendDataToServer();
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
           ),


            SizedBox(height: 100,),
            Text(classificationString != ""? "Template: "  + classificationString : ""),
            Text(probability != ""? "Probability: "  + probability : "")

          ],
        ),
      ),
    );
  }
}
