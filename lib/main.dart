import 'package:flutter/material.dart';

void main() {
  runApp(const MetroStationCalculatorApp());
}

class MetroStationCalculatorApp extends StatelessWidget {
  const MetroStationCalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Metro Station Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: 'Roboto',
      ),
      home: const HomePage(),
    );
  }
}

class MetroMapPage extends StatelessWidget {
  const MetroMapPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Metro Map'),
        backgroundColor: Colors.blueAccent,
        elevation: 0,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.blueAccent, Colors.teal],
          ),
        ),
        child: InteractiveViewer(
          boundaryMargin: const EdgeInsets.all(20.0),
          minScale: 0.5,
          maxScale: 4.0,
          child: Center(
            child: Image.asset(
              'assets/metro_map.png',
              fit: BoxFit.contain,
              width: double.infinity,
              height: double.infinity,
            ),
          ),
        ),
      ),
    );
  }
}

class ResultPage extends StatelessWidget {
  final String start;
  final String end;
  final List<String> line1;
  final List<String> line2;
  final List<String> line3;
  final List<String> line3Pt2;
  final List<String> line3Pt3;
  final List<String> exchangeStations;

  const ResultPage({
    super.key,
    required this.start,
    required this.end,
    required this.line1,
    required this.line2,
    required this.line3,
    required this.line3Pt2,
    required this.line3Pt3,
    required this.exchangeStations,
  });

  Map<String, String?> calculateRoute() {
    final line1Set = line1.toSet();
    final line2Set = line2.toSet();
    var line3Set = line3.toSet();
    final line3SetPt2 = line3Pt2.toSet();
    final line3SetPt3 = line3Pt3.toSet();

    Map<String, String?> result = {'start': start, 'end': end};

    if (!line1Set.contains(start) && !line2Set.contains(start) && !line3Set.contains(start) && !line3SetPt2.contains(start) && !line3SetPt3.contains(start)) {
      result['error'] = 'Invalid start station.\nThank you for using our system.';
      return result;
    }
    if (!line1Set.contains(end) && !line2Set.contains(end) && !line3Set.contains(end) && !line3SetPt2.contains(end) && !line3SetPt3.contains(end)) {
      result['error'] = 'Invalid end station.\nThank you for using our system.';
      return result;
    }
    if (start == end) {
      result['error'] = 'You are at the same station.\nThank you for using our system.';
      return result;
    }

    if (line1Set.contains(start) && line1Set.contains(end)) {
      return oneLine(start: start, end: end, metroLine: line1);
    } else if (line2Set.contains(start) && line2Set.contains(end)) {
      return oneLine(start: start, end: end, metroLine: line2);
    } else if ((line3Set.contains(start) && line3Set.contains(end)) ||
        ((line3Set.contains(start) || line3Set.contains(end)) && (line3SetPt2.contains(start) || line3SetPt2.contains(end))) ||
        (line3SetPt2.contains(start) && line3SetPt2.contains(end))) {
      var combinedLine3 = [...line3, ...line3Pt2];
      return oneLine(start: start, end: end, metroLine: combinedLine3);
    } else if (((line3Set.contains(start) || line3Set.contains(end)) && (line3SetPt3.contains(start) || line3SetPt3.contains(end))) ||
        (line3SetPt3.contains(start) && line3SetPt3.contains(end))) {
      var combinedLine3 = [...line3, ...line3Pt3];
      return oneLine(start: start, end: end, metroLine: combinedLine3);
    } else if (line3SetPt2.contains(start) && line3SetPt3.contains(end)) {
      return oneLineU(start: start, end: end, metroLine: line3Pt2, metroLine2: line3Pt3);
    } else if (line3SetPt3.contains(start) && line3SetPt2.contains(end)) {
      return oneLineU(start: start, end: end, metroLine: line3Pt3, metroLine2: line3Pt2);
    } else if (line1Set.contains(start) && line2Set.contains(end)) {
      return twoLine(metroLine1: line1, metroLine2: line2, start: start, end: end, exchangeList: exchangeStations);
    } else if (line2Set.contains(start) && line1Set.contains(end)) {
      return twoLine(metroLine1: line2, metroLine2: line1, start: start, end: end, exchangeList: exchangeStations);
    } else if (line1Set.contains(start) && (line3Set.contains(end) || line3SetPt2.contains(end))) {
      var combinedLine3 = [...line3, ...line3Pt2];
      return twoLine(metroLine1: line1, metroLine2: combinedLine3, start: start, end: end, exchangeList: exchangeStations);
    } else if (line1Set.contains(start) && (line3Set.contains(end) || line3SetPt3.contains(end))) {
      var combinedLine3 = [...line3, ...line3Pt3];
      return twoLine(metroLine1: line1, metroLine2: combinedLine3, start: start, end: end, exchangeList: exchangeStations);
    } else if (line2Set.contains(start) && (line3Set.contains(end) || line3SetPt2.contains(end))) {
      var combinedLine3 = [...line3, ...line3Pt2];
      return twoLine(metroLine1: line2, metroLine2: combinedLine3, start: start, end: end, exchangeList: exchangeStations);
    } else if (line2Set.contains(start) && (line3Set.contains(end) || line3SetPt3.contains(end))) {
      var combinedLine3 = [...line3, ...line3Pt3];
      return twoLine(metroLine1: line2, metroLine2: combinedLine3, start: start, end: end, exchangeList: exchangeStations);
    } else if ((line3Set.contains(start) || line3SetPt2.contains(start)) && line1Set.contains(end)) {
      var combinedLine3 = [...line3, ...line3Pt2];
      return twoLine(metroLine1: combinedLine3, metroLine2: line1, start: start, end: end, exchangeList: exchangeStations);
    } else if ((line3Set.contains(start) || line3SetPt2.contains(start)) && line2Set.contains(end)) {
      var combinedLine3 = [...line3, ...line3Pt2];
      return twoLine(metroLine1: combinedLine3, metroLine2: line2, start: start, end: end, exchangeList: exchangeStations);
    } else if ((line3Set.contains(start) || line3SetPt3.contains(start)) && line1Set.contains(end)) {
      var combinedLine3 = [...line3, ...line3Pt3];
      return twoLine(metroLine1: combinedLine3, metroLine2: line1, start: start, end: end, exchangeList: exchangeStations);
    } else if ((line3Set.contains(start) || line3SetPt3.contains(start)) && line2Set.contains(end)) {
      var combinedLine3 = [...line3, ...line3Pt3];
      return twoLine(metroLine1: combinedLine3, metroLine2: line2, start: start, end: end, exchangeList: exchangeStations);
    }
    result['error'] = 'Route calculation error.';
    return result;
  }

