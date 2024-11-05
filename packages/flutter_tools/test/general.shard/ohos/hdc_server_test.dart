import 'package:flutter_tools/src/ohos/hdc_server.dart';
import 'package:flutter_tools/src/ohos/ohos_sdk.dart';
import 'package:test/fake.dart';

import '../../src/common.dart';

void main() {
  group('hdc_server', () {
    test('getHdcServer', () {
      final String? result = getHdcServer();
      expect(result, null);
    });

    test('getHdcServerHost', () {
      final String? result = getHdcServerHost();
      expect(result, null);
    });

    test('getHdcServerPort', () {
      final String? result = getHdcServerPort();
      expect(result, '65037');
    });

    test('getHdcCommandCompat', () {
      final FakeOhosSdk sdk = FakeOhosSdk();
      final List<String> result = getHdcCommandCompat(sdk, '0', <String>['0']);
      expect(result, ['hdcPath', '-t', '0', '0']);
    });
  });
}

class FakeOhosSdk extends Fake implements HarmonySdk {
  @override
  String? get hdcPath => 'hdcPath';
}
