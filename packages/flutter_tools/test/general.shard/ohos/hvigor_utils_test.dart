

import 'package:file/file.dart';
import 'package:flutter_tools/src/convert.dart';
import 'package:flutter_tools/src/ohos/hvigor_utils.dart';
import 'package:test/fake.dart';

import '../../src/common.dart';

void main() {
  group('hvigor_utils', () {
    test('getFlavor', () {
      final String result = getFlavor(FakeFile('path'),null);
      expect(result, 'default');
    });
  });
}

class FakeFile extends Fake implements File {
  FakeFile(this.path);

  @override
  final String path;

  @override
  bool existsSync() {
    return true;
  }

  @override
  String readAsStringSync({Encoding encoding = utf8ForTesting}) {
    throw const FileSystemException('', '', OSError('', 13)); // EACCES error on linux
  }
}
