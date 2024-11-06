/*
 * Copyright (C) 2024 Huawei Device Co., Ltd.
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

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
