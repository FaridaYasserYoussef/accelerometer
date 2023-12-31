import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:http/http.dart' as http;
import 'api_connection/api_connection.dart';
import 'location.dart';

class AddTemplate extends StatefulWidget {
  const AddTemplate({Key? key}) : super(key: key);

  @override
  State<AddTemplate> createState() => _AddTemplateState();
}

class _AddTemplateState extends State<AddTemplate> {
  TextEditingController nameController =  TextEditingController();
  bool button_state = false;
  String signalString = "";
  String signalStringgyro = "";
  String signalStringmagneto = "";

  Location location = Location();
  List<StreamSubscription<UserAccelerometerEvent>> _streamSubscriptions =
  <StreamSubscription<UserAccelerometerEvent>>[];

  List<StreamSubscription<GyroscopeEvent>> _streamSubscriptionsgyro =
  <StreamSubscription<GyroscopeEvent>>[];


  List<StreamSubscription<MagnetometerEvent>> _streamSubscriptionsmagneto =
  <StreamSubscription<MagnetometerEvent>>[];

  Future<void> sendDataToServer() async{
    await location.getCurrentLocation();
    try{
      print(API.addTemplateFunc);
      var response  = await http.post(
          Uri.parse(API.hostConnectAddTemplate),
          headers: {"Content-Type": "application/json"},

          body: jsonEncode({
            "input_string" : signalString.toString(),

            "templateName" : nameController.text.toString(),
            "longi" : location.longitude.toString(),
            "lati" : location.latitude.toString()

          })
      );
      print(response.body);

      if(response.statusCode == 200){
        var decodedResBody = jsonDecode(response.body);
        if(decodedResBody["success"] == true){
          Fluttertoast.showToast(msg: decodedResBody["message"]);
          setState(() {
          });
        }else{
          Fluttertoast.showToast(msg: "error while adding template");
        }

      }


    } catch(e){
      print(e.toString());
    }


    try{
      print(API.addGyroData);
      var responseGyro  = await http.post(
          Uri.parse(API.hostConnectAddGyroData),
          headers: {"Content-Type": "application/json"},

          body: jsonEncode({
            "gyro_string" : signalStringgyro.toString(),
            "templateName" : nameController.text.toString(),
            "longi" : location.longitude.toString(),
            "lati" : location.latitude.toString()
          })
      );
      print(responseGyro.body);

      if(responseGyro.statusCode == 200){
        var decodedResBodyGyro = jsonDecode(responseGyro.body);
        if(decodedResBodyGyro["success"] == true){
          Fluttertoast.showToast(msg: decodedResBodyGyro["message"]);
          setState(() {
          });
        }else{
          Fluttertoast.showToast(msg: "error while adding gyro data");
        }

      }


    } catch(e){
      print(e.toString());
    }


    try{
      print(API.addMagnetoData);
      var responseMagneto  = await http.post(
          Uri.parse(API.hostConnectAddMagnetoData),
          headers: {"Content-Type": "application/json"},

          body: jsonEncode({
            "magnet_string" : signalStringmagneto.toString(),
            "templateName" : nameController.text.toString(),
            "longi" : location.longitude.toString(),
            "lati" : location.latitude.toString()
          })
      );
      print(responseMagneto.body);

      if(responseMagneto.statusCode == 200){
        var decodedResBodyMagneto = jsonDecode(responseMagneto.body);
        if(decodedResBodyMagneto["success"] == true){
          Fluttertoast.showToast(msg: decodedResBodyMagneto["message"]);
          setState(() {
          });
        }else{
          Fluttertoast.showToast(msg: "error while adding magneto data");
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
        title: Text("Add Template"),

      ),
      body: Column(
        children: [
          TextField(
            controller:  nameController,
            decoration: InputDecoration(
              hintText: "Write Template Name"
            ),
          ),
          SizedBox(height: 50,),
          Material(
            color: button_state == false ?  Colors.green : Colors.red,
            child: Container(
              width:button_state == false ? 139 : 300 ,
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
                              signalString = signalString + "|" + (event.x.toString() + "~" + event.y.toString() + "~" + event.z.toString());

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


                    _streamSubscriptionsgyro.add(
                        gyroscopeEvents.listen(
                              (GyroscopeEvent event) {
                            setState(() {
                              signalStringgyro = signalStringgyro + "|" + (event.x.toString() + "~" + event.y.toString() + "~" + event.z.toString());

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


                    _streamSubscriptionsmagneto.add(
                        magnetometerEvents.listen(
                              (MagnetometerEvent event) {
                            setState(() {
                              signalStringmagneto = signalStringmagneto + "|" + (event.x.toString() + "~" + event.y.toString() + "~" + event.z.toString());

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

                    for (StreamSubscription<GyroscopeEvent> subscriptiongyro in _streamSubscriptionsgyro) {
                      subscriptiongyro.cancel();
                    }

                    for (StreamSubscription<MagnetometerEvent> subscriptionmagneto in _streamSubscriptionsmagneto) {
                      subscriptionmagneto.cancel();
                    }

                    print(signalString);
                    print(signalStringgyro);
                    print(signalStringmagneto);


                    await sendDataToServer();
                    print(signalString);
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.all(17.0),
                  child: Center(
                    child: Text(button_state == false ? "Start" : "Stop and submit",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ),
              ),
            ),
          )

        ],
      ),
    );
  }
}
