/*
* Copyright 2014 The Flutter Authors. All rights reserved.
* Use of this source code is governed by a BSD-style license that can be
* found in the LICENSE file.
*/

import 'dart:convert';
import 'dart:ffi';

import 'package:json5/json5.dart';

import '../base/common.dart';
import '../base/file_system.dart';
import '../base/utils.dart';
import '../flutter_plugins.dart';
import '../globals.dart' as globals;
import '../platform_plugins.dart';
import '../plugins.dart';
import '../project.dart';
import 'dart:io' as io;

const String kUseAbsolutePathOfHar = 'useAbsolutePathOfHar';

/// 检查 ohos plugin 依赖
Future<void> checkOhosPluginsDependencies(FlutterProject flutterProject) async {
  final List<Plugin> plugins = (await findPlugins(flutterProject))
      .where((Plugin p) => p.platforms.containsKey(OhosPlugin.kConfigKey))
      .toList();
  final File packageFile = flutterProject.ohos.flutterModulePackageFile;
  if (!packageFile.existsSync()) {
    globals.logger.printTrace('check if oh-package.json5 file:($packageFile) exist ?');
    return;
  }

  final SettingsFile settings = flutterProject.ohos.settings;
  final bool useAbsolutePathOfHar = settings.values[kUseAbsolutePathOfHar] == 'true';

  final String packageConfig = packageFile.readAsStringSync();
  final Map<String, dynamic> config = JSON5.parse(packageConfig) as Map<String, dynamic>;
  final Map<String, dynamic> dependencies =
      config['dependencies'] as Map<String, dynamic>;

  if (flutterProject.isModule) {
    dependencies['@ohos/flutter_ohos'] = 'file:./har/flutter.har';
  }

  final List<String> removeList = <String>[];
  for (final Plugin plugin in plugins) {
    ///修改plugin中对@ohos/flutter的依赖版本为*
    changePluginFlutterHarDependency(plugin);

    for (final String key in dependencies.keys) {
      if (key.startsWith('@ohos') && key.contains(plugin.name)) {
        removeList.add(key);
      }
    }

    if (flutterProject.isModule) {
      if (useAbsolutePathOfHar) {
        dependencies[plugin.name] = 'file:./har/${plugin.path}.har';
      } else {
        dependencies[plugin.name] = 'file:${plugin.path}ohos';
      }
    } else {
      final String absolutePath = globals.fs.path.join(flutterProject.ohos.ohosRoot.path, 'har/${plugin.name}.har');
      final String relativePath = _relative(absolutePath, globals.fs.path.dirname(packageFile.path));
      dependencies[plugin.name] = 'file:$relativePath';
    }
  }
  for (final String key in removeList) {
    globals.printStatus(
        'OhosDependenciesManager: deprecated plugin dependencies "$key" has been removed.');
    dependencies.remove(key);
  }
  final String configNew = const JsonEncoder.withIndent('  ').convert(config);
  packageFile.writeAsStringSync(configNew, flush: true);
}

void changePluginFlutterHarDependency(Plugin plugin){

  final String pluginPackagePath = globals.fs.path.join(plugin.path, OhosPlugin.kConfigKey,'oh-package.json5');
  final io.File file = io.File(pluginPackagePath);
  final String pluginConfig = file.readAsStringSync();
  final Map<String, dynamic> pluginConfigMap = JSON5.parse(pluginConfig) as Map<String, dynamic>;
  final Map<String, dynamic> dependencies = (pluginConfigMap['dependencies'] as Map<String, dynamic>).cast();
  dependencies['@ohos/flutter_ohos'] = '*';
  final String pluginConfigMapNew = const JsonEncoder.withIndent('  ').convert(pluginConfigMap);
  file.writeAsStringSync(pluginConfigMapNew, flush: true);
}

