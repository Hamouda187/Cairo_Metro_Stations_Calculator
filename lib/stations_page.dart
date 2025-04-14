import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:metro_app/details_page.dart';

class stationsPage extends StatelessWidget {
  stationsPage({super.key});


  final startCont = TextEditingController();
  final endCont = TextEditingController();
  final stations = [
    'New El-Marg',
    'El-Marg',
    'Ezbet El-Nakhl',
    'Ain Shams',
    'El-Matareyya',
    'Helmeyet El-Zaitoun',
    'Hadayeq El-Zaitoun',
    'Saray El-Qobba',
    'Hammamat El-Qobba',
    'Kobri El-Qobba',
    'Manshiet El-Sadr',
    'El-Demerdash',
    'Ghamra',
    'Al-Shohadaa',
    'Orabi',
    'Nasser',
    'Sadat',
    'Saad Zaghloul',
    'Sayyeda Zeinab',
    'El-Malek El-Saleh',
    'Mar Girgis',
    'El-Zahraa',
    'Dar El-Salam',
    'Hadayeq El-Maadi',
    'Maadi',
    'Sakanat El-Maadi',
    'Tora El-Balad',
    'Kozzika',
    'Tora El-Asmant',
    'El-Maasara',
    'Hadayeq Helwan',
    'Wadi Hof',
    'Helwan University',
    'Ain Helwan',
    'Helwan'
    ,
    'Shubra El-Kheima',
    'Kolleyet El-Zeraa',
    'El-Massara',
    'Road El-Farag',
    'St. Teresa',
    'Khalafawy',
    'Mezallat',
    'Sakia Mekki',
    'Al-Shohadaa',
    'Ataba',
    'Mohamed Naguib',
    'Sadat',
    'Opera',
    'Dokki',
    'El Behoos',
    'Cairo University',
    'Faisal',
    'Giza',
    'Omm El-Misryeen',
    'Sakiat Mekki',
    'El-Monib'
    ,
    "Adly Mansour",
    "El Haykestep",
    "Omar Ibn El Khattab",
    "Qobaa",
    "Hesham Barakat",
    "El Nozha",
    "Nadi El Shams",
    "Alf Maskan",
    "Heliopolis",
    "Haroun",
    "Al Ahram",
    "Koleyet El Banat",
    "Cairo Stadium",
    "Fair Zone",
    "Abbassiya",
    "Abdou Pasha",
    "El Geish",
    "Bab El Shaaria",
    "Ataba",
    "Nasser",
    "Maspero",
    "Safaa Hegazy",
    "KitKat"
    ,
    "Tawfikia",
    "Wadi El Nile",
    'Gamet El Dowal',
    "Bulaq El Dakrour",
    "Cairo University",
    "Sudan",
    "Imbaba",
    "El Bohy",
    'El-Qawmia',
    "Ring Road",
    "Rod El Farag Corridor"
  ];
  var openButton = false.obs;

  @override
  Widget build(BuildContext context) {
    final name = Get.arguments as Map;
    var stationSet = stations.toSet();
    startCont.addListener((){
      openButton.value=startCont.text.isNotEmpty&&endCont.text.isNotEmpty;
    });
    endCont.addListener((){
      openButton.value=startCont.text.isNotEmpty&&endCont.text.isNotEmpty;
    });
    return Scaffold(
      appBar: AppBar(
          title: Text('Hi ${name['name']}, Let us help you',
              style: TextStyle(fontSize: 15.0)),
          backgroundColor: Colors.red,
          foregroundColor: Colors.white
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Text('Please select the start station',
              style: TextStyle(fontSize: 18),),
            DropdownMenu<String>(
                menuHeight: 500,
                width: double.infinity,
                hintText: 'please select start station',
                enableSearch: true,
                enableFilter: true,
                requestFocusOnTap: true,
                controller: startCont,
                dropdownMenuEntries: [
                  for (var station in stations)
                    DropdownMenuEntry(value: station, label: station)
                ],
                onSelected: (a) {
                  if(a!=null) {
                    openButton.value=startCont.text.isNotEmpty&&endCont.text.isNotEmpty;
                  }
                }),
            Text('Please select the end station',
                style: TextStyle(fontSize: 18)),
            DropdownMenu<String>(
                menuHeight: 500,
                width: double.infinity,
                hintText: 'please select end station',
                enableSearch: true,
                enableFilter: true,
                requestFocusOnTap: true,
                controller: endCont,
                dropdownMenuEntries: [
                  for (var station in stations)
                    DropdownMenuEntry(value: station, label: station),
                ],
                onSelected: (a) {
                  if(a!=null) {
                    openButton.value=startCont.text.isNotEmpty&&endCont.text.isNotEmpty;

                  }
                }
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: Obx(() {
                return ElevatedButton(
                    onPressed: openButton.value ? () {

                      if (startCont.text == endCont.text) {
                        Get.snackbar('Error', 'You are at the same station');
                        return;
                      }
                      if (!stationSet.contains(startCont.text) ||
                          !stationSet.contains(endCont.text)) {
                        Get.snackbar('Error', 'Please enter a valid station');
                        return;
                      }

                      Get.to(detailsPage(),
                          transition: Transition.leftToRightWithFade,
                          arguments: {'start': startCont.text, 'end': endCont
                              .text, 'name': name['name']});
                    } : null,
                    child: Text('Calculate the route'));
              }),
            ),
          ],
        ),
      ),
    );
  }

}