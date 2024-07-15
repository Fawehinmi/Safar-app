import 'package:flutter/material.dart';

class PermissionsPage extends StatefulWidget {
  final String name;

  PermissionsPage({required this.name});

  @override
  _PermissionsPageState createState() => _PermissionsPageState();
}

class _PermissionsPageState extends State<PermissionsPage> {
  bool bluetoothChecked = false;
  bool backgroundActivityChecked = false;
  bool audioControlChecked = false;
  bool notificationsChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo
            Image.asset(
              'assets/logo.jpg', // Your logo image path
              height: 200,
            ),

            SizedBox(height: 20),

            // Welcome Text
            Text(
              'Welcome ${widget.name}',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: Color(0xFF000000), // Black color
              ),
              textAlign: TextAlign.center,
            ),

            SizedBox(height: 10),

            // Instruction Text with horizontal padding
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: Text(
                'To give the best service we need permission of the following:',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 14,
                  color: Color(0xFF000000), // Black color
                  fontWeight: FontWeight.bold
                ),
              ),
            ),

            // Divider with horizontal padding
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
              child: Divider(height: 40, thickness: 3, color: Color(0xFF000000)),
            ),

            // Permissions List with Dots and icons aligned with the first line of text
            _buildPermissionItem(
              icon: Icons.bluetooth,
              text: 'Bluetooth to connect to your car',
            ),
            _buildPermissionItem(
              icon: Icons.settings,
              text: 'Background activity to connect to your car without having to open the app',
            ),
            _buildPermissionItem(
              icon: Icons.volume_up,
              text: 'Audio control to adjust audio',
            ),
            _buildPermissionItem(
              icon: Icons.notifications,
              text: 'Notifications to notify you with any update',
            ),

            SizedBox(height: 40),

            // Simple Black Continue Button with White Text
            ElevatedButton(
              onPressed: _checkPermissions,
              child: Text('CONTINUE'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF000000), // Black color for button background
                foregroundColor: Color(0xFFFFFFFF), // White color for button text
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
              ),
            ),
          ],
        ),
      ),
    );
  }

Widget _buildPermissionItem({
  required IconData icon,
  required String text,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 18.0, horizontal: 15), // Margin between each title
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: Color(0xFF000000)), // Black color for icons
        SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 6,
                    height: 6,
                    margin: EdgeInsets.only(right: 10),
                    decoration: BoxDecoration(
                      color: Color(0xFF000000), // Black color for dots
                      shape: BoxShape.circle,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      text,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 14,
                        color: Color(0xFF000000), // Black color for text
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

  void _checkPermissions() {
    List<String> declinedPermissions = [];

    if (!bluetoothChecked) declinedPermissions.add('Bluetooth');
    if (!backgroundActivityChecked) declinedPermissions.add('Background activity');
    if (!audioControlChecked) declinedPermissions.add('Audio control');
    if (!notificationsChecked) declinedPermissions.add('Notifications');

    // if (declinedPermissions.isNotEmpty) {
    //   String message = 'Please accept ${declinedPermissions.join(', ')} permission${declinedPermissions.length > 1 ? 's' : ''} so the app can function properly.';

    //   showDialog(
    //     context: context,
    //     builder: (context) => AlertDialog(
    //       title: Text('Permissions Required'),
    //       content: Text(message),
    //       actions: [
    //         TextButton(
    //           onPressed: () => Navigator.of(context).pop(),
    //           child: Text('OK'),
    //         ),
    //       ],
    //     ),
    //   );
    // } else {
    //   // Proceed to the next page
    //   Navigator.pushReplacementNamed(context, '/home');
    // }

          Navigator.pushReplacementNamed(context, '/device');

  }
}
