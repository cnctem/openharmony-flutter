// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

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
