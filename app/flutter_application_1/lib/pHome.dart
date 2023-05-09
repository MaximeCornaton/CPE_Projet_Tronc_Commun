import 'package:flutter/material.dart';
import 'package:flutter_application_1/cWebSocket.dart';

class HomePage extends StatefulWidget {
  const HomePage(
      {Key? key,
      required this.webSocketVideo,
      required this.webSocketMap,
      required this.webSocketControl})
      : super(key: key);

  final WebSocket webSocketVideo;
  final WebSocket webSocketMap;
  final WebSocket webSocketControl;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
//   List<Widget> boxes = [
//     const RoundedBox(
//       width: double.infinity,
//       height: 200.0,
//       borderColor: Colors.orange,
//     ),
//     const RoundedBox(
//       width: double.infinity,
//       height: 100.0,
//       borderColor: Colors.orange,
//     ),
//     const RoundedBox(
//       width: double.infinity,
//       height: 200.0,
//       borderColor: Colors.orange,
//     ),
//     const RoundedBox(
//       width: double.infinity,
//       height: 200.0,
//       borderColor: Colors.orange,
//     ),
//     const RoundedBox(
//       width: double.infinity,
//       height: 200.0,
//       borderColor: Colors.orange,
//     ),
//   ];

  @override
  Widget build(BuildContext context) {
    return Text("HOME");
//    SingleChildScrollView(
//       scrollDirection: Axis.vertical,
//       child: Container(
//         margin: const EdgeInsets.fromLTRB(12, 32, 12, 12),
//         child: ConstrainedBox(
//           constraints: BoxConstraints(
//             maxWidth: MediaQuery.of(context).size.width,
//           ),
//           child: Column(
//             children: [
//               Row(
//                 children: [
//                   Expanded(
//                     child: boxes[0],
//                   ),
//                   Expanded(
//                     child: boxes[1],
//                   ),
//                 ],
//               ),
//               Row(
//                 children: [
//                   Expanded(
//                     child: boxes[2],
//                   ),
//                 ],
//               ),
//               Row(
//                 children: [
//                   Expanded(
//                     child: boxes[3],
//                   ),
//                 ],
//               ),
//               Row(
//                 children: [
//                   Expanded(
//                     child: boxes[4],
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
  }
}


// class PerformanceWidget extends StatefulWidget {
//   final String ipAddress;
//   final String username;
//   final String password;

//   PerformanceWidget(
//       {required this.ipAddress,
//       required this.username,
//       required this.password});

//   @override
//   _PerformanceWidgetState createState() => _PerformanceWidgetState();
// }

// class _PerformanceWidgetState extends State<PerformanceWidget> {
//   double _cpuUsage = 0.0;
//   double _memoryUsage = 0.0;

//   @override
//   void initState() {
//     super.initState();
//     Timer.periodic(Duration(seconds: 1), (timer) async {
//       final ssh = SSH(
//         host: widget.ipAddress,
//         username: widget.username,
//         passwordOrKey: widget.password,
//       );

//       await ssh.connect();

//       final cpuUsage = await _getCpuUsage(ssh);
//       final memoryUsage = await _getMemoryUsage(ssh);

//       setState(() {
//         _cpuUsage = cpuUsage;
//         _memoryUsage = memoryUsage;
//       });

//       await ssh.disconnect();
//     });
//   }

//   Future<double> _getCpuUsage(SSH ssh) async {
//     final result = await ssh.execute('top -bn1');
//     final output = result.stdout;
//     final regex = RegExp('Cpu\\(s\\):.+?([0-9.]+) id');
//     final match = regex.firstMatch(output);
//     final cpuUsage = 100.0 - double.parse(match?.group(1) ?? '0');
//     return cpuUsage;
//   }

//   Future<double> _getMemoryUsage(SSH ssh) async {
//     final result = await ssh.execute('free -m');
//     final output = result.stdout;
//     final regex = RegExp('Mem:\\s+\\d+\\s+(\\d+)\\s+(\\d+).+');
//     final match = regex.firstMatch(output);
//     final totalMemory = double.parse(match?.group(1) ?? '0');
//     final usedMemory = double.parse(match?.group(2) ?? '0');
//     final memoryUsage = usedMemory / totalMemory * 100.0;
//     return memoryUsage;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Text('CPU Usage: $_cpuUsage%'),
//         Text('Memory Usage: $_memoryUsage%'),
//       ],
//     );
//   }
// }