  Map<String, String?> calculations(int startIndex, int endIndex) {
    final diff = ((startIndex - endIndex).abs())+1;
    String ticketPrice;
    if (diff <= 9) {
      ticketPrice = '8 L.E.';
    } else if (diff <= 16) {
      ticketPrice = '10 L.E.';
    } else if (diff <= 23) {
      ticketPrice = '15 L.E.';
    } else {
      ticketPrice = '20 L.E.';
    }
    return {
      'ticketPrice': ticketPrice,
      'stationsCount': '$diff stations',
      'estimatedTime': '${diff * 2} minutes',
    };
  }

  Map<String, String?> routePrint(int endIndex, int startIndex, List<String> metroLine) {
    String direction;
    String route;

    if (endIndex > startIndex) {
      direction = 'Towards: ${metroLine[metroLine.length - 1]}';
      final routeList = metroLine.sublist(startIndex, endIndex + 1);
      route = routeList
          .asMap()
          .entries
          .map((entry) => '${entry.key + 1}. ${entry.value}')
          .join('\n');
    } else {
      direction = 'Towards: ${metroLine[0]}';
      final routeList = metroLine.sublist(endIndex, startIndex + 1).reversed.toList();
      route = routeList
          .asMap()
          .entries
          .map((entry) => '${entry.key + 1}. ${entry.value}')
          .join('\n');
    }

    return {
      'directions': direction,
      'route': 'Your Route:\n$route',
    };
  }

