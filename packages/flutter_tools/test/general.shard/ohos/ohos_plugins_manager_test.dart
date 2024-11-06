// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:file/memory.dart';
import 'package:flutter_tools/src/base/file_system.dart';
import 'package:flutter_tools/src/project.dart';
import 'package:json5/json5.dart';
import 'package:test/fake.dart';

import '../../src/common.dart';
import '../../src/context.dart';

void main() {
  late MemoryFileSystem fileSystem;

  setUp(() {
    fileSystem = MemoryFileSystem.test();
  });

  testUsingContext('checkOhosPluginsDependencies', () async {
    final Directory dir = createDirectory(fileSystem: fileSystem);
    await checkOhosPluginsDependencies(dir, fileSystem);
    File packageFile = dir.childFile('ohos/oh-package.json5');
    final String packageConfig = packageFile.readAsStringSync();
    final Map<String, dynamic> config =
        JSON5.parse(packageConfig) as Map<String, dynamic>;
    final Map<String, dynamic> dependenciesData =
        config['dependencies'] as Map<String, dynamic>;
    expect('file:./har/fluttertest.har', dependenciesData['fluttertest']);
  }, overrides: <Type, Generator>{
    FileSystem: () => fileSystem,
    ProcessManager: () => FakeProcessManager.any(),
  });

  testUsingContext('addPluginsModules', () async {
    final Directory dir = createDirectory(fileSystem: fileSystem);
    await addPluginsModules(dir, fileSystem);
    File buildFile = dir.childFile('ohos/build-profile.json5');
    final String buildConfig = buildFile.readAsStringSync();
    final Map<String, dynamic> config =
        JSON5.parse(buildConfig) as Map<String, dynamic>;
    final Map<String, dynamic> targetsData =
        config['modules']['targets'] as Map<String, dynamic>;
    expect('entry', config['modules']['name']);
    expect('./entry', config['modules']['srcPath']);
    expect('default', targetsData['name']);
    expect(['default'], targetsData['applyToProducts']);
  }, overrides: <Type, Generator>{
    FileSystem: () => fileSystem,
    ProcessManager: () => FakeProcessManager.any(),
  });

  testUsingContext('addFlutterModuleAndPluginsSrcOverrides', () async {
    final Directory dir = createDirectory(fileSystem: fileSystem);
    await addFlutterModuleAndPluginsSrcOverrides(dir, fileSystem);
    File packageFile = dir.childFile('ohos/oh-package.json5');
    final String packageConfig = packageFile.readAsStringSync();
    final Map<String, dynamic> config =
        JSON5.parse(packageConfig) as Map<String, dynamic>;
    final Map<String, dynamic> overridesData =
        config['overrides'] as Map<String, dynamic>;
    expect('file:./har/fluttertest.har', overridesData['ohos/flutter_test']);
  }, overrides: <Type, Generator>{
    FileSystem: () => fileSystem,
    ProcessManager: () => FakeProcessManager.any(),
  });
}

class FakeFlutterProject extends Fake implements FlutterProject {}

Future<void> checkOhosPluginsDependencies(
    Directory directory, MemoryFileSystem fileSystem) async {
  createDir(directory, 'ohos');
  final Map<String, dynamic> dataObj = <String, dynamic>{};
  final Map<String, dynamic> dependenciesData = <String, dynamic>{};
  dependenciesData['fluttertest'] = 'file:./har/fluttertest.har';
  dataObj['dependencies'] = dependenciesData;
  final String jsonData = JSON5.stringify(dataObj);
  createFile(directory, 'ohos/oh-package.json5', contents: jsonData);
}

Future<void> addPluginsModules(
    Directory directory, MemoryFileSystem fileSystem) async {
  createDir(directory, 'ohos');
  final Map<String, dynamic> dataObj = <String, dynamic>{};
  final Map<String, dynamic> modulesData = <String, dynamic>{};
  final Map<String, dynamic> tempObj = <String, dynamic>{};
  tempObj['name'] = 'default';
  tempObj['applyToProducts'] = ['default'];
  modulesData['name'] = 'entry';
  modulesData['srcPath'] = './entry';
  modulesData['targets'] = tempObj;
  dataObj['modules'] = modulesData;
  final String jsonData = JSON5.stringify(dataObj);
  createFile(directory, 'ohos/build-profile.json5', contents: jsonData);
}

Future<void> addFlutterModuleAndPluginsSrcOverrides(
    Directory directory, MemoryFileSystem fileSystem) async {
  createDir(directory, 'ohos');
  final Map<String, dynamic> dataObj = <String, dynamic>{};
  final Map<String, dynamic> overridesData = <String, dynamic>{};
  overridesData['ohos/flutter_test'] = 'file:./har/fluttertest.har';
  dataObj['overrides'] = overridesData;
  final String jsonData = JSON5.stringify(dataObj);
  createFile(directory, 'ohos/oh-package.json5', contents: jsonData);
}

void createFile(Directory dir, String filePath, {String? contents}) {
  final File file = dir.childFile(filePath);
  file.createSync(recursive: true);
  if (contents != null) {
    file.writeAsStringSync(contents, flush: true);
  }
}

void createDir(Directory dir, String path) {
  final Directory directory =
      dir.fileSystem.directory(dir.fileSystem.path.join(dir.path, path));
  directory.createSync(recursive: true);
}

Directory createDirectory({
  required FileSystem fileSystem,
}) {
  final Directory dir =
      fileSystem.systemTempDirectory.createTempSync('flutter_mock.');
  return dir;
}
