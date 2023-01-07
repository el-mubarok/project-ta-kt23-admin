import 'dart:convert';

import 'package:cryptography/cryptography.dart';
import 'package:platform_device_id/platform_device_id.dart';

class AppHelperDevice {
  Future<String> getDeviceId() async {
    String? deviceId = await PlatformDeviceId.getDeviceId;
    return deviceId ?? "";
  }

  Future<String> getEncodedDeviceId() async {
    final sink = Sha256().newHashSink();
    final deviceId = await getDeviceId();
    // ignore: no_leading_underscores_for_local_identifiers
    final _deviceIdBytes = utf8.encode(deviceId);

    sink.add(_deviceIdBytes);
    sink.close();

    final hash = await sink.hash();
    String hashString = base64Encode(hash.bytes);

    return hashString;
  }
}