/// 添加到工程级 build-profile.json5 的 modules 中
Future<void> addPluginsModules(FlutterProject flutterProject) async {
  final List<Plugin> plugins = (await findPlugins(flutterProject))
      .where((Plugin p) => p.platforms.containsKey(OhosPlugin.kConfigKey))
      .toList();
  if (plugins.isEmpty) {
    return;
  }
  final File buildProfileFile = flutterProject.ohos.getBuildProfileFile();
  if (!buildProfileFile.existsSync()) {
    throwToolExit('check if build-profile.json5 file:($buildProfileFile) exist ?');
  }
  final String packageConfig = buildProfileFile.readAsStringSync();
  final Map<String, dynamic> buildProfile = JSON5.parse(packageConfig) as Map<String, dynamic>;
  final List<Map<dynamic, dynamic>> modules = (buildProfile['modules'] as List<dynamic>).cast();
  final Map<String, dynamic> modulesMap = Map<String, dynamic>.fromEntries(modules.map((e) => MapEntry(e['name'] as String, e)));
  for (final Plugin plugin in plugins) {
    if (modulesMap.containsKey(plugin.name)) {
      continue;
    }
    modules.add(<String, dynamic>{
      'name': plugin.name,
      'srcPath': _relative(
        globals.fs.path.join(plugin.path, OhosPlugin.kConfigKey),
        flutterProject.ohos.ohosRoot.path,
      ),
      'targets': <Map<String, dynamic>>[
        <String, dynamic>{
          'name': 'default',
          'applyToProducts': <dynamic>['default']
        }
      ],
    });
  }
  final String buildProfileNew = const JsonEncoder.withIndent('  ').convert(buildProfile);
  buildProfileFile.writeAsStringSync(buildProfileNew, flush: true);
}


Future<void> changeOhosPluginsDependencies(FlutterProject flutterProject,bool useHar) async {
  final List<Plugin> plugins = (await findPlugins(flutterProject))
      .where((Plugin p) => p.platforms.containsKey(OhosPlugin.kConfigKey))
      .toList();
  final File packageFile = flutterProject.ohos.flutterModulePackageFile;
  if (!packageFile.existsSync()) {
    globals.logger.printTrace('check if oh-package.json5 file:($packageFile) exist ?');
    return;
  }

  final String packageConfig = packageFile.readAsStringSync();
  final Map<String, dynamic> config = JSON5.parse(packageConfig) as Map<String, dynamic>;
  final Map<String, dynamic> dependencies =
  config['dependencies'] as Map<String, dynamic>;

  final List<String> removeList = <String>[];

  for (final Plugin plugin in plugins) {
    for (final String key in dependencies.keys) {
      if (key.startsWith('@ohos') && key.contains(plugin.name)) {
        removeList.add(key);
      }
    }

    if (useHar) {
      dependencies[plugin.name] = 'file:./har/${plugin.name}.har';
    } else {
      dependencies[plugin.name] = 'file:${plugin.path}ohos';
    }
  }

  for (final String key in removeList) {
    globals.printStatus(
        'OhosDependenciesManager: deprecated plugin dependencies "$key" has been removed.');
    dependencies.remove(key);
  }
  final String configNew = const JsonEncoder.withIndent('  ').convert(config);
  packageFile.writeAsStringSync(configNew, flush: true);
}


/// 在工程级的的oh-package.json5里添加flutter_module以及plugins的配置
Future<void> addFlutterModuleAndPluginsSrcOverrides(FlutterProject flutterProject) async {
  final List<Plugin> plugins = (await findPlugins(flutterProject))
      .where((Plugin p) => p.platforms.containsKey(OhosPlugin.kConfigKey))
      .toList();
  if (plugins.isEmpty) {
    return;
  }
  final File packageFile = flutterProject.ohos.ohosRoot.childFile('oh-package.json5');
  if (!packageFile.existsSync()) {
    globals.logger.printTrace('check if oh-package.json5 file:($packageFile) exist ?');
    return;
  }
  final String packageConfig = packageFile.readAsStringSync();
  final Map<String, dynamic> config = JSON5.parse(packageConfig) as Map<String, dynamic>;
  final Map<String, dynamic> overrides = config['overrides'] as Map<String, dynamic>? ?? <String, dynamic>{};

  for (final Plugin plugin in plugins) {
    overrides[plugin.name] = _relative(
      globals.fs.path.join(plugin.path, OhosPlugin.kConfigKey),
      flutterProject.ohos.ohosRoot.path,
    );
  }
  final String relativePath = _relative(flutterProject.ohos.flutterModuleDirectory.path, flutterProject.ohos.ohosRoot.path);
  overrides['@ohos/flutter_module'] = 'file:./$relativePath';
  overrides['@ohos/flutter_ohos'] = 'file:./har/flutter.har';
  final String configNew = const JsonEncoder.withIndent('  ').convert(config);
  packageFile.writeAsStringSync(configNew, flush: true);
}

