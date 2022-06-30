import 'dart:io';
import 'parser_extension.dart';

//*****************************************************************************/
//                   CLASSE PARA MANIPULAR O ARQUIVO .env
//*****************************************************************************/

class CustomEnv {
  static Map<String, String> _map = {};
  static String _file = '.env';

  CustomEnv._();

  factory CustomEnv.fromFile(String file) {
    _file = file;
    return CustomEnv._();
  }

  static Future<T> get<T>({required String key}) async {
    if (_map.isEmpty) await _load();
    return _map[key]!.toType(T);
  }

  // Faz o processamento do arquivo .env
  static Future<void> _load() async {
    //quebra o arquivo em linhas e atribui numa lista
    List<String> linhas =
        (await _readFile()).replaceAll(String.fromCharCode(13), '').split("\n");

    _map = {for (var l in linhas) l.split('=')[0]: l.split('=')[1]};
  }

  // Faz a leitura do arquivo .env
  static Future<String> _readFile() async {
    return await File(_file).readAsString();
  }
}
