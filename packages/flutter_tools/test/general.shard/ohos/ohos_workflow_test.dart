
import 'package:flutter_tools/src/ohos/ohos_sdk.dart';
import 'package:flutter_tools/src/ohos/ohos_workflow.dart';
import 'package:test/fake.dart';

import '../../src/common.dart';
import '../../src/fakes.dart';

void main() {
  testWithoutContext('OhosWorkflow handles a null OhosSDK', () {
    final OhosWorkflow ohosWorkflow = OhosWorkflow(
      featureFlags: TestFeatureFlags(),
      ohosSdk: null,
    );

    expect(ohosWorkflow.canLaunchDevices, false);
    expect(ohosWorkflow.canListDevices, false);
    expect(ohosWorkflow.canListEmulators, false);
  });

  testWithoutContext('OhosWorkflow handles a null hdc', () {
    final FakeOhosSdk ohosSdk = FakeOhosSdk();
    ohosSdk.hdcPath = null;
    final OhosWorkflow ohosWorkflow = OhosWorkflow(
      featureFlags: TestFeatureFlags(),
      ohosSdk: ohosSdk,
    );

    expect(ohosWorkflow.canLaunchDevices, false);
    expect(ohosWorkflow.canListDevices, false);
    expect(ohosWorkflow.canListEmulators, false);
  });

  testWithoutContext('Support for Ohos SDK on Linux Arm Hosts', () {
    final FakeOhosSdk ohosSdk = FakeOhosSdk();
    ohosSdk.hdcPath = null;
    final OhosWorkflow ohosWorkflow = OhosWorkflow(
      featureFlags: TestFeatureFlags(isOhosEnabled: true),
      ohosSdk: ohosSdk,
    );

    expect(ohosWorkflow.appliesToHostPlatform, isTrue);
    expect(ohosWorkflow.canLaunchDevices, isFalse);
    expect(ohosWorkflow.canListDevices, isFalse);
    expect(ohosWorkflow.canListEmulators, isFalse);
  });

  testWithoutContext('OhosWorkflow is disabled if feature is disabled', () {
    final FakeOhosSdk ohosSdk = FakeOhosSdk();
    ohosSdk.hdcPath = null;
    final OhosWorkflow ohosWorkflow = OhosWorkflow(
      featureFlags: TestFeatureFlags(isOhosEnabled: false),
      ohosSdk: ohosSdk,
    );

    expect(ohosWorkflow.appliesToHostPlatform, false);
    expect(ohosWorkflow.canLaunchDevices, false);
    expect(ohosWorkflow.canListDevices, false);
    expect(ohosWorkflow.canListEmulators, false);
  });

  testWithoutContext('OhosWorkflow cannot list emulators if hdcPath is null',
      () {
    final FakeOhosSdk ohosSdk = FakeOhosSdk();
    ohosSdk.hdcPath = null;
    final OhosWorkflow ohosWorkflow = OhosWorkflow(
      featureFlags: TestFeatureFlags(isOhosEnabled: true),
      ohosSdk: ohosSdk,
    );

    expect(ohosWorkflow.appliesToHostPlatform, true);
    expect(ohosWorkflow.canLaunchDevices, false);
    expect(ohosWorkflow.canListDevices, false);
    expect(ohosWorkflow.canListEmulators, false);
  });

  testWithoutContext('OhosWorkflow can list emulators', () {
    final FakeOhosSdk ohosSdk = FakeOhosSdk();
    ohosSdk.hdcPath = 'path/to/hdc';
    final OhosWorkflow ohosWorkflow = OhosWorkflow(
      featureFlags: TestFeatureFlags(isOhosEnabled: true),
      ohosSdk: ohosSdk,
    );

    expect(ohosWorkflow.appliesToHostPlatform, true);
    expect(ohosWorkflow.canLaunchDevices, true);
    expect(ohosWorkflow.canListDevices, true);
    expect(ohosWorkflow.canListEmulators, true);
  });
}

class FakeOhosSdk extends Fake implements OhosSdk {
  @override
  String sdkPath = '';

  @override
  String? hdcPath;
}
