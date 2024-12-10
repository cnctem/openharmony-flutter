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

import 'package:flutter_tools/src/base/file_system.dart';
import 'package:flutter_tools/src/build_info.dart';
import 'package:flutter_tools/src/globals.dart' as globals;
import 'package:flutter_tools/src/ohos/ohos_builder.dart';
import 'package:flutter_tools/src/project.dart';

/// A fake implementation of [OhosBuilder].
class FakeOhosBuilder implements OhosBuilder {
  @override
  Future<void> buildApp(
      {required FlutterProject project,
      required OhosBuildInfo ohosBuildInfo,
      required String target}) async {}

  @override
  Future<void> buildHap(
      {required FlutterProject project,
      required OhosBuildInfo ohosBuildInfo,
      required String target}) async {}

  @override
  Future<void> buildHar(
      {required FlutterProject project,
      required OhosBuildInfo ohosBuildInfo,
      required String target}) async {}

  @override
  Future<void> buildHsp(
      {required FlutterProject project,
      required OhosBuildInfo ohosBuildInfo,
      required String target}) async {}
}

/// Creates a [FlutterProject] in a directory named [flutter_project]
/// within [directoryOverride].
class FakeFlutterProjectFactory extends FlutterProjectFactory {
  FakeFlutterProjectFactory(this.directoryOverride)
      : assert(directoryOverride != null),
        super(
          fileSystem: globals.fs,
          logger: globals.logger,
        );

  final Directory directoryOverride;

  @override
  FlutterProject fromDirectory(Directory _) {
    projects.clear();
    return super
        .fromDirectory(directoryOverride.childDirectory('flutter_project'));
  }
}
