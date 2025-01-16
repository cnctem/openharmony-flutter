/*
 * Copyright (C) 2024 Huawei Device Co., Ltd.
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

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
