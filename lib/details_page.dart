import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:metro_app/functions.dart';

class detailsPage extends StatelessWidget {
  detailsPage({super.key});


  var startStation = ''.obs;
  var endStation = ''.obs;
  var price = 0.obs;
  var direction1 = ''.obs;
  var direction2 = ''.obs;
  var route = ''.obs;
  var stationNum = 0.obs;
  var time = 0.0.obs;
  var exchangeStation = ''.obs;
  var exchangeState = false.obs;
  var exchangeState2=false.obs;

  @override
  Widget build(BuildContext context) {
    final details = Get.arguments as Map;
    startStation.value = details['start'];
    endStation.value = details['end'];
    Functions f=Functions(price.value, direction1.value, direction2.value, route.value, stationNum.value, time.value, exchangeState2.value, startStation.value , endStation.value, exchangeStation.value);
    void values()
    {
      if (f.line1.contains(startStation.value) && f.line1.contains(
          endStation.value)) ////////////////////////////////////////ALL LINE 1
          {
        price.value = f.calculations(
            f.line1.indexOf(startStation.value), f.line1.indexOf(endStation.value));
        route.value = f.routePrint(
            f.line1.indexOf(endStation.value), f.line1.indexOf(startStation.value),
            f.line1);
        direction1.value = f.directionChange(start: startStation.value, end: endStation.value, metroLine: f.line1);
        stationNum.value = f.routeLength(
            f.line1.indexOf(endStation.value), f.line1.indexOf(startStation.value),
            f.line1);
        time.value = f.routeLength(
            f.line1.indexOf(endStation.value), f.line1.indexOf(startStation.value),
            f.line1) * 2.0;
      }
      else if (f.line2.contains(startStation.value) && f.line2.contains(
          endStation.value)) ////////////////////////////////////////ALL LINE 2
          {
        price.value = f.calculations(
            f.line2.indexOf(startStation.value), f.line2.indexOf(endStation.value));
        route.value = f.routePrint(
            f.line2.indexOf(endStation.value), f.line2.indexOf(startStation.value),
            f.line2);
        direction1.value = f.directionChange(start: startStation.value, end: endStation.value, metroLine: f.line2);
        stationNum.value = f.routeLength(
            f.line2.indexOf(endStation.value), f.line2.indexOf(startStation.value),
            f.line2);
        time.value = f.routeLength(
            f.line2.indexOf(endStation.value), f.line2.indexOf(startStation.value),
            f.line2) * 2.0;
          } else if ((f.line3.contains(startStation.value) && f.line3.contains(
          endStation
              .value)) || ///////////////////////////////////////////////////////////////ALL LINE 3 CAIRO UNIVERSITY
          ((f.line3.contains(startStation.value) ||
              f.line3.contains(endStation.value)) &&
              (f.line3Pt2.contains(startStation.value) ||
                  f.line3Pt2.contains(endStation.value)))
          || ((f.line3Pt2.contains(startStation.value) &&
              f.line3Pt2.contains(endStation.value)))) {
        f.line3.addAll(f.line3Pt2);
        price.value = f.calculations(
            f.line3.indexOf(startStation.value), f.line3.indexOf(endStation.value));
        route.value = f.routePrint(
            f.line3.indexOf(endStation.value), f.line3.indexOf(startStation.value),
            f.line3);
        direction1.value = f.directionChange(start: startStation.value, end: endStation.value, metroLine: f.line3);
        stationNum.value = f.routeLength(
            f.line3.indexOf(endStation.value), f.line3.indexOf(startStation.value),
            f.line3);
        time.value = f.routeLength(
            f.line3.indexOf(endStation.value), f.line3.indexOf(startStation.value),
            f.line3) * 2.0;
      } else if (((f.line3.contains(startStation.value) ||
          f.line3.contains(endStation.value)) &&
          (f.line3Pt3.contains(startStation.value) || f.line3Pt3.contains(
              endStation.value))) ////////ALL LINE 3 ROD EL FARAG
          || ((f.line3Pt3.contains(startStation.value) &&
              f.line3Pt3.contains(endStation.value)))) {
        f.line3.addAll(f.line3Pt3);
        price.value = f.calculations(
            f.line3.indexOf(startStation.value), f.line3.indexOf(endStation.value));
        route.value = f.routePrint(
            f.line3.indexOf(endStation.value), f.line3.indexOf(startStation.value),
            f.line3);
        direction1.value = f.directionChange(start: startStation.value, end: endStation.value, metroLine: f.line3);
        stationNum.value = f.routeLength(
            f.line3.indexOf(endStation.value), f.line3.indexOf(startStation.value),
            f.line3);
        time.value = f.routeLength(
            f.line3.indexOf(endStation.value), f.line3.indexOf(startStation.value),
            f.line3) * 2.0;
       }
        else if (f.line3Pt2.contains(startStation.value) && f.line3Pt3.contains(
          endStation.value)) ////////////////////////////////ALL LINE 3 U SHAPE
          {
        f.line3Pt2 = f.line3Pt2.reversed.toList();
        f.line3Pt2.addAll(f.line3Pt3);
        price.value = f.calculations(
            f. line3Pt2.indexOf(startStation.value),
            f. line3Pt2.indexOf(endStation.value));
        route.value = f.routePrint(
            f.line3Pt2.indexOf(endStation.value),
            f.line3Pt2.indexOf(startStation.value),
            f.line3Pt2);
        direction1.value = f.directionChange(start: startStation.value, end: endStation.value, metroLine: f.line3Pt2);
        stationNum.value = f.routeLength(
            f.line3Pt2.indexOf(endStation.value),
            f.line3Pt2.indexOf(startStation.value),
            f.line3Pt2);
        time.value = f.routeLength(
            f.line3Pt2.indexOf(endStation.value),
            f.line3Pt2.indexOf(startStation.value),
            f.line3Pt2) * 2.0;
        exchangeStation.value=f.line3Pt3[0];
        exchangeState.value=true;
      } else if (f.line3Pt3.contains(startStation.value) && f.line3Pt2.contains(
          endStation
              .value)) //////////////////////////////////ALL LINE 3 U SHAPE 2
          {
        f.line3Pt3 = f.line3Pt3.reversed.toList();
        f.line3Pt3.addAll(f.line3Pt2);
        price.value = f.calculations(
            f.line3Pt3.indexOf(startStation.value),
            f.line3Pt3.indexOf(endStation.value));
        route.value = f.routePrint(
            f.line3Pt3.indexOf(endStation.value),
            f.line3Pt3.indexOf(startStation.value),
            f.line3Pt3);
        direction1.value = f.directionChange(start: startStation.value, end: endStation.value, metroLine:f. line3Pt3);
        stationNum.value = f.routeLength(
            f.line3Pt3.indexOf(endStation.value),
            f.line3Pt3.indexOf(startStation.value),
            f.line3Pt3);
        time.value = f.routeLength(
            f.line3Pt3.indexOf(endStation.value),
            f.line3Pt3.indexOf(startStation.value),
            f.line3Pt3) * 2.0;
        exchangeStation.value=f.line3Pt2[0];
        exchangeState.value=true;
      }
      else if(f.line1.contains(startStation.value) && f.line2.contains(endStation.value))///////////////////////////////////////FROM 1 TO 2
          {

        route.value =f. routeExchange(metroLine1: f.line1, metroLine2: f.line2, exchangeList:f. exchangeStations, start: startStation.value, end: endStation.value);
        stationNum.value =f. routeExchangeLength(metroLine1:f. line1, metroLine2:f. line2, exchangeList:f. exchangeStations, start: startStation.value, end: endStation.value);
        time.value = f.routeExchangeLength(metroLine1: f.line1, metroLine2: f.line2, exchangeList:f. exchangeStations, start: startStation.value, end: endStation.value)*2.0;
        exchangeStation.value=f.nearestStation(metroLine1:f. line1, metroLine2:f. line2, exchangeList: f.exchangeStations, start: startStation.value, end: endStation.value);
        direction1.value =f. directionChange(start: startStation.value, end: exchangeStation.value, metroLine:f. line1);
        direction2.value =f. directionChange(start: exchangeStation.value, end: endStation.value, metroLine:f. line2);
        price.value = f.priceChange(routeLength: stationNum.value);
        exchangeState.value=true;
        exchangeState2.value=true;
      }else if(f.line2.contains(startStation.value) &&f. line1.contains(endStation.value))////////////////////////////////////FROM 2 TO 1
          {
        route.value = f.routeExchange(metroLine1: f.line2, metroLine2:f. line1, exchangeList:f. exchangeStations, start: startStation.value, end: endStation.value);
        stationNum.value =f. routeExchangeLength(metroLine1: f.line2, metroLine2:f. line1, exchangeList:f. exchangeStations, start: startStation.value, end: endStation.value);
        time.value = f.routeExchangeLength(metroLine1:f. line2, metroLine2: f.line1, exchangeList:f. exchangeStations, start: startStation.value, end: endStation.value)*2.0;
        exchangeStation.value=f.nearestStation(metroLine1:f. line2, metroLine2:f. line1, exchangeList:f. exchangeStations, start: startStation.value, end: endStation.value);
        direction1.value =f. directionChange(start: startStation.value, end: exchangeStation.value, metroLine: f.line2);
        direction2.value =f. directionChange(start: exchangeStation.value, end: endStation.value, metroLine:f. line1);
        price.value = f.priceChange(routeLength: stationNum.value);
        exchangeState.value=true;
        exchangeState2.value=true;
      }else if(f.line1.contains(startStation.value)&&(f.line3.contains(endStation.value)  || f.line3Pt2.contains(endStation.value)))//////////FROM 1 TO 3 CAIRO UNIVERSITY
          {
        f.line3.addAll(f.line3Pt2);
        route.value = f.routeExchange(metroLine1:f. line1, metroLine2:f. line3, exchangeList:f. exchangeStations, start: startStation.value, end: endStation.value);
        stationNum.value =f. routeExchangeLength(metroLine1: f.line1, metroLine2:f. line3, exchangeList: f.exchangeStations, start: startStation.value, end: endStation.value);
        time.value = f.routeExchangeLength(metroLine1:f. line1, metroLine2:f. line3, exchangeList:f. exchangeStations, start: startStation.value, end: endStation.value)*2.0;
        exchangeStation.value=f.nearestStation(metroLine1:f. line1, metroLine2:f. line3, exchangeList:f. exchangeStations, start: startStation.value, end: endStation.value);
        direction1.value = f.directionChange(start: startStation.value, end: exchangeStation.value, metroLine:f. line1);
        direction2.value = f.directionChange(start: exchangeStation.value, end: endStation.value, metroLine:f. line3);
        price.value =f. priceChange(routeLength: stationNum.value);
        exchangeState.value=true;
        exchangeState2.value=true;
      }
      else if(f.line1.contains(startStation.value)&&(f.line3.contains(endStation.value)  || f.line3Pt3.contains(endStation.value)))//////////FROM 1 TO 3 ROD EL FARAG
          {
        f.line3.addAll(f.line3Pt3);
        route.value = f.routeExchange(metroLine1:f. line1, metroLine2:f. line3, exchangeList:f. exchangeStations, start: startStation.value, end: endStation.value);
        stationNum.value =f. routeExchangeLength(metroLine1:f. line1, metroLine2: f.line3, exchangeList: f.exchangeStations, start: startStation.value, end: endStation.value);
        time.value =f. routeExchangeLength(metroLine1:f. line1, metroLine2:f. line3, exchangeList: f.exchangeStations, start: startStation.value, end: endStation.value)*2.0;
        exchangeStation.value=f.nearestStation(metroLine1: f.line1, metroLine2:f. line3, exchangeList:f. exchangeStations, start: startStation.value, end: endStation.value);
        direction1.value = f.directionChange(start: startStation.value, end: exchangeStation.value, metroLine: f.line1);
        direction2.value = f.directionChange(start: exchangeStation.value, end: endStation.value, metroLine:f. line3);
        price.value = f.priceChange(routeLength: stationNum.value);
        exchangeState.value=true;
        exchangeState2.value=true;
      }else if(f.line2.contains(startStation.value)&&(f.line3.contains(endStation.value)  ||f. line3Pt2.contains(endStation.value)))//////////FROM 2 TO 3 CAIRO UNIVERSITY
          {
        f.line3.addAll(f.line3Pt2);
        route.value =f. routeExchange(metroLine1:f. line2, metroLine2:f. line3, exchangeList:f. exchangeStations, start: startStation.value, end: endStation.value);
        stationNum.value =f. routeExchangeLength(metroLine1:f. line2, metroLine2:f. line3, exchangeList:f. exchangeStations, start: startStation.value, end: endStation.value);
        time.value =f. routeExchangeLength(metroLine1:f. line2, metroLine2:f. line3, exchangeList:f. exchangeStations, start: startStation.value, end: endStation.value)*2.0;
        exchangeStation.value=f.nearestStation(metroLine1:f. line2, metroLine2:f. line3, exchangeList:f. exchangeStations, start: startStation.value, end: endStation.value);
        direction1.value =f. directionChange(start: startStation.value, end: exchangeStation.value, metroLine:f. line2);
        direction2.value =f. directionChange(start: exchangeStation.value, end: endStation.value, metroLine: f.line3);
        price.value =f. priceChange(routeLength: stationNum.value);
        exchangeState.value=true;
        exchangeState2.value=true;
      }
      else if(f.line2.contains(startStation.value)&&(f.line3.contains(endStation.value)  ||f. line3Pt3.contains(endStation.value)))//////////FROM 2 TO 3 ROD EL FARAG
          {
        f.line3.addAll(f.line3Pt3);

        route.value =f. routeExchange(metroLine1:f. line2, metroLine2:f. line3, exchangeList:f. exchangeStations, start: startStation.value, end: endStation.value);
        stationNum.value =f. routeExchangeLength(metroLine1:f. line2, metroLine2:f. line3, exchangeList:f. exchangeStations, start: startStation.value, end: endStation.value);
        time.value =f. routeExchangeLength(metroLine1: f.line2, metroLine2:f. line3, exchangeList:f. exchangeStations, start: startStation.value, end: endStation.value)*2.0;
        exchangeStation.value=f.nearestStation(metroLine1: f.line2, metroLine2: f.line3, exchangeList:f. exchangeStations, start: startStation.value, end: endStation.value);
        direction1.value = f.directionChange(start: startStation.value, end: exchangeStation.value, metroLine:f. line2);
        direction2.value = f.directionChange(start: exchangeStation.value, end: endStation.value, metroLine:f. line3);
        price.value =f. priceChange(routeLength: stationNum.value);
        exchangeState.value=true;
        exchangeState2.value=true;
      }else if((f.line3.contains(startStation.value) ||f. line3Pt2.contains(startStation.value))&&f.line1.contains(endStation.value))////////////////////////////////////////FROM 3 TO 1 CAIRO UNIVERSITY
          {
        f.line3.addAll(f.line3Pt2);


        route.value = f.routeExchange(metroLine1:f. line3, metroLine2:f. line1, exchangeList:f. exchangeStations, start: startStation.value, end: endStation.value);
        stationNum.value = f.routeExchangeLength(metroLine1:f. line3, metroLine2: f.line1, exchangeList:f. exchangeStations, start: startStation.value, end: endStation.value);
        time.value = f.routeExchangeLength(metroLine1:f. line3, metroLine2:f. line1, exchangeList:f. exchangeStations, start: startStation.value, end: endStation.value)*2.0;
        exchangeStation.value=f.nearestStation(metroLine1: f.line3, metroLine2: f.line1, exchangeList: f.exchangeStations, start: startStation.value, end: endStation.value);
        direction1.value = f.directionChange(start: startStation.value, end: exchangeStation.value, metroLine:f. line3);
        direction2.value = f.directionChange(start: exchangeStation.value, end: endStation.value, metroLine:f. line1);
        price.value =f. priceChange(routeLength: stationNum.value);
        exchangeState.value=true;
        exchangeState2.value=true;
      }
      else if((f.line3.contains(startStation.value) || f.line3Pt2.contains(startStation.value))&&f.line2.contains(endStation.value))////////////////////////////////////////FROM 3 TO 2 CAIRO UNIVERSITY
          {
        f.line3.addAll(f.line3Pt2);
        route.value =f. routeExchange(metroLine1:f. line3, metroLine2:f. line2, exchangeList:f. exchangeStations, start: startStation.value, end: endStation.value);
        stationNum.value = f.routeExchangeLength(metroLine1: f.line3, metroLine2: f.line2, exchangeList:f. exchangeStations, start: startStation.value, end: endStation.value);
        time.value = f.routeExchangeLength(metroLine1: f.line3, metroLine2: f.line2, exchangeList:f. exchangeStations, start: startStation.value, end: endStation.value)*2.0;
        exchangeStation.value=f.nearestStation(metroLine1:f. line3, metroLine2: f.line2, exchangeList: f.exchangeStations, start: startStation.value, end: endStation.value);
        direction1.value = f.directionChange(start: startStation.value, end: exchangeStation.value, metroLine:f. line3);
        direction2.value = f.directionChange(start: exchangeStation.value, end: endStation.value, metroLine:f. line2);
        price.value =f. priceChange(routeLength: stationNum.value);
        exchangeState.value=true;
        exchangeState2.value=true;
      }
      else if((f.line3.contains(startStation.value) ||f. line3Pt3.contains(startStation.value))&&f.line1.contains(endStation.value))////////////////////////////////////////FROM 3 TO 1 ROD EL FARAG
          {
        f.line3.addAll(f.line3Pt3);
        route.value =f. routeExchange(metroLine1:f. line3, metroLine2:f. line1, exchangeList:f. exchangeStations, start: startStation.value, end: endStation.value);
        stationNum.value =f. routeExchangeLength(metroLine1:f. line3, metroLine2:f. line1, exchangeList:f. exchangeStations, start: startStation.value, end: endStation.value);
        time.value = f.routeExchangeLength(metroLine1:f. line3, metroLine2:f. line1, exchangeList:f. exchangeStations, start: startStation.value, end: endStation.value)*2.0;
        exchangeStation.value=f.nearestStation(metroLine1: f.line3, metroLine2: f.line1, exchangeList: f.exchangeStations, start: startStation.value, end: endStation.value);
        direction1.value = f.directionChange(start: startStation.value, end: exchangeStation.value, metroLine:f. line3);
        direction2.value = f.directionChange(start: exchangeStation.value, end: endStation.value, metroLine:f. line1);
        price.value = f.priceChange(routeLength: stationNum.value);
        exchangeState.value=true;
        exchangeState2.value=true;
      }
      else if((f.line3.contains(startStation.value) || f.line3Pt3.contains(startStation.value))&&f.line2.contains(endStation.value))////////////////////////////////////////FROM 3 TO 2 ROD EL FARAG
          {
        f.line3.addAll(f.line3Pt3);
        route.value =f. routeExchange(metroLine1:f. line3, metroLine2:f. line2, exchangeList:f. exchangeStations, start: startStation.value, end: endStation.value);
        stationNum.value =f. routeExchangeLength(metroLine1: f.line3, metroLine2: f.line2, exchangeList:f. exchangeStations, start: startStation.value, end: endStation.value);
        time.value = f.routeExchangeLength(metroLine1:f. line3, metroLine2:f. line2, exchangeList:f. exchangeStations, start: startStation.value, end: endStation.value)*2.0;
        exchangeStation.value=f.nearestStation(metroLine1: f.line3, metroLine2: f.line2, exchangeList: f.exchangeStations, start: startStation.value, end: endStation.value);
        direction1.value = f.directionChange(start: startStation.value, end: exchangeStation.value, metroLine:f. line3);
        direction2.value = f.directionChange(start: exchangeStation.value, end: endStation.value, metroLine: f.line2);
        price.value =f. priceChange(routeLength: stationNum.value);
        exchangeState.value=true;
        exchangeState2.value=true;}

    }
values();
    return Scaffold(
      appBar: AppBar(
          title: Text('${details['name']}, That is your detailed trip info'
              ,style: TextStyle(fontSize: 15.0)
          ),
          backgroundColor: Colors.red,
          foregroundColor: Colors.white
      ),
      body:
      Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [

            Obx(() {
              return Row(
                children: [
                  Text('Your start station is : ',
                    style: TextStyle(fontSize: 18.0),),
                  Spacer(),
                  Text('$startStation',style: TextStyle(fontSize: 18,color: Colors.red))
                ],
              );
            })
            , Obx(() {
              return Row(
                children: [
                  Text('Your end station is :',style: TextStyle(fontSize: 18)),
                  Spacer(),
                  Text('$endStation',style: TextStyle(fontSize: 18,color: Colors.red))
                ],
              );
            })
            , Obx(() {
              return Row(
                children: [
                  Text('Ticket price is : ',style: TextStyle(fontSize: 18)),
                  Spacer(),
                  Text('$price L.E.',style: TextStyle(fontSize: 18))
                ],
              );
            }),
            Obx(() {
              return Row(
                children: [
                  Text('Estimated time is :',style: TextStyle(fontSize: 18)),
                  Spacer(),
                  Text('$time minutes',style: TextStyle(fontSize: 18)),
                ],
              );

            }),
            Visibility(visible: exchangeState.value,child: Text('Add 10 to 15 mins exchange time')),
            Obx(() {
              return Row(
                children: [
                  Text('Number of stations : ',style: TextStyle(fontSize: 18)),
                  Spacer(),
                  Text('$stationNum station',style: TextStyle(fontSize: 18))
                ],
              );
            }),
            Obx(() {
              return Row(
                children: [
                  Text('Direction : ',style: TextStyle(fontSize: 18) ),
                  Spacer(),
                  Text('$direction1 ',style: TextStyle(fontSize: 18,color: Colors.red))
                  ,Text('direction',style: TextStyle(fontSize: 18))
                ],
              );
            })
            , Obx(() {
              return Visibility(visible: exchangeState.value ,
                  child: Row(
                    children: [
                      Text('Exchange Station : ',style: TextStyle(fontSize: 18)),
                      Spacer(),
                      Text('$exchangeStation',style: TextStyle(fontSize: 18,color: Colors.orange))
                    ],
                  ));
            }),
            Obx(() {
              return Visibility(visible: exchangeState2.value ,
                  child: Row(
                    children: [
                      Text('Direction 2 : ',style: TextStyle(fontSize: 18)),
                      Spacer(),
                      Text('$direction2 ',style: TextStyle(fontSize: 18,color: Colors.red)),
                      Text('direction',style: TextStyle(fontSize: 18))
                    ],
                  ));
            })
            , Obx(() {
              return Text('$route',style: TextStyle(fontSize: 18));
            }),

            ElevatedButton(onPressed: (){
              var temp = startStation.value;
              startStation.value = endStation.value;
              endStation.value = temp;
              values();

            },
                child: Text('Swap Stations')),

          ],
        ),
      ),
    );
  }

}

