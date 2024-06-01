import 'package:permission_handler/permission_handler.dart';

Future<void> checkAndRequestExactAlarmPermission() async {
  // Check if the exact alarm permission is granted
  if (await Permission.systemAlertWindow.isGranted) {
    // Permission is granted, you can schedule the notification
    return;
  } else {
    // Permission is not granted, show a dialog or direct the user to the settings
    bool isPermanentlyDenied = await Permission.systemAlertWindow.isPermanentlyDenied;
    if (isPermanentlyDenied) {
      // Direct the user to the settings
      openAppSettings();
    } else {
      // Request the permission
      PermissionStatus status = await Permission.systemAlertWindow.request();
      if (status.isGranted) {
        // Permission is granted, you can schedule the notification
      } else {
        // Handle the case when the permission is denied
        // Show an alert to the user, etc.
      }
    }
  }
}
