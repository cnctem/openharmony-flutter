// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

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