// import 'package:flutter_blue/flutter_blue.dart';
// import 'package:get/get.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class BleController extends GetxController {
//   final FlutterBlue flutterBlue = FlutterBlue.instance;
//   var devicesList = <BluetoothDevice>[].obs;
//   var connectedDevice = Rx<BluetoothDevice?>(null);
//   var selectedDevice = Rx<BluetoothDevice?>(null);

//   @override
//   void onInit() {
//     super.onInit();
//     startScan();
//   }

//   @override
//   void onClose() {
//     flutterBlue.stopScan();
//     super.onClose();
//   }

//   void startScan() {
//     flutterBlue.scanResults.listen((results) {
//       for (ScanResult result in results) {
//         if (!devicesList.contains(result.device)) {
//           devicesList.add(result.device);
//         }
//       }
//     }).onError((error) {
//       // Handle scan error here
//       print("Scan error: $error");
//     });
//     flutterBlue.startScan(timeout: Duration(seconds: 4)).catchError((error) {
//       // Handle start scan error here
//       print("Start scan error: $error");
//     });
//   }

//   Future<void> connectToDevice(BluetoothDevice device) async {
//     try {
//       await device.connect(timeout: Duration(seconds: 10));
//       connectedDevice.value = device;
//       selectedDevice.value = device;
//       saveDevice(device);
//     } catch (e) {
//       // Handle connection error here
//       print("Connection error: $e");
//     }
//   }

//   void saveDevice(BluetoothDevice device) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     await prefs.setString('device_name', device.name);
//     await prefs.setString('device_id', device.id.toString());
//   }
// }

import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BleController extends GetxController {
  final FlutterBluetoothSerial flutterBluetoothSerial = FlutterBluetoothSerial.instance;
  var devicesList = <BluetoothDevice>[].obs;
  var connectedDevice = Rx<BluetoothDevice?>(null);
  var selectedDevice = Rx<BluetoothDevice?>(null);

  @override
  void onInit() {
    super.onInit();
    flutterBluetoothSerial.onStateChanged().listen((BluetoothState state) {
      if (state == BluetoothState.STATE_OFF) {
        flutterBluetoothSerial.requestEnable();
      }
    });
  }

  @override
  void onClose() {
    disconnectDevice();
    super.onClose();
  }

  void startScan() async {
    devicesList.clear();
    try {
      List<BluetoothDevice> devices = await flutterBluetoothSerial.getBondedDevices();
      devicesList.addAll(devices);
    } catch (e) {
      print("Error in scanning: $e");
    }
  }

  void stopScan() {
    // No need to stop scan as getBondedDevices is a one-time call
  }

  Future<void> connectToDevice(BluetoothDevice device) async {
    try {
      await flutterBluetoothSerial.connect(device).timeout(Duration(seconds: 10));
      connectedDevice.value = device;
      selectedDevice.value = device;
      saveDevice(device);
    } catch (e) {
      print("Connection error: $e");
    }
  }

  void disconnectDevice() async {
    if (connectedDevice.value != null) {
      await flutterBluetoothSerial.disconnect();
      connectedDevice.value = null;
      selectedDevice.value = null;
    }
  }

  void saveDevice(BluetoothDevice device) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('device_name', device.name ?? 'Unknown Device');
    await prefs.setString('device_id', device.address);
  }
}
