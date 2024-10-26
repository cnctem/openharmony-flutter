// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:file/memory.dart';
import 'package:flutter_tools/src/base/config.dart';
import 'package:flutter_tools/src/base/file_system.dart';
import 'package:flutter_tools/src/globals.dart' as globals;
import 'package:flutter_tools/src/ohos/ohos_sdk.dart';
import 'package:json5/json5.dart';

import '../../src/common.dart';
import '../../src/context.dart';

void main() {
  late MemoryFileSystem fileSystem;
  late Config config;

  setUp(() {
    fileSystem = MemoryFileSystem.test();
    config = Config.test();
  });

  group('HmosSdk', () {
    testUsingContext('parse hmos sdk', () {
      final Directory sdkDir = createHmosSdkDirectory(fileSystem: fileSystem);
      config.setValue('ohos-sdk', sdkDir.path);
      final HmosSdk sdk = HmosSdk.localHmosSdk()!;

      expect(sdk.apiAvailable, isNotNull);
      expect(sdk.apiAvailable, <String>['12:default']);
    }, overrides: <Type, Generator>{
      FileSystem: () => fileSystem,
      ProcessManager: () => FakeProcessManager.any(),
      Config: () => config,
    });

    testUsingContext('get hdc path', () {
      final Directory sdkDir = createHmosSdkDirectory(fileSystem: fileSystem);
      config.setValue('ohos-sdk', sdkDir.path);
      final HmosSdk sdk = HmosSdk.localHmosSdk()!;

      expect(sdk.hdcPath, isNotNull);
    }, overrides: <Type, Generator>{
      FileSystem: () => fileSystem,
      ProcessManager: () => FakeProcessManager.any(),
      Config: () => config,
    });

    testUsingContext('valid directory', () {
      final Directory sdkDir = createHmosSdkDirectory(fileSystem: fileSystem);
      config.setValue('ohos-sdk', sdkDir.path);
      final HmosSdk sdk = HmosSdk.localHmosSdk()!;

      expect(sdk.isValidDirectory, isTrue);
    }, overrides: <Type, Generator>{
      FileSystem: () => fileSystem,
      ProcessManager: () => FakeProcessManager.any(),
      Config: () => config,
    });
  });

  group('OhosSdk', () {
    testUsingContext('parse ohos sdk', () {
      final Directory sdkDir = createSdkDirectory(fileSystem: fileSystem);
      config.setValue('ohos-sdk', sdkDir.path);
      final OhosSdk sdk = OhosSdk.localOhosSdk()!;

      expect(sdk.apiAvailable, isNotNull);
      expect(sdk.apiAvailable, <String>['12:12', '10:10']);
    }, overrides: <Type, Generator>{
      FileSystem: () => fileSystem,
      ProcessManager: () => FakeProcessManager.any(),
      Config: () => config,
    });

    testUsingContext('get hdc path', () {
      final Directory sdkDir = createSdkDirectory(fileSystem: fileSystem);
      config.setValue('ohos-sdk', sdkDir.path);
      final OhosSdk sdk = OhosSdk.localOhosSdk()!;

      expect(sdk.hdcPath, isNotNull);
    }, overrides: <Type, Generator>{
      FileSystem: () => fileSystem,
      ProcessManager: () => FakeProcessManager.any(),
      Config: () => config,
    });

    testUsingContext('valid directory', () {
      final Directory sdkDir = createSdkDirectory(fileSystem: fileSystem);
      config.setValue('ohos-sdk', sdkDir.path);
      final OhosSdk sdk = OhosSdk.localOhosSdk()!;

      expect(sdk.isValidDirectory, isTrue);
    }, overrides: <Type, Generator>{
      FileSystem: () => fileSystem,
      ProcessManager: () => FakeProcessManager.any(),
      Config: () => config,
    });
  });

  test('isNumeric', () {
    expect(HarmonySdk.isNumeric('12'), isTrue);
  });
}

void _createSdkFile(Directory dir, String filePath, {String? contents}) {
  final File file = dir.childFile(filePath);
  file.createSync(recursive: true);
  if (contents != null) {
    file.writeAsStringSync(contents, flush: true);
  }
}

Directory createHmosSdkDirectory({
  required FileSystem fileSystem,
}) {
  final Directory dir =
      fileSystem.systemTempDirectory.createTempSync('flutter_mock_ohos_sdk.');
  final String exe = globals.platform.isWindows ? '.exe' : '';

  void createDir(Directory dir, String path) {
    final Directory directory =
        dir.fileSystem.directory(dir.fileSystem.path.join(dir.path, path));
    directory.createSync(recursive: true);
  }

  createDir(dir, 'default/hms');
  final Map<String, dynamic> sdkPkg = <String, dynamic>{};
  final Map<String, dynamic> dataObj = <String, dynamic>{};
  dataObj['version'] = '5.0.0.68';
  dataObj['apiVersion'] = '12';
  sdkPkg['data'] = dataObj;
  final String jsonData = JSON5.stringify(sdkPkg);
  _createSdkFile(dir, 'default/sdk-pkg.json', contents: jsonData);
  _createSdkFile(dir, 'default/openharmony/toolchains/hdc$exe');
  return dir;
}

Directory createSdkDirectory({
  bool withLicenses = false,
  required FileSystem fileSystem,
}) {
  final Directory dir =
      fileSystem.systemTempDirectory.createTempSync('flutter_mock_ohos_sdk.');
  final String exe = globals.platform.isWindows ? '.exe' : '';

  void createDir(Directory dir, String path) {
    final Directory directory =
        dir.fileSystem.directory(dir.fileSystem.path.join(dir.path, path));
    directory.createSync(recursive: true);
  }

  if (withLicenses) {
    createDir(dir, 'licenses');
  }
  createDir(dir, '10');
  createDir(dir, '12');
  _createSdkFile(dir, '10/toolchains/hdc$exe');
  _createSdkFile(dir, '12/toolchains/hdc$exe');
  return dir;
}
