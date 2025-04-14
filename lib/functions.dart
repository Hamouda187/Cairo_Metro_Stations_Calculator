class Functions{
  final line1 = [
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
  ];
  final line2 = [
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
  ];
  var line3 = [
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
  ];
  var line3Pt2 = [
    "KitKat",
    "Tawfikia",
    "Wadi El Nile",
    'Gamet El Dowal',
    "Bulaq El Dakrour",
    "Cairo University"
  ];
  var line3Pt3= [
    "KitKat",
    "Sudan",
    "Imbaba",
    "El Bohy",
    'El-Qawmia',
    "Ring Road",
    "Rod El Farag Corridor"
  ];
  final exchangeStations = [
    'Sadat',
    'Ataba',
    'Nasser',
    'Al-Shohadaa',
    'KitKat',
    'Cairo University'
  ];

  int price;


  String direction1;
  String direction2;
  String route;
  int stationNum;
  double time;
  String exchangeStation;
  bool exchangeState =false;
  bool exchangeState2 =false;


  final String startStation;
  final String endStation;


  Functions(this.price, this.direction1, this.direction2, this.route,
      this.stationNum, this.time, this.exchangeState2, this.startStation,
      this.endStation,this.exchangeStation);




  int calculations(int startIndex, int endIndex) {
    /////////////////////CALCULATING TIME, STATIONS AND PRICE
    final diff = (startIndex - endIndex).abs();
    if (diff <= 9) {
      return 8;
    } else if (diff <= 16) {
      return 10;
    } else if (diff <= 23) {
      return 15;
    } else {
      return 20;
    }
  }



  String routePrint(int endIndex, int startIndex, List<String> metroLine) {
    //////////////////////////////PRINTING ROUTE
    if (endIndex > startIndex) {
      final route = metroLine.sublist(startIndex, endIndex + 1);
      final routeSet = route.toSet();
      return ('Route: ${routeSet.join(' => ')}');
    }
    else {
      final route = metroLine
          .sublist(endIndex, startIndex + 1)
          .reversed
          .toList();
      final routeSet = route.toSet();
      return ('Route: ${routeSet.join(' => ')}');
    }
  }

  int routeLength(int endIndex, int startIndex, List<String> metroLine) {
    //////////////////////////////PRINTING ROUTE
    if (endIndex > startIndex) {
      final route = metroLine.sublist(startIndex, endIndex + 1);
      final routeSet = route.toSet();
      return routeSet.length;
    }
    else {
      final route = metroLine
          .sublist(endIndex, startIndex + 1)
          .reversed
          .toList();
      final routeSet = route.toSet();
      return routeSet.length;
    }
  }

  String routeExchange({required List<String> metroLine1,required List<String> metroLine2,required List<String> exchangeList
    ,required String start, required String end})
  {

    final exchangeStation = nearestStation(metroLine1: metroLine1, metroLine2: metroLine2, exchangeList: exchangeList, start: start, end: end);
    final Set<String> routeSet = <String>{};
    final startIndex = metroLine1.indexOf(start);
    final endIndex = metroLine2.indexOf(end);
    var counter = startIndex;
    var exchangeIndex = 0; // empty exchange index
    exchangeIndex = metroLine1.indexOf(exchangeStation); // set the exchange index to the nearest one to the start
    if(exchangeIndex>startIndex)
    {
      while(counter<=exchangeIndex)
      {
        routeSet.add(metroLine1[counter]);//adding the stations to the route
        counter++;
      }
    }else if(exchangeIndex<startIndex)
    {
      while(counter>=exchangeIndex)
      {
        routeSet.add(metroLine1[counter]);//adding the stations to the route
        counter--;
      }
    }
    exchangeIndex = metroLine2.indexOf(exchangeStation);//change the exchange index to be line 2
    counter=exchangeIndex;
    if(exchangeIndex>endIndex)
    {
      while(counter>=endIndex)
      {
        routeSet.add(metroLine2[counter]);//adding the stations to the route
        counter--;
      }
    }else if(exchangeIndex<endIndex)
    {
      while(counter<=endIndex)
      {
        routeSet.add(metroLine2[counter]);//adding the stations to the route
        counter++;
      }
    }
    var route = routeSet.toList();
    calculations(0, routeSet.length);
    return ('Route : ${route.join(' => ')}');
  }
  String nearestStation({required List<String> metroLine1,required List<String> metroLine2,required List<String> exchangeList
    ,required String start, required String end})
  {
    final startIndex = metroLine1.indexOf(start);
    final metroLine1Set = metroLine1.toSet();
    final metroLine2Set = metroLine2.toSet();
    var exchangeIndex = 0; // empty exchange index
    var miniDistance = metroLine1.length; //mini distance to see the distance between start and the nearest exchange station
    var nearestChangeStation = ''; //empty nearest exchange station
    for (int i = 0; i < exchangeList.length; i++) {
      if(metroLine1Set.contains(exchangeList[i])&& metroLine2Set.contains(exchangeList[i])) // check that the 2 lines have the same exchange stations
          {
        exchangeIndex = metroLine1.indexOf(exchangeList[i]);
        var distance = (startIndex-exchangeIndex).abs(); // check the distance between start and exchange station

        if(distance<miniDistance)// if the new distance is less than the old one add the new one
            {
          miniDistance=distance;
          nearestChangeStation = metroLine1[exchangeIndex];
        }

      }
    }
    return nearestChangeStation;
  }
  String directionChange({required String start, required String end, required List<String> metroLine})
  {
    if(metroLine.indexOf(start) > metroLine.indexOf(end))
    {
      return metroLine[0];
    }else {
      return metroLine[metroLine.length-1];
    }
  }

  int routeExchangeLength({required List<String> metroLine1,required List<String> metroLine2,required List<String> exchangeList
    ,required String start, required String end})
  {

    final exchangeStation = nearestStation(metroLine1: metroLine1, metroLine2: metroLine2, exchangeList: exchangeList, start: start, end: end);
    final Set<String> routeSet = <String>{};
    final startIndex = metroLine1.indexOf(start);
    final endIndex = metroLine2.indexOf(end);
    var counter = startIndex;
    var exchangeIndex = 0; // empty exchange index
    exchangeIndex = metroLine1.indexOf(exchangeStation); // set the exchange index to the nearest one to the start
    if(exchangeIndex>startIndex)
    {
      while(counter<=exchangeIndex)
      {
        routeSet.add(metroLine1[counter]);//adding the stations to the route
        counter++;
      }
    }else if(exchangeIndex<startIndex)
    {
      while(counter>=exchangeIndex)
      {
        routeSet.add(metroLine1[counter]);//adding the stations to the route
        counter--;
      }
    }
    exchangeIndex = metroLine2.indexOf(exchangeStation);//change the exchange index to be line 2
    counter=exchangeIndex;
    if(exchangeIndex>endIndex)
    {
      while(counter>=endIndex)
      {
        routeSet.add(metroLine2[counter]);//adding the stations to the route
        counter--;
      }
    }else if(exchangeIndex<endIndex)
    {
      while(counter<=endIndex)
      {
        routeSet.add(metroLine2[counter]);//adding the stations to the route
        counter++;
      }
    }

    return routeSet.length;
  }
  int priceChange({required int routeLength})
  {
    if (routeLength <= 9) {
      return 8;
    } else if (routeLength <= 16) {
      return 10;
    } else if (routeLength <= 23) {
      return 15;
    } else {
      return 20;
    }
  }


}
