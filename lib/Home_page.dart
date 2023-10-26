import 'package:accelerometer_app/add_template.dart';
import 'package:accelerometer_app/classify_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Page"),
      ),
      body: Row(

        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Material(
              color: Colors.blue,
              child: Container(
                width: 139,
                height: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),

                ),
                child: InkWell(
                  borderRadius: BorderRadius.circular(30),
                  onTap: (){
                   Navigator.of(context).push(MaterialPageRoute(builder: (context) => ClassifyPage(title: "Classify Page"),));
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(17.0),
                    child: Center(
                      child: Text("Classify",
                        style: TextStyle(color: Colors.black, fontSize: 16),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(width: 80,),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Material(
              color: Colors.yellow,
              child: Container(
                height: 100,
                width: 139,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),

                ),
                child: InkWell(
                  borderRadius: BorderRadius.circular(30),
                  onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddTemplate(),));

                  },
                  child: Padding(
                    padding: const EdgeInsets.all(17.0),
                    child: Center(
                      child: Text( "Add Template",
                        style: TextStyle(color: Colors.black, fontSize: 16),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          )
        ],

      )
    );
  }
}
