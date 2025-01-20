
import 'package:file/memory.dart';
import 'package:flutter_tools/src/base/config.dart';
import 'package:flutter_tools/src/base/file_system.dart';
import 'package:flutter_tools/src/base/logger.dart';
import 'package:flutter_tools/src/base/platform.dart';
import 'package:flutter_tools/src/base/user_messages.dart';
import 'package:flutter_tools/src/doctor_validator.dart';
import 'package:flutter_tools/src/globals.dart' as globals;
import 'package:flutter_tools/src/ohos/ohos_doctor.dart';
import 'package:flutter_tools/src/ohos/ohos_sdk.dart';

import '../../src/common.dart';
import '../../src/context.dart';

void main() {
  late Logger logger;
  late MemoryFileSystem fileSystem;
  late FakeProcessManager processManager;
  late Config config;

  setUp(() {
    config = Config.test();
    fileSystem = MemoryFileSystem.test();
    logger = BufferLogger.test();
    FakeCommand command = FakeCommand(command: ['ohpm', '--version']);
    FakeCommand command2 = FakeCommand(command: ['node', '--version']);
    FakeCommand command3 = FakeCommand(command: ['where', 'hvigorw']);
    processManager = FakeProcessManager.list([command, command2, command3]);
  });

  group('ohos doctor', () {
    testUsingContext('validate ohos tools', () async {
      final Directory sdkDir = createSdkDirectory(fileSystem: fileSystem);
      config.setValue('ohos-sdk', sdkDir.path);
      final OhosSdk sdk = OhosSdk.localOhosSdk()!;
      final ValidationResult validationResult = await OhosValidator(
        ohosSdk: sdk,
        fileSystem: fileSystem,
        logger: logger,
        processManager: processManager,
        platform: FakePlatform()..operatingSystem = 'windows',
        userMessages: UserMessages(),
      ).validate();
      expect(validationResult.type, ValidationType.installed);
    }, overrides: <Type, Generator>{
      FileSystem: () => fileSystem,
      ProcessManager: () => FakeProcessManager.any(),
      Config: () => config,
    });
  });
}

void _createSdkFile(Directory dir, String filePath, {String? contents}) {
  final File file = dir.childFile(filePath);
  file.createSync(recursive: true);
  if (contents != null) {
    file.writeAsStringSync(contents, flush: true);
  }
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
