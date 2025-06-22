import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ussd_advanced/ussd_advanced.dart';

void main() {
  const MethodChannel channel = MethodChannel(
    'method.com.phan_tech/ussd_advanced',
  );

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, (MethodCall methodCall) async {
          return 'Your account is';
        });
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, null);
  });

  test('getPlatformVersion', () async {
    expect(
      await UssdAdvanced.sendAdvancedUssd(code: "*100#"),
      'Your account is',
    );
  });
}