  Map<String, String?> oneLine({required String start, required String end, required List<String> metroLine}) {
    final startIndex = metroLine.indexOf(start);
    final endIndex = metroLine.indexOf(end);
    final calc = calculations(startIndex, endIndex);
    final route = routePrint(endIndex, startIndex, metroLine);
    return {
      'start': metroLine[startIndex],
      'end': metroLine[endIndex],
      'ticketPrice': calc['ticketPrice'],
      'stationsCount': calc['stationsCount'],
      'estimatedTime': calc['estimatedTime'],
      'directions': route['directions'],
      'route': route['route'],
    };
  }

  Map<String, String?> oneLineU({required String start, required String end, required List<String> metroLine, required List<String> metroLine2}) {
    var combinedLine = [...metroLine.reversed, ...metroLine2];
    final startIndex = combinedLine.indexOf(start);
    final endIndex = combinedLine.indexOf(end);
    final exchangeStation = metroLine2[0];
    final exchangeIndex = combinedLine.indexOf(exchangeStation);
    final calc = calculations(startIndex, endIndex);

    late String direction;
    String route;

    if (endIndex > startIndex) {
      direction = 'Towards: ${combinedLine[combinedLine.length - 1]}';
    } else {
      direction = 'Towards: ${combinedLine[0]}';
    }

    final firstLeg = startIndex < exchangeIndex
        ? combinedLine.sublist(startIndex, exchangeIndex)
        : combinedLine.sublist(exchangeIndex + 1, startIndex + 1).reversed.toList();
    final secondLeg = endIndex > exchangeIndex
        ? combinedLine.sublist(exchangeIndex + 1, endIndex + 1)
        : combinedLine.sublist(endIndex, exchangeIndex).reversed.toList();

    final routeList = [
      ...firstLeg,
      exchangeStation,
      ...secondLeg,
    ];
    route = 'Your Route:\n${routeList.asMap().entries.map((e) => '${e.key + 1}. ${e.value}').join('\n')}';

    return {
      'start': combinedLine[startIndex],
      'end': combinedLine[endIndex],
      'ticketPrice': calc['ticketPrice'],
      'stationsCount': calc['stationsCount'],
      'estimatedTime': calc['estimatedTime'],
      'exchange': exchangeStation,
      'directions': direction,
      'route': route,
    };
  }

  Map<String, String?> twoLine({required List<String> metroLine1, required List<String> metroLine2, required List<String> exchangeList, required String start, required String end}) {
    final startIndex = metroLine1.indexOf(start);
    final endIndex = metroLine2.indexOf(end);
    final metroLine1Set = metroLine1.toSet();
    final metroLine2Set = metroLine2.toSet();
    var miniDistance = metroLine1.length;
    var nearestChangeStation = '';

    for (var exchange in exchangeList) {
      if (metroLine1Set.contains(exchange) && metroLine2Set.contains(exchange)) {
        final exchangeIndex = metroLine1.indexOf(exchange);
        final distance = (startIndex - exchangeIndex).abs();
        if (distance < miniDistance) {
          miniDistance = distance;
          nearestChangeStation = metroLine1[exchangeIndex];
        }
      }
    }

    final exchangeIndex1 = metroLine1.indexOf(nearestChangeStation);
    final exchangeIndex2 = metroLine2.indexOf(nearestChangeStation);
    final routeSet = <String>{};
    late String direction1, direction2;

    if (exchangeIndex1 > startIndex) {
      for (int i = startIndex; i <= exchangeIndex1; i++) {
        routeSet.add(metroLine1[i]);
      }
      direction1 = metroLine1[metroLine1.length - 1];
    } else {
      for (int i = startIndex; i >= exchangeIndex1; i--) {
        routeSet.add(metroLine1[i]);
      }
      direction1 = metroLine1[0];
    }

    if (exchangeIndex2 > endIndex) {
      for (int i = exchangeIndex2; i >= endIndex; i--) {
        routeSet.add(metroLine2[i]);
      }
      direction2 = metroLine2[0];
    } else {
      for (int i = exchangeIndex2; i <= endIndex; i++) {
        routeSet.add(metroLine2[i]);
      }
      direction2 = metroLine2[metroLine2.length - 1];
    }

    final calc = calculations(0, routeSet.length - 1);

    final firstLeg = exchangeIndex1 > startIndex
        ? metroLine1.sublist(startIndex, exchangeIndex1)
        : metroLine1.sublist(exchangeIndex1 + 1, startIndex + 1).reversed.toList();
    final secondLeg = exchangeIndex2 > endIndex
        ? metroLine2.sublist(endIndex, exchangeIndex2).reversed.toList()
        : metroLine2.sublist(exchangeIndex2 + 1, endIndex + 1);

    final routeList = [
      ...firstLeg,
      nearestChangeStation,
      ...secondLeg,
    ];
    final route = 'Your Route:\n${routeList.asMap().entries.map((e) => '${e.key + 1}. ${e.value}').join('\n')}';

    String line1Name = metroLine1 == line1 ? 'Line 1' : metroLine1 == line2 ? 'Line 2' : 'Line 3';
    String line2Name = metroLine2 == line1 ? 'Line 1' : metroLine2 == line2 ? 'Line 2' : 'Line 3';

    return {
      'start': start,
      'end': end,
      'ticketPrice': calc['ticketPrice'],
      'stationsCount': calc['stationsCount'],
      'estimatedTime': calc['estimatedTime'],
      'directions': 'Take $line1Name towards $direction1\nExchange at $nearestChangeStation to $line2Name\nContinue towards $direction2',
      'exchange': nearestChangeStation,
      'route': route,
    };
  }

