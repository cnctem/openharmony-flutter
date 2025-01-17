// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:args/command_runner.dart';
import 'package:flutter_tools/src/base/file_system.dart';
import 'package:flutter_tools/src/base/logger.dart';
import 'package:flutter_tools/src/cache.dart';
import 'package:flutter_tools/src/commands/build_app.dart';
import 'package:flutter_tools/src/globals.dart' as globals;
import 'package:flutter_tools/src/ohos/ohos_builder.dart';
import 'package:flutter_tools/src/reporting/reporting.dart';

import '../../src/common.dart';
import '../../src/context.dart';
import '../../src/ohos_common.dart';
import '../../src/test_flutter_command_runner.dart';

void main() {
  Cache.disableLocking();

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

    testUsingContext('indicate the project name', () async {
      final String projectPath = await createProject(tempDir,
          arguments: <String>['--no-pub', '--template=app']);
      final BuildAppCommand command = await runBuildAppCommand(projectPath);

      expect(command.name, 'app');
    }, overrides: <Type, Generator>{
      OhosBuilder: () => FakeOhosBuilder(),
    });

    testUsingContext('logs success', () async {
      final String projectPath = await createProject(tempDir,
          arguments: <String>['--no-pub', '--template=app']);

      await runBuildAppCommand(projectPath);

      expect(
          testUsage.events,
          contains(
            const TestUsageEvent(
              'tool-command-result',
              'app',
              label: 'success',
            ),
          ));
    }, overrides: <Type, Generator>{
      OhosBuilder: () => FakeOhosBuilder(),
      Usage: () => testUsage,
    });
  });
}

Future<BuildAppCommand> runBuildAppCommand(
  String target, {
  List<String>? arguments,
}) async {
  final BuildAppCommand command = BuildAppCommand(logger: BufferLogger.test());
  final CommandRunner<void> runner = createTestCommandRunner(command);
  await runner.run(<String>[
    'app',
    ...?arguments,
    '--no-pub',
    globals.fs.path.join(target, 'lib', 'main.dart'),
  ]);
  return command;
}
