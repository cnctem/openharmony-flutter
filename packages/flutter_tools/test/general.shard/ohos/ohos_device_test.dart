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

import 'package:flutter_tools/src/application_package.dart';
import 'package:flutter_tools/src/ohos/ohos_device.dart';
import 'package:test/fake.dart';
import 'package:test/test.dart';

void main() {
  group('OhosBuildData', () {
    late FakeOhosDevice ohosDevice;
    late FakeApplicationPackage applicationPackage;

    setUp(() {
      ohosDevice = FakeOhosDevice();
      applicationPackage = FakeApplicationPackage();
    });

    test('ohosDevice isAppInstalled', () async {
      expect(await ohosDevice.isAppInstalled(applicationPackage), isNotNull);
    });

    test('ohosDevice stopApp', () async {
      expect(await ohosDevice.stopApp(applicationPackage), isNotNull);
    });

    test('ohosDevice installApp', () async {
      expect(await ohosDevice.installApp(applicationPackage), isNotNull);
    });

    test('ohosDevice uninstallApp', () async {
      expect(await ohosDevice.uninstallApp(applicationPackage), isNotNull);
    });
  });
}

class FakeOhosDevice extends Fake implements OhosDevice {
  @override
  Future<bool> isAppInstalled(covariant ApplicationPackage app,
      {String? userIdentifier}) async {
    return true;
  }

  @override
  Future<bool> stopApp(covariant ApplicationPackage? app,
      {String? userIdentifier}) async {
    return false;
  }

  @override
  Future<bool> installApp(covariant ApplicationPackage app,
      {String? userIdentifier}) async {
    return true;
  }

  @override
  Future<bool> uninstallApp(covariant ApplicationPackage app,
      {String? userIdentifier}) async {
    return false;
  }
}

class FakeApplicationPackage extends Fake implements ApplicationPackage {}