// import 'package:flutter/material.dart';
// import 'package:flutter_blue/flutter_blue.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class DevicePage extends StatefulWidget {
//   @override
//   _DevicePageState createState() => _DevicePageState();
// }

// class _DevicePageState extends State<DevicePage> {
//   FlutterBlue flutterBlue = FlutterBlue.instance;
//   List<BluetoothDevice> devicesList = [];
//   BluetoothDevice? connectedDevice;
//   BluetoothDevice? selectedDevice;

//   @override
//   void initState() {
//     super.initState();
//     startScan();
//   }

//   void startScan() async {
//     flutterBlue.scanResults.listen((results) {
//       for (ScanResult result in results) {
//         if (!devicesList.contains(result.device)) {
//           setState(() {
//             devicesList.add(result.device);
//           });
//         }
//       }
//     });
//     flutterBlue.startScan(timeout: Duration(seconds: 4));
//   }

//   void connectToDevice(BluetoothDevice device) async {
//     await device.connect();
//     setState(() {
//       connectedDevice = device;
//     });
//     saveDevice(device);
//   }

//   void saveDevice(BluetoothDevice device) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     await prefs.setString('device_name', device.name);
//     await prefs.setString('device_id', device.id.toString());
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back),
//           onPressed: () => Navigator.of(context).pop(),
//         ),
//         title: Text('Device Selection'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             // Logo
//             Padding(
//               padding: const EdgeInsets.only(bottom: 20.0),
//               child: Image.asset(
//                 'assets/logo.jpg', // Replace with your logo image path
//                 height: 100,
//               ),
//             ),
//             // Instruction Text
//             Text(
//               'Which of the following devices do you want the Safar Dua to play when connected: '
//               '(make sure your car or device has Bluetooth or Apple/Android CarPlay)',
//               textAlign: TextAlign.center,
//             ),
//             SizedBox(height: 20),
//             // Device List
//             Expanded(
//               child: ListView.builder(
//                 itemCount: devicesList.length,
//                 itemBuilder: (context, index) {
//                   BluetoothDevice device = devicesList[index];
//                   return ListTile(
//                     title: Text(device.name.isEmpty ? 'Unknown Device' : device.name),
//                     subtitle: Text(device.id.toString()),
//                     onTap: () {
//                       connectToDevice(device);
//                       setState(() {
//                         selectedDevice = device;
//                       });
//                     },
//                     trailing: selectedDevice == device
//                         ? Icon(Icons.check, color: Colors.green)
//                         : null,
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:safar_flutter/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:get/get.dart';
import 'dart:async';
import 'ble_controller.dart';

class DevicePage extends StatefulWidget {
  @override
  _DevicePageState createState() => _DevicePageState();
}

class _DevicePageState extends State<DevicePage> {
  final BleController bleController = Get.put(BleController());
  bool isScanning = false;

  @override
  void initState() {
    super.initState();
    checkAndRequestPermissions();
    _navigateToHome();
  }

    _navigateToHome() async {
    await Future.delayed(Duration(seconds: 5), () {});
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => HomePage()),
    );
  }

  void checkAndRequestPermissions() async {
    if (await Permission.location.serviceStatus.isEnabled) {
      requestPermissions();
    } else {
      await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Location Services Disabled'),
            content: Text('Please enable location services to scan for Bluetooth devices.'),
            actions: [
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  openAppSettings();
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  void requestPermissions() async {
    if (await Permission.bluetooth.isGranted &&
        await Permission.bluetoothScan.isGranted &&
        await Permission.bluetoothConnect.isGranted &&
        await Permission.location.isGranted) {
      startScanning();
    } else {
      Map<Permission, PermissionStatus> statuses = await [
        Permission.bluetooth,
        Permission.bluetoothScan,
        Permission.bluetoothConnect,
        Permission.location
      ].request();

      if (statuses[Permission.bluetooth]!.isGranted &&
          statuses[Permission.bluetoothScan]!.isGranted &&
          statuses[Permission.bluetoothConnect]!.isGranted &&
          statuses[Permission.location]!.isGranted) {
        startScanning();
      } else {
        print("Permissions not granted");
      }
    }
  }

  void startScanning() {
    setState(() {
      isScanning = true;
    });
    bleController.startScan();
    Timer(Duration(seconds: 4), () {
      setState(() {
        isScanning = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text('Device Selection'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: Image.asset(
                'assets/logo.jpg', // Replace with your logo image path
                height: 100,
              ),
            ),
            Text(
              'Which of the following devices do you want the Safar Dua to play when connected: '
              '(make sure your car or device has Bluetooth or Apple/Android CarPlay)',
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            // ElevatedButton(
            //   onPressed: isScanning
            //       ? null
            //       : () {
            //           startScanning();
            //         },
            //   child: Text('Scan for Devices'),
            // ),
            SizedBox(height: 20),
            Expanded(
              child: Obx(
                () => ListView.builder(
                  itemCount: bleController.devicesList.length,
                  itemBuilder: (context, index) {
                    BluetoothDevice device = bleController.devicesList[index];
                    return ListTile(
                      title: Text(device.name?.isNotEmpty == true ? device.name! : 'Unknown Device'),
                      subtitle: Text(device.address),
                      onTap: () {
                        bleController.connectToDevice(device);
                      },
                      trailing: bleController.selectedDevice.value == device
                          ? Icon(Icons.check, color: Colors.green)
                          : null,
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
