
import 'package:file/memory.dart';
import 'package:flutter_tools/src/base/logger.dart';
import 'package:flutter_tools/src/base/platform.dart';
import 'package:flutter_tools/src/base/user_messages.dart';
import 'package:flutter_tools/src/device.dart';
import 'package:flutter_tools/src/ohos/ohos_device_discovery.dart';
import 'package:flutter_tools/src/ohos/ohos_sdk.dart';
import 'package:flutter_tools/src/ohos/ohos_workflow.dart';
import 'package:test/fake.dart';

import '../../src/common.dart';
import '../../src/fake_process_manager.dart';
import '../../src/fakes.dart';

void main() {
  late OhosWorkflow ohosWorkflow;

  setUp(() {
    ohosWorkflow = OhosWorkflow(
      ohosSdk: FakeOhosSdk(),
      featureFlags: TestFeatureFlags(),
    );
  });

  testWithoutContext('OhosDevices returns empty device list on null hdc',
      () async {
    final OhosDevices ohosDevices = OhosDevices(
      ohosSdk: FakeOhosSdk(null),
      logger: BufferLogger.test(),
      ohosWorkflow: OhosWorkflow(
        ohosSdk: FakeOhosSdk(null),
        featureFlags: TestFeatureFlags(),
      ),
      processManager: FakeProcessManager.empty(),
      fileSystem: MemoryFileSystem.test(),
      platform: FakePlatform(),
      userMessages: UserMessages(),
    );

    expect(await ohosDevices.pollingGetDevices(), isEmpty);
  });

  testWithoutContext(
      'OhosDevices returns empty device list when hdc cannot be run', () async {
    final FakeProcessManager fakeProcessManager = FakeProcessManager.empty();
    fakeProcessManager.excludedExecutables.add('hdc');
    final OhosDevices ohosDevices = OhosDevices(
      ohosSdk: FakeOhosSdk(),
      logger: BufferLogger.test(),
      ohosWorkflow: OhosWorkflow(
        ohosSdk: FakeOhosSdk(),
        featureFlags: TestFeatureFlags(),
      ),
      processManager: fakeProcessManager,
      fileSystem: MemoryFileSystem.test(),
      platform: FakePlatform(),
      userMessages: UserMessages(),
    );

    expect(await ohosDevices.pollingGetDevices(), isEmpty);
    expect(fakeProcessManager, hasNoRemainingExpectations);
  });

  testWithoutContext('OhosDevices returns empty device list on null Ohos SDK',
      () async {
    final OhosDevices ohosDevices = OhosDevices(
      logger: BufferLogger.test(),
      ohosWorkflow: OhosWorkflow(
        ohosSdk: FakeOhosSdk(null),
        featureFlags: TestFeatureFlags(),
      ),
      processManager: FakeProcessManager.empty(),
      fileSystem: MemoryFileSystem.test(),
      platform: FakePlatform(),
      userMessages: UserMessages(),
    );

    expect(await ohosDevices.pollingGetDevices(), isEmpty);
  });

  testWithoutContext('OhosDevices throwsToolExit on failing hdc', () {
    final ProcessManager processManager = FakeProcessManager.list(<FakeCommand>[
      const FakeCommand(
        command: <String>['hdc', '-t', '', 'list', 'targets'],
        exitCode: 1,
      ),
    ]);
    final OhosDevices ohosDevices = OhosDevices(
      ohosSdk: FakeOhosSdk(),
      logger: BufferLogger.test(),
      ohosWorkflow: ohosWorkflow,
      processManager: processManager,
      fileSystem: MemoryFileSystem.test(),
      platform: FakePlatform(),
      userMessages: UserMessages(),
    );

    expect(ohosDevices.pollingGetDevices(),
        throwsToolExit(message: RegExp('Unable to run "hdc"')));
  });

  testWithoutContext('OhosDevices is disabled if feature is disabled', () {
    final OhosDevices ohosDevices = OhosDevices(
      ohosSdk: FakeOhosSdk(),
      logger: BufferLogger.test(),
      ohosWorkflow: OhosWorkflow(
        ohosSdk: FakeOhosSdk(),
        featureFlags: TestFeatureFlags(
          isOhosEnabled: false,
        ),
      ),
      processManager: FakeProcessManager.any(),
      fileSystem: MemoryFileSystem.test(),
      platform: FakePlatform(),
      userMessages: UserMessages(),
    );

    expect(ohosDevices.supportsPlatform, false);
  });

  testWithoutContext('OhosDevices can parse output for physical devices',
      () async {
    final OhosDevices ohosDevices = OhosDevices(
      userMessages: UserMessages(),
      ohosWorkflow: ohosWorkflow,
      ohosSdk: FakeOhosSdk(),
      logger: BufferLogger.test(),
      processManager: FakeProcessManager.list(<FakeCommand>[
        const FakeCommand(
          command: <String>['hdc', '-t', '', 'list', 'targets'],
          stdout: '''
          23E0223C05031918 (mobile)
          ''',
        ),
      ]),
      platform: FakePlatform(),
      fileSystem: MemoryFileSystem.test(),
    );

    final List<Device> devices = await ohosDevices.pollingGetDevices();

    expect(devices, hasLength(1));
    expect(devices.first.name, '23E0223C05031918 (mobile)');
    expect(devices.first.category, Category.mobile);
  });

  testWithoutContext(
      'OhosDevices can parse output for emulators and short listings',
      () async {
    final OhosDevices ohosDevices = OhosDevices(
      userMessages: UserMessages(),
      ohosWorkflow: ohosWorkflow,
      ohosSdk: FakeOhosSdk(),
      logger: BufferLogger.test(),
      processManager: FakeProcessManager.list(<FakeCommand>[
        const FakeCommand(
          command: <String>['hdc', '-t', '', 'list', 'targets'],
          stdout: '''
          localhost:36790
          0149947A0D01500C
          emulator-5612
            ''',
        ),
      ]),
      platform: FakePlatform(),
      fileSystem: MemoryFileSystem.test(),
    );

    final List<Device> devices = await ohosDevices.pollingGetDevices();

    expect(devices, hasLength(3));
    expect(devices[0].name, 'localhost:36790');
    expect(devices[1].name, '0149947A0D01500C');
    expect(devices[2].name, 'emulator-5612');
  });
}

class FakeOhosSdk extends Fake implements OhosSdk {
  FakeOhosSdk([this.hdcPath = 'hdc']);

  @override
  final String? hdcPath;
}
