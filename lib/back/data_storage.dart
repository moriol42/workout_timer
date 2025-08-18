import 'dart:io';
import 'package:path_provider/path_provider.dart';

class DataStorage {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> _localFile(String filename) async {
    final path = await _localPath;
    return File('$path/$filename');
  }

  Future<String> readData(String filename) async {
    try {
      final file = await _localFile(filename);

      final contents = await file.readAsString();

      return contents;
    } catch (e) {
      return '';
    }
  }

  Future<File> writeData(String filename, String data) async {
    final file = await _localFile(filename);

    return file.writeAsString(data);
  }
}
