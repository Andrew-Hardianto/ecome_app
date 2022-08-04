import 'dart:math';

import 'package:encrypt/encrypt.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class MainService {
  var key = Key.fromUtf8('1234567890987654');
  var iv = IV.fromUtf8('1234567890987654');
  final storage = new FlutterSecureStorage();
  final _random = new Random();

  var colors = [
    "#FF757D",
    "#52EED2",
    "#FF6996",
    "#1AD4D4",
    "#FF7AB2",
    "#0FEDFB",
    "#FF8933",
    "#3BCAF8",
    "#FFB74A",
    "#3AA1FF",
    "#F8D042",
    "#3969E4",
    "#EED496",
    "#9AAFFB",
    "#DEB792",
    "#C4B6ED",
    "#6AEE8F",
    "#9A7EEC",
    "#0AD98E",
    "#E49FEA"
  ];

  urlApi() {
    final keyJson = storage.read(key: 'SPS!#WU');
    return keyJson;
  }

  encrypt(String plainText) {
    final encrypter = Encrypter(AES(key));

    final encryptedStr = encrypter.encrypt(plainText, iv: iv);
    return encryptedStr.base16.toString();
  }

  decrypt(plainText) {
    final encrypter = Encrypter(AES(key));
    if (plainText != null) {
      final decrypted = encrypter.decrypt16(plainText, iv: iv);
      return decrypted;
    } else {
      return null;
    }
  }

  saveStorage(String key, String value) async {
    await storage.write(key: key, value: value);
  }

  getRandomColor() async {
    final allValues = await storage.read(key: 'G!T@FTR');
    final decr = decrypt(allValues);
    return decr;
  }

  saveRandomColor() {
    final randomColorAvatar = colors[_random.nextInt(colors.length)];
    final color = encrypt(randomColorAvatar);
    return color;
  }
}