  @override
  Widget build(BuildContext context) {
    final result = calculateRoute();

    Color ticketPriceColor;
    TextStyle ticketPriceStyle;
    switch (result['ticketPrice']) {
      case '8 L.E.':
        ticketPriceColor = Colors.yellow;
        ticketPriceStyle = TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          foreground: Paint()
            ..style = PaintingStyle.stroke
            ..strokeWidth = 1.0
            ..color = Colors.black,
        );
        break;
      case '10 L.E.':
        ticketPriceColor = Colors.green;
        ticketPriceStyle = const TextStyle(fontSize: 16, fontWeight: FontWeight.w600);
        break;
      case '15 L.E.':
        ticketPriceColor = Colors.pink;
        ticketPriceStyle = const TextStyle(fontSize: 16, fontWeight: FontWeight.w600);
        break;
      case '20 L.E.':
        ticketPriceColor = const Color(0xFFF5F5DC);
        ticketPriceStyle = TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          foreground: Paint()
            ..style = PaintingStyle.stroke
            ..strokeWidth = 1.0
            ..color = Colors.black,
        );
        break;
      default:
        ticketPriceColor = Colors.green;
        ticketPriceStyle = const TextStyle(fontSize: 16, fontWeight: FontWeight.w600);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Metro Route', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        backgroundColor: Colors.blueAccent,
        elevation: 0,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.blueAccent, Colors.teal],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Card(
              elevation: 8,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSection(
                      title: 'Stations',
                      icon: Icons.train,
                      iconColor: Colors.deepPurple,
                      content: [
                        _buildRow('Start', start, Colors.blueAccent),
                        const SizedBox(height: 8),
                        _buildRow('End', end, Colors.redAccent),
                      ],
                    ),
                    const Divider(color: Colors.grey),
                    if (result['ticketPrice'] != null) ...[
                      _buildSection(
                        title: 'Pricing & Stats',
                        icon: Icons.info,
                        iconColor: Colors.orange,
                        content: [
                          _buildRowWithStyle('Ticket Price', result['ticketPrice']!, ticketPriceColor, ticketPriceStyle),
                          _buildRow('Stations Count', result['stationsCount']!, Colors.orange),
                          _buildRow('Estimated Time', result['estimatedTime']!, Colors.purple),
                        ],
                      ),
                      const Divider(color: Colors.grey),
                    ],
                    if (result['directions'] != null)
                      _buildSection(
                        title: 'Directions',
                        icon: Icons.directions,
                        iconColor: Colors.teal,
                        content: [
                          RichText(
                            text: result['directions']!.contains('\n')
                                ? TextSpan(
                              style: const TextStyle(fontSize: 16, fontFamily: 'Roboto'),
                              children: [
                                const TextSpan(text: 'Step 1: ', style: TextStyle(color: Colors.blueAccent, fontWeight: FontWeight.bold)),
                                TextSpan(text: result['directions']!.split('\n')[0], style: const TextStyle(color: Colors.black87)),
                                const TextSpan(text: '\nStep 2: ', style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
                                TextSpan(text: result['directions']!.split('\n')[1], style: const TextStyle(color: Colors.black87)),
                                const TextSpan(text: '\nStep 3: ', style: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold)),
                                TextSpan(text: result['directions']!.split('\n')[2], style: const TextStyle(color: Colors.black87)),
                              ],
                            )
                                : TextSpan(
                              style: const TextStyle(fontSize: 16, fontFamily: 'Roboto'),
                              children: [
                                const TextSpan(text: 'Step 1: ', style: TextStyle(color: Colors.blueAccent, fontWeight: FontWeight.bold)),
                                TextSpan(text: result['directions']!, style: const TextStyle(color: Colors.black87)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    if (result['exchange'] != null) ...[
                      const Divider(color: Colors.grey),
                      _buildSection(
                        title: 'Exchange At',
                        icon: Icons.swap_horiz,
                        iconColor: Colors.deepOrange,
                        content: [
                          Text(
                            result['exchange']!,
                            style: const TextStyle(fontSize: 16, color: Colors.deepOrangeAccent),
                          ),
                        ],
                      ),
                    ],
                    if (result['route'] != null) ...[
                      const Divider(color: Colors.grey),
                      _buildSection(
                        title: 'Route',
                        icon: Icons.map,
                        iconColor: Colors.indigo,
                        content: [
                          Text(
                            result['route']!,
                            style: const TextStyle(fontSize: 16, color: Colors.indigo),
                          ),
                        ],
                      ),
                    ],
                    if (result['error'] != null)
                      _buildSection(
                        title: 'Message',
                        icon: Icons.warning,
                        iconColor: Colors.red,
                        content: [
                          Text(
                            result['error']!,
                            style: const TextStyle(fontSize: 16, color: Colors.redAccent),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSection({required String title, required IconData icon, required List<Widget> content, Color iconColor = Colors.blueAccent}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: iconColor, size: 28),
            const SizedBox(width: 8),
            Text(
              title,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: iconColor),
            ),
          ],
        ),
        const SizedBox(height: 12),
        ...content,
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildRow(String label, String value, Color color) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '$label:',
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black54),
        ),
        Flexible(
          child: Text(
            value,
            style: TextStyle(fontSize: 16, color: color, fontWeight: FontWeight.w600),
            textAlign: TextAlign.right,
          ),
        ),
      ],
    );
  }

  Widget _buildRowWithStyle(String label, String value, Color color, TextStyle style) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '$label:',
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black54),
        ),
        Flexible(
          child: Text(
            value,
            style: style.copyWith(color: color),
            textAlign: TextAlign.right,
          ),
        ),
      ],
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  String? startStation;
  String? endStation;
  late AnimationController _controller;
  late Animation<double> _animation;
  final TextEditingController _startSearchController = TextEditingController();
  final TextEditingController _endSearchController = TextEditingController();
  List<String> filteredStartStations = [];
  List<String> filteredEndStations = [];
  bool showStartDropdown = false;
  bool showEndDropdown = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _animation = Tween<double>(begin: 1.0, end: 1.1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
    _startSearchController.addListener(_filterStartStations);
    _endSearchController.addListener(_filterEndStations);
  }

  @override
  void dispose() {
    _controller.dispose();
    _startSearchController.dispose();
    _endSearchController.dispose();
    super.dispose();
  }

  final List<String> line1 = [
    'New El-Marg', 'El-Marg', 'Ezbet El-Nakhl', 'Ain Shams', 'El-Matareyya',
    'Helmeyet El-Zaitoun', 'Hadayeq El-Zaitoun', 'Saray El-Qobba',
    'Hammamat El-Qobba', 'Kobri El-Qobba', 'Manshiet El-Sadr', 'El-Demerdash',
    'Ghamra', 'Al-Shohadaa', 'Orabi', 'Nasser', 'Sadat', 'Saad Zaghloul',
    'Sayyeda Zeinab', 'El-Malek El-Saleh', 'Mar Girgis', 'El-Zahraa',
    'Dar El-Salam', 'Hadayeq El-Maadi', 'Maadi', 'Sakanat El-Maadi',
    'Tora El-Balad', 'Kozzika', 'Tora El-Asmant', 'El-Maasara',
    'Hadayeq Helwan', 'Wadi Hof', 'Helwan University', 'Ain Helwan', 'Helwan'
  ];

  final List<String> line2 = [
    'Shubra El-Kheima', 'Kolleyet El-Zeraa', 'Mezallat', 'Khalafawy', 'St. Teresa', 'Road El-Farag',
    'El-Massara', 'Al-Shohadaa', 'Ataba', 'Mohamed Naguib', 'Sadat', 'Opera', 'Dokki', 'El Behoos',
    'Cairo University', 'Faisal', 'Giza', 'Omm El-Misryeen', 'Sakiat Mekki',
    'El-Monib'
  ];

  final List<String> line3 = [
    "Adly Mansour", "El Haykestep", "Omar Ibn El Khattab", "Qobaa",
    "Hesham Barakat", "El Nozha", "Nadi El Shams", "Alf Maskan", "Heliopolis",
    "Haroun", "Al Ahram", "Koleyet El Banat", "Cairo Stadium", "Fair Zone",
    "Abbassiya", "Abdou Pasha", "El Geish", "Bab El Shaaria", "Ataba",
    "Nasser", "Maspero", "Safaa Hegazy", "KitKat"
  ];

  final List<String> line3Pt2 = [
    "KitKat", "Tawfikia", "Wadi El Nile", "Gamet El Dowal", "Bulaq El Dakrour",
    "Cairo University"
  ];

  final List<String> line3Pt3 = [
    "KitKat", "Sudan", "Imbaba", "El Bohy", "El-Qawmia", "Ring Road",
    "Rod El Farag Corridor"
  ];

  final List<String> exchangeStations = ['Sadat', 'Ataba', 'Nasser', 'Al-Shohadaa', 'KitKat','Cairo University'];

  List<String> getAllStations() {
    final allStations = <String>{};
    allStations.addAll(line1);
    allStations.addAll(line2);
    allStations.addAll(line3);
    allStations.addAll(line3Pt2);
    allStations.addAll(line3Pt3);
    return allStations.toList()..sort();
  }

  void _filterStartStations() {
    final query = _startSearchController.text.toLowerCase();
    final allStations = getAllStations();
    setState(() {
      filteredStartStations = allStations
          .where((station) => station.toLowerCase().contains(query))
          .toList();
      showStartDropdown = query.isNotEmpty && filteredStartStations.isNotEmpty;
    });
  }

  void _filterEndStations() {
    final query = _endSearchController.text.toLowerCase();
    final allStations = getAllStations();
    setState(() {
      filteredEndStations = allStations
          .where((station) => station.toLowerCase().contains(query))
          .toList();
      showEndDropdown = query.isNotEmpty && filteredEndStations.isNotEmpty;
    });
  }

  void calculateRoute() {
    if ((startStation == null && _startSearchController.text.isEmpty) ||
        (endStation == null && _endSearchController.text.isEmpty)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select or search both start and end stations')),
      );
      return;
    }

    final start = startStation ?? _startSearchController.text;
    final end = endStation ?? _endSearchController.text;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ResultPage(
          start: start,
          end: end,
          line1: line1,
          line2: line2,
          line3: line3,
          line3Pt2: line3Pt2,
          line3Pt3: line3Pt3,
          exchangeStations: exchangeStations,
        ),
      ),
    );
  }

  void showMetroMap() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const MetroMapPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final allStations = getAllStations();

    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Colors.blueAccent, Colors.teal],
              ),
            ),
            child: Opacity(
              opacity: 0.1,
              child: Center(
                child: Image.asset(
                  'assets/egypt_metro_logo.png',
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                ),
              ),
            ),
          ),
          Column(
            children: [
              AppBar(
                title: const Text(
                  'Metro Station Calculator',
                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                ),
                leading: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset('assets/egypt_metro_logo.png'),
                ),
                backgroundColor: Colors.transparent,
                elevation: 0,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 40.0),
                  child: Card(
                    elevation: 10,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextField(
                                  controller: _startSearchController,
                                  decoration: InputDecoration(
                                    labelText: 'Start Station',
                                    prefixIcon: const Icon(Icons.train, color: Colors.blueAccent),
                                    suffixIcon: PopupMenuButton<String>(
                                      icon: const Icon(Icons.arrow_drop_down),
                                      onSelected: (value) {
                                        setState(() {
                                          _startSearchController.text = value;
                                          startStation = value;
                                          showStartDropdown = false;
                                        });
                                      },
                                      itemBuilder: (context) => allStations
                                          .map((station) => PopupMenuItem(
                                        value: station,
                                        child: Text(station),
                                      ))
                                          .toList(),
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    filled: true,
                                    fillColor: Colors.grey[100],
                                  ),
                                ),
                                if (showStartDropdown)
                                  Container(
                                    constraints: const BoxConstraints(maxHeight: 200),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(12),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          spreadRadius: 2,
                                          blurRadius: 5,
                                        ),
                                      ],
                                    ),
                                    child: ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: filteredStartStations.length,
                                      itemBuilder: (context, index) {
                                        return ListTile(
                                          title: Text(filteredStartStations[index]),
                                          onTap: () {
                                            setState(() {
                                              _startSearchController.text = filteredStartStations[index];
                                              startStation = filteredStartStations[index];
                                              showStartDropdown = false;
                                            });
                                          },
                                        );
                                      },
                                    ),
                                  ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextField(
                                  controller: _endSearchController,
                                  decoration: InputDecoration(
                                    labelText: 'End Station',
                                    prefixIcon: const Icon(Icons.train, color: Colors.blueAccent),
                                    suffixIcon: PopupMenuButton<String>(
                                      icon: const Icon(Icons.arrow_drop_down),
                                      onSelected: (value) {
                                        setState(() {
                                          _endSearchController.text = value;
                                          endStation = value;
                                          showEndDropdown = false;
                                        });
                                      },
                                      itemBuilder: (context) => allStations
                                          .map((station) => PopupMenuItem(
                                        value: station,
                                        child: Text(station),
                                      ))
                                          .toList(),
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    filled: true,
                                    fillColor: Colors.grey[100],
                                  ),
                                ),
                                if (showEndDropdown)
                                  Container(
                                    constraints: const BoxConstraints(maxHeight: 200),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(12),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          spreadRadius: 2,
                                          blurRadius: 5,
                                        ),
                                      ],
                                    ),
                                    child: ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: filteredEndStations.length,
                                      itemBuilder: (context, index) {
                                        return ListTile(
                                          title: Text(filteredEndStations[index]),
                                          onTap: () {
                                            setState(() {
                                              _endSearchController.text = filteredEndStations[index];
                                              endStation = filteredEndStations[index];
                                              showEndDropdown = false;
                                            });
                                          },
                                        );
                                      },
                                    ),
                                  ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ScaleTransition(
                                  scale: _animation,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      _controller.forward().then((_) => _controller.reverse());
                                      calculateRoute();
                                    },
                                    style: ElevatedButton.styleFrom(
                                      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                      backgroundColor: Colors.blueAccent,
                                      elevation: 5,
                                    ),
                                    child: const Text(
                                      'Calculate Route',
                                      style: TextStyle(fontSize: 18, color: Colors.white),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 20),
                                ElevatedButton(
                                  onPressed: showMetroMap,
                                  style: ElevatedButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                    backgroundColor: Colors.teal,
                                    elevation: 5,
                                  ),
                                  child: const Text(
                                    'Show Metro Map',
                                    style: TextStyle(fontSize: 18, color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}