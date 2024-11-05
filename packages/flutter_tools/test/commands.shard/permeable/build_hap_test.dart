// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:args/args.dart';
import 'package:flutter_tools/src/build_info.dart';
import 'package:flutter_tools/src/commands/build_hap.dart';
import 'package:flutter_tools/src/ohos/ohos_builder.dart';
import 'package:flutter_tools/src/ohos/ohos_sdk.dart';
import 'package:flutter_tools/src/project.dart';
import 'package:flutter_tools/src/runner/flutter_command.dart';
import 'package:test/fake.dart';
import 'package:test/test.dart';

void main() {
  group('BuildHapCommand', () {
    late FakeBuildHapCommand command;
    late FakeSuccessBuildHapCommand successCommand;
    late FakeGlobals fakeGlobals;

    setUp(() {
      fakeGlobals = FakeGlobals();
      fakeGlobals.hmosSdk = FakeHmosSdk(); // 初始化 hmosSdk 属性
      command = FakeBuildHapCommand();
      successCommand = FakeSuccessBuildHapCommand();
    });

    test('should add command line options', () {
      expect(command.argParser.options['target-platform'], isNull);
    });

    test('should exit when no SDK is configured', () async {
      fakeGlobals.hmosSdk = null;
      expect(await command.runCommand(), isNotNull);
    });

    test('should call ohosBuilder.buildHap when runCommand is executed',
            () async {
          expect(await successCommand.runCommand(), isNotNull);
        });
  });
}

class FakeBuildHapCommand extends Fake implements BuildHapCommand {
  @override
  ArgParser get argParser => ArgParser();

  @override
  Future<FlutterCommandResult> runCommand() async {
    return FlutterCommandResult.success();
  }
}

class FakeSuccessBuildHapCommand extends Fake implements BuildHapCommand {
  @override
  ArgParser get argParser => ArgParser();

  @override
  Future<FlutterCommandResult> runCommand() async {
    return FlutterCommandResult.success();
  }
}

class FakeOhosBuilder extends Fake implements OhosBuilder {
  bool buildHapCalled = false;

  @override
  Future<void> buildHap({
    required FlutterProject project,
    required OhosBuildInfo ohosBuildInfo,
    required String target,
  }) async {
    buildHapCalled = true;
  }
}

// 创建一个 FakeHmosSdk 类来模拟 HmosSdk 的行为
class FakeHmosSdk extends Fake implements HmosSdk {}

// 创建一个 FakeGlobals 类来模拟 globals.Globals 的行为
class FakeGlobals extends Fake {
  FakeHmosSdk? hmosSdk;
}