import 'dart:async';
import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityService {
  final BuildContext context;
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  bool _isDialogShowing = false;

  ConnectivityService(this.context) {
    _connectivitySubscription = Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      _updateConnectionStatus(result);
    });
    _checkConnectivity();
  }

  void dispose() {
    _connectivitySubscription.cancel();
  }

  Future<void> _checkConnectivity() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    _updateConnectionStatus(connectivityResult);
  }

  void _updateConnectionStatus(ConnectivityResult result) {
    if (result == ConnectivityResult.none && !_isDialogShowing) {
      _showConnectionDialog();
    } else if (result != ConnectivityResult.none && _isDialogShowing) {
      Navigator.of(context, rootNavigator: true).pop();
      _isDialogShowing = false;
    }
  }

  void _showConnectionDialog() {
    _isDialogShowing = true;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("No Internet Connection"),
          content: Text("Please check your internet connection and try again."),
          actions: <Widget>[
            TextButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
                _isDialogShowing = false;
              },
            ),
          ],
        );
      },
    );
  }

  void _showConnectionSnackbar() {
    _isDialogShowing = true;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("No Internet Connection. Please check your internet connection."),
        duration: Duration(days: 1), // Make it last indefinitely
        action: SnackBarAction(
          label: 'OK',
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            _isDialogShowing = false;
          },
        ),
      ),
    );
  }
}
