// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:file/memory.dart';
import 'package:flutter_tools/src/base/file_system.dart';
import 'package:flutter_tools/src/base/logger.dart';
import 'package:flutter_tools/src/base/process.dart';
import 'package:flutter_tools/src/base/user_messages.dart';
import 'package:flutter_tools/src/convert.dart';
import 'package:flutter_tools/src/globals.dart';
import 'package:flutter_tools/src/ohos/application_package.dart';
import 'package:flutter_tools/src/project.dart';
import 'package:test/fake.dart';
import 'package:test/test.dart';

void main() {
  group('OhosBuildData', () {
    late FileSystem fileSystem;

    setUp(() {
      fileSystem = MemoryFileSystem.test();
    });

    test('parseOhosBuildData should parse build-profile.json5 correctly',
        () async {
      const String projectPath = 'test/project';
      final FakeLogger logger = FakeLogger();

      final OhosProject ohosProject = FakeFlutterProject();

      final FakeUserMessages userMessages = FakeUserMessages();
      final FakeProcessUtils processUtils = FakeProcessUtils();

      OhosHap? hap = await OhosHap.fromOhosProject(ohosProject,
          ohosSdk: ohosSdk,
          processManager: processManager,
          userMessages: userMessages,
          processUtils: processUtils,
          logger: logger,
          fileSystem: fileSystem);
      expect(hap, isNotNull);
    });
  });
}

class FakeFlutterProject extends Fake implements OhosProject {
  @override
  File getBuildProfileFile() {
    return FakeFile('path');
  }

  @override
  File getSignedHapFile(String flavor) {
    return FakeFile('path');
  }

  @override
  Directory get ohosRoot {
    final MemoryFileSystem fs = MemoryFileSystem.test();
    final Directory directory = fs.currentDirectory.childDirectory('app');
    return directory;
  }

  @override
  File getAppJsonFile() {
    return FakeFile('');
  }

  @override
  OhosBuildData get ohosBuildData {
    final List<String> modulePaths = [
      '/path/to/module1',
      '/path/to/module2',
      '/path/to/module3',
    ];
    List<OhosModule> modulesList = [];
    for (String modulePath in modulePaths) {
      modulesList.add(OhosModule.fromModulePath(modulePath: modulePath));
    }

    return OhosBuildData(
      AppInfo('com.example.myapp', 1, '1.0'),
      ModuleInfo(modulesList),
      0,
      [],
    );
  }
}

class FakeFile extends Fake implements File {
  FakeFile(this.path);

  @override
  final String path;

  @override
  bool existsSync() {
    return false;
  }

  @override
  String readAsStringSync({Encoding encoding = utf8ForTesting}) {
    throw const FileSystemException('', '', OSError('', 13));
  }
}

class FakeUserMessages extends Fake implements UserMessages {}

class FakeProcessUtils extends Fake implements ProcessUtils {}

class FakeLogger extends Fake implements Logger {}
