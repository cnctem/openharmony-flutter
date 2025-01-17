/*
 * Copyright 2014 The Flutter Authors. All rights reserved.
 * Use of this source code is governed by a BSD-style license that can be
 * found in the LICENSE file.
 */

import 'package:args/command_runner.dart';
import 'package:flutter_tools/src/base/file_system.dart';
import 'package:flutter_tools/src/base/logger.dart';
import 'package:flutter_tools/src/build_info.dart';
import 'package:flutter_tools/src/cache.dart';
import 'package:flutter_tools/src/commands/build_hsp.dart';
import 'package:flutter_tools/src/globals.dart' as globals;
import 'package:flutter_tools/src/ohos/ohos_builder.dart';
import 'package:flutter_tools/src/ohos/ohos_sdk.dart';
import 'package:flutter_tools/src/project.dart';
import 'package:flutter_tools/src/reporting/reporting.dart';
import 'package:test/fake.dart';

import '../../src/common.dart';
import '../../src/context.dart';
import '../../src/test_flutter_command_runner.dart';

void main() {
  Cache.disableLocking();

  Future<BuildHspCommand> runCommandIn(String target,
      {List<String>? arguments}) async {
    final BuildHspCommand command = BuildHspCommand(
      logger: BufferLogger.test(),
      verboseHelp: false,
    );
    final CommandRunner<void> runner = createTestCommandRunner(command);
    await runner.run(<String>[
      'hsp',
      '--no-pub',
      ...?arguments,
      globals.fs.path.join(target, 'lib', 'main.dart'),
    ]);
    return command;
  }

  group('Usage', () {
    late Directory tempDir;
    late TestUsage testUsage;

    setUp(() {
      testUsage = TestUsage();
      tempDir = globals.fs.systemTempDirectory
          .createTempSync('flutter_tools_packages_test.');
    });

    tearDown(() {
      tryToDelete(tempDir);
    });

    testUsingContext('indicate the ReportNullSafety attribute of the project', () async {
      final String projectPath = await createProject(tempDir,
          arguments: <String>['--no-pub', '--template=module']);

      final BuildHspCommand command = await runCommandIn(projectPath);
      expect((await command.name), 'hsp');
    }, overrides: <Type, Generator>{
      OhosBuilder: () => FakeOhosBuilder(),
    });

    testUsingContext('indicate the supported attribute of the project', () async {
      final String projectPath = await createProject(tempDir,
          arguments: <String>[
            '--no-pub',
            '--template=module',
            '--project-name=hsp_test'
          ]);

      final BuildHspCommand command = await runCommandIn(projectPath);
      expect((await command.name), 'hsp');
    }, overrides: <Type, Generator>{
      OhosBuilder: () => FakeOhosBuilder(),
    });

    testUsingContext('indicate the project name attribute', () async {
      final String projectPath = await createProject(tempDir,
          arguments: <String>['--no-pub', '--template=module']);

      final BuildHspCommand command = await runCommandIn(projectPath,
          arguments: <String>['--target-platform=ohos-arm']);
      expect((await command.name), 'hsp');
    }, overrides: <Type, Generator>{
      OhosBuilder: () => FakeOhosBuilder(),
    });

    testUsingContext('logs success', () async {
      final String projectPath =
          await createProject(tempDir, arguments: <String>['--no-pub']);

      await runCommandIn(projectPath,
          arguments: <String>['--target-platform=ohos-arm']);

      expect(
          testUsage.events,
          contains(
            const TestUsageEvent(
              'tool-command-result',
              'hsp',
              label: 'success',
            ),
          ));
    }, overrides: <Type, Generator>{
      OhosBuilder: () => FakeOhosBuilder(),
      Usage: () => testUsage,
    });
  });

  group('flag parsing', () {
    late Directory tempDir;
    late FakeOhosBuilder fakeOhosBuilder;

    setUp(() {
      fakeOhosBuilder = FakeOhosBuilder();
      tempDir = globals.fs.systemTempDirectory
          .createTempSync('flutter_tools_build_hsp_test.');
    });

    tearDown(() {
      tryToDelete(tempDir);
    });

    testUsingContext('defaults', () async {
      final String projectPath =
          await createProject(tempDir, arguments: <String>['--no-pub']);
      await runCommandIn(projectPath);

      final List<BuildMode> buildModes = <BuildMode>[];

      final BuildInfo buildInfo = fakeOhosBuilder.ohosBuildInfo.buildInfo;
      buildModes.add(buildInfo.mode);
      if (buildInfo.mode.isPrecompiled) {
        expect(buildInfo.treeShakeIcons, isTrue);
        expect(buildInfo.trackWidgetCreation, isTrue);
      } else {
        expect(buildInfo.treeShakeIcons, isFalse);
        expect(buildInfo.trackWidgetCreation, isTrue);
      }
      expect(buildInfo.flavor, isNull);
      expect(buildInfo.splitDebugInfoPath, isNull);
      expect(buildInfo.dartObfuscation, isFalse);
      expect(fakeOhosBuilder.ohosBuildInfo.targetArchs,
          <OhosArch>[OhosArch.arm64_v8a]);

      expect(buildModes.length, 1);
      expect(buildModes, containsAll(<BuildMode>[BuildMode.release]));
    }, overrides: <Type, Generator>{
      OhosBuilder: () => fakeOhosBuilder,
    });

    testUsingContext('parses flags', () async {
      final String projectPath =
          await createProject(tempDir, arguments: <String>['--no-pub']);
      await runCommandIn(
        projectPath,
        arguments: <String>[
          '--target-platform',
          'ohos-x64',
          '--tree-shake-icons',
          '--flavor',
          'free',
          '--split-debug-info',
          '/project-name/v1.2.3/',
          '--obfuscate',
          '--dart-define=foo=bar',
        ],
      );

      final OhosBuildInfo ohosBuildInfo = fakeOhosBuilder.ohosBuildInfo;
      expect(ohosBuildInfo.targetArchs, <OhosArch>[OhosArch.x86_64]);

      final BuildInfo buildInfo = ohosBuildInfo.buildInfo;
      expect(buildInfo.mode, BuildMode.release);
      expect(buildInfo.treeShakeIcons, isTrue);
      expect(buildInfo.flavor, 'free');
      expect(buildInfo.splitDebugInfoPath, '/project-name/v1.2.3/');
      expect(buildInfo.dartObfuscation, isTrue);
      expect(buildInfo.dartDefines.contains('foo=bar'), isTrue);
      expect(buildInfo.nullSafetyMode, NullSafetyMode.sound);
    }, overrides: <Type, Generator>{
      OhosBuilder: () => fakeOhosBuilder,
    });
  });
}

class FakeOhosBuilder extends Fake implements OhosBuilder {
  late FlutterProject project;
  late OhosBuildInfo ohosBuildInfo;
  late String target;

  @override
  Future<void> buildHsp({
    required FlutterProject project,
    required OhosBuildInfo ohosBuildInfo,
    required String target,
  }) async {
    this.project = project;
    this.ohosBuildInfo = ohosBuildInfo;
    this.target = target;
  }
}

class FakeOhosSdk extends Fake implements HarmonySdk {}
