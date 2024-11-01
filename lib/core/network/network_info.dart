import 'dart:async';

import 'package:demo_app/core/utils/color_constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

import '../../theme/app_style.dart';

class NetworkInfo extends GetxController {
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  @override
  void onInit() {
    super.onInit();
    // Corrected StreamSubscription initialization
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen((ConnectivityResult result) {
      _updateConnectionStatus(result);
    });
  }

  void _updateConnectionStatus(ConnectivityResult connectivityResult) {
    if (connectivityResult == ConnectivityResult.none) {
      Get.rawSnackbar(
        messageText: Text(
          'PLEASE CONNECT TO THE INTERNET',
          style: AppStyle.txtAllerBold20, // Ensure this exists in your project
        ),
        isDismissible: false,
        duration: const Duration(days: 1),
        backgroundColor:
            ColorConstant.darkRed, // Ensure this exists in your project
        icon: Icon(
          Icons.wifi_off,
          color: ColorConstant.whiteA700,
          size: 35,
        ),
        margin: EdgeInsets.zero,
        snackStyle: SnackStyle.GROUNDED,
      );
    } else {
      if (Get.isSnackbarOpen) {
        Get.closeCurrentSnackbar();
      }
    }
  }

  @override
  void onClose() {
    // Cancel the subscription to avoid memory leaks
    _connectivitySubscription.cancel();
    super.onClose();
  }
}
