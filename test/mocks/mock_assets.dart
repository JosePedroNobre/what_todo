import 'dart:convert';
import 'dart:developer';

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/services.dart' show rootBundle;

Future<dynamic> loadStub(String filename) async {
  try {
    TestWidgetsFlutterBinding.ensureInitialized();

    String fileContent = await rootBundle.loadString('test/stubs/$filename.json');
    return json.decode(fileContent);
  } catch (e) {
    log('[TEST] Failure loading asset: ${e.toString()}}');
    rethrow;
  }
}
