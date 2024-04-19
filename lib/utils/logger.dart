import 'package:flutter/foundation.dart';

/// Custom methods to log efficiently and evidently

void printSuccess(String message) {
  if (kDebugMode) {
    print('\x1B[32m$message\x1B[0m');
  }  // Green for success
}

void printError(String message) {
  if (kDebugMode) {
    print('\x1B[31m$message\x1B[0m');
  }  // Red for error
}


// void printWarning(String message) {
//   if (kDebugMode) {
//     print('\x1B[35m$message\x1B[0m');
//   }  // Red for error
// }

void printInfo(String message) {
  if (kDebugMode) {
    print('\x1B[34m$message\x1B[0m');
  }  // Red for error
}