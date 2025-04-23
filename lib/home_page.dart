import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'stations_page.dart';

class homePage extends StatefulWidget {
  homePage({super.key});

  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  final nameCont = TextEditingController();

  var enabled = false.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        title:
        Text('Welcome to Cairo Metro App Calculator',style: TextStyle(fontSize: 15.0),),
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text('Please enter your name',
              style:
              TextStyle(fontSize: 18),),
            TextField(
              onChanged: (a) {
                enabled.value = a.isNotEmpty;
              },
              controller: nameCont,
            ),
            SizedBox(
              height: 12,
            ),
            Obx(() {
              return ElevatedButton(
                  onPressed: enabled.value
                      ? () {
                    Get.to(stationsPage(),
                        transition: Transition.leftToRightWithFade,
                        arguments: {'name': nameCont.text});
                  }
                      : null,
                  child: Text('Submit Name'));
            })
          ],
        ),
      ),
    );
  }
  @override
  void dispose() {
    nameCont.dispose();
    super.dispose();
  }
}