/// 添加到工程级 build-profile.json5 的 modules 中
Future<void> removePluginsModules(FlutterProject flutterProject) async {
  final List<Plugin> plugins = (await findPlugins(flutterProject))
      .where((Plugin p) => p.platforms.containsKey(OhosPlugin.kConfigKey))
      .toList();
  if (plugins.isEmpty) {
    return;
  }
  final Map<String, Plugin> pluginsMap = Map<String, Plugin>.fromEntries(
    plugins.map((Plugin e) => MapEntry<String, Plugin>(e.name, e))
  );
  final File buildProfileFile = flutterProject.ohos.getBuildProfileFile();
  if (!buildProfileFile.existsSync()) {
    globals.logger.printTrace('check if build-profile.json5 file:($buildProfileFile) exist ?');
    return;
  }
  final String packageConfig = buildProfileFile.readAsStringSync();
  final Map<String, dynamic> buildProfile = JSON5.parse(packageConfig) as Map<String, dynamic>;
  final List<Map<dynamic, dynamic>> modules = (buildProfile['modules'] as List<dynamic>).cast();
  final List<Map<dynamic, dynamic>> newModules = <Map<dynamic, dynamic>>[];

  for (final Map<dynamic, dynamic> module in modules) {
    if (pluginsMap.containsKey(module['name'])) {
      continue;
    } else {
      newModules.add(module);
    }
  }
  buildProfile['modules'] = newModules;
  final String buildProfileNew = const JsonEncoder.withIndent('  ').convert(buildProfile);
  buildProfileFile.writeAsStringSync(buildProfileNew, flush: true);
}

/// 把flutter_module跟plugins的依赖写入工程级oh-package.json5里的overrides
Future<void> addFlutterModuleAndPluginsOverrides(FlutterProject flutterProject) async {
  final List<Plugin> plugins = (await findPlugins(flutterProject))
      .where((Plugin p) => p.platforms.containsKey(OhosPlugin.kConfigKey))
      .toList();
  if (plugins.isEmpty) {
    return;
  }
  final File packageFile = flutterProject.ohos.ohosRoot.childFile('oh-package.json5');
  if (!packageFile.existsSync()) {
    globals.logger.printTrace('check if oh-package.json5 file:($packageFile) exist ?');
    return;
  }
  final String packageConfig = packageFile.readAsStringSync();
  final Map<String, dynamic> config = JSON5.parse(packageConfig) as Map<String, dynamic>;
  final Map<String, dynamic> overrides = config['overrides'] as Map<String, dynamic>? ?? <String, dynamic>{};
  final SettingsFile settings = flutterProject.ohos.settings;
  final bool useAbsolutePathOfHar = settings.values[kUseAbsolutePathOfHar] == 'true';

  for (final Plugin plugin in plugins) {
    final String absolutePath = globals.fs.path.join(flutterProject.ohos.ohosRoot.path, 'har/${plugin.name}.har');
    if (useAbsolutePathOfHar && flutterProject.isModule) {
      overrides[plugin.name] = 'file:$absolutePath';
    } else {
      overrides[plugin.name] = 'file:./har/${plugin.name}.har';
    }
  }
  final String configNew = const JsonEncoder.withIndent('  ').convert(config);
  packageFile.writeAsStringSync(configNew, flush: true);
}

String _relative(String path, String from) {
  final String realPath = path.endsWith('.har')
      ? path
      : globals.fs.file(path).resolveSymbolicLinksSync();
  final String realFrom = globals.fs.file(from).resolveSymbolicLinksSync();
  final String result = globals.fs.path.relative(realPath, from: realFrom).replaceAll(r'\', '/');
  return result;
}
