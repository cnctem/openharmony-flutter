import 'dart:convert';
import 'dart:io';

import 'package:file/file.dart';
import 'package:file/memory.dart';
import 'package:flutter_tools/src/base/process.dart';
import 'package:flutter_tools/src/build_info.dart';
import 'package:flutter_tools/src/flutter_manifest.dart';
import 'package:flutter_tools/src/ohos/hvigor.dart';
import 'package:flutter_tools/src/project.dart';
import 'package:test/fake.dart';

import '../../src/common.dart';


void main() {

  late FileSystem fs;
  late FakeFlutterProject flutterProject;
  late FakeFlutterManifest flutterManifest;

  setUp(() async {
    fs = MemoryFileSystem.test();
    final Directory directory = fs.currentDirectory.childDirectory('app');
    flutterManifest = FakeFlutterManifest();
    flutterProject = FakeFlutterProject()
      ..manifest = flutterManifest
      ..directory = directory
      ..flutterPluginsFile = directory.childFile('.flutter-plugins')
      ..flutterPluginsDependenciesFile = directory.childFile('.flutter-plugins-dependencies')
      ..ohos = FakeOhosProject(directory)
      ..dartPluginRegistrant = directory.childFile('dart_plugin_registrant.dart');
    flutterProject.directory.childFile('.packages').createSync(recursive: true);
  });


  group('hvigor_test', () {
    test('getProjectAssetsPath', () {
      final String result = getProjectAssetsPath('test',flutterProject.ohos);
      expect(result, endsWith('flutter_assets'));
    });

    test('getDatPath', () {
      final String result = getDatPath('test',flutterProject.ohos);
      expect(result, endsWith('icudtl.dat'));
    });

    test('getAppSoPath', () {
      final String result = getAppSoPath('test',OhosArch.arm64_v8a,flutterProject.ohos);
      expect(result, endsWith('libapp.so'));
    });

    test('getHvigorwPath', () {
      final String result = getHvigorwPath('test');
      expect(result, 'hvigorw');
    });

    test('getAbsolutePath', () {
      final String result = getAbsolutePath(flutterProject,'test');
      expect(result, endsWith('test'));
    });

    test('hvigorwTask', () async {
      final int result = await hvigorwTask(<String>[''], processUtils: FakeProcessUtils(), workPath: 'workPath', hvigorwPath: 'hvigorwPath',);
      expect(result, 0);
    });

    test('assembleHap', () async {
      final int result = await assembleHap(processUtils: FakeProcessUtils(), ohosRootPath: 'ohosRootPath', hvigorwPath: 'hvigorwPath', flavor: 'flavor', buildMode: 'buildMode',);
      expect(result, 0);
    });

    test('assembleApp', () async {
      final int result = await assembleApp(processUtils: FakeProcessUtils(), ohosRootPath: 'ohosRootPath', hvigorwPath: 'hvigorwPath', flavor: 'flavor', buildMode: 'buildMode',);
      expect(result, 0);
    });
  });
}

class FakeProcessUtils extends Fake implements ProcessUtils {

  @override
  RunResult runSync(List<String> cmd, {bool throwOnError = false, bool verboseExceptions = false, RunResultChecker? allowedFailures, bool hideStdout = false, String? workingDirectory, Map<String, String>? environment, bool allowReentrantFlutter = false, Encoding encoding = systemEncoding}) {
    final RunResult runResult = RunResult(ProcessResult(0,0,'1','1'), cmd);
    return runResult;
  }
}

class FakeOhosProject extends Fake implements OhosProject{
  FakeOhosProject(this.directory);

  Directory directory;

  @override
  Directory get flutterModuleDirectory => directory;
}

class FakeFlutterManifest extends Fake implements FlutterManifest {
  @override
  Set<String> dependencies = <String>{};
}

class FakeFlutterProject extends Fake implements FlutterProject {
  @override
  bool isModule = false;

  @override
  late FlutterManifest manifest;

  @override
  late Directory directory;

  @override
  late File flutterPluginsFile;

  @override
  late File flutterPluginsDependenciesFile;

  @override
  late File dartPluginRegistrant;

  @override
  late IosProject ios;

  @override
  late AndroidProject android;

  @override
  late WebProject web;

  @override
  late MacOSProject macos;

  @override
  late LinuxProject linux;

  @override
  late OhosProject ohos;

  @override
  late WindowsProject windows;
}
