Flutter SDK 仓库
==============

原始仓来源：https://github.com/flutter/flutter

## 仓库说明
本仓库是基于Flutter SDK对于OpenHarmony平台的兼容拓展，可支持IDE或者终端使用Flutter Tools指令编译和构建OpenHarmony应用程序。

## 开发文档
[参考文档](https://gitee.com/openharmony-sig/flutter_samples/tree/master/ohos/docs)

## 环境依赖

* 开发系统

  Flutter Tools指令目前已支持在Linux、Mac和Windows下使用。

* 开发限制

  Windows环境下flutter工程和依赖的插件工程需要在同一个磁盘。

* 环境配置
   **请从[鸿蒙SDK](https://developer.huawei.com/consumer/cn/develop)下载配套开发工具**
   *下列环境变量配置，类Unix系统（Linux、Mac），下可直接参照配置，Windows下环境变量配置请在‘编辑系统环境变量’中设置*

  1. 配置HarmonyOS SDK和环境变量
   * API12, deveco-studio-5.0 或 command-line-tools-5.0
   * 下载jdk17并配置环境变量

      ```sh
       # mac环境
       export JAVA_HOME=<JAVA_HOME path>/Contents/Home
       export PATH=$JAVA_HOME/bin:$PATH

       # windows环境
       JAVA_HOME = <JAVA_HOME path>
       PATH=%JAVA_HOME%\bin
      ```

   * 配置环境变量 (SDK, node, ohpm, hvigor)

      ```sh
       # mac环境
       export TOOL_HOME=/Applications/DevEco-Studio.app/Contents # mac环境
       export DEVECO_SDK_HOME=$TOOL_HOME/sdk # command-line-tools/sdk
       export PATH=$TOOL_HOME/tools/ohpm/bin:$PATH # command-line-tools/ohpm/bin
       export PATH=$TOOL_HOME/tools/hvigor/bin:$PATH # command-line-tools/hvigor/bin
       export PATH=$TOOL_HOME/tools/node/bin:$PATH # command-line-tools/tool/node/bin

       # windows环境
       TOOL_HOME = D:\devecostudio-windows\DevEco Studio
       DEVECO_SDK_HOME=%TOOL_HOME%\sdk
       PATH=%TOOL_HOME%\tools\ohpm\bin
       PATH=%TOOL_HOME%\tools\hvigor\bin
       PATH=%TOOL_HOME%\tools\node
      ```

  2. 通过代码工具下载当前仓库代码`git clone https://gitee.com/openharmony-sig/flutter_flutter.git`，指定dev或master分支，并配置环境

     ```sh
      export PUB_CACHE=D:/PUB
      export PATH=<flutter_flutter path>/bin:$PATH
      export PUB_HOSTED_URL=https://pub.flutter-io.cn
      export FLUTTER_STORAGE_BASE_URL=https://storage.flutter-io.cn
     ```
    
   3. 上述所有环境变量的配置（Windows下环境变量配置请在‘编辑系统环境变量’中设置），可参考下面的示例（其中user和具体代码路径请替换成实际路径）：

      ```sh
       #依赖缓存
       export PUB_CACHE=D:/PUB(自定义路径)

       # 国内镜像
       export PUB_HOSTED_URL=https://pub.flutter-io.cn
       export FLUTTER_STORAGE_BASE_URL=https://storage.flutter-io.cn

       # 拉取下来的flutter_flutter/bin目录
       export PATH=/home/<user>/ohos/flutter_flutter/bin:$PATH

       # HamonyOS SDK
       export TOOL_HOME=/Applications/DevEco-Studio.app/Contents # mac环境
       export DEVECO_SDK_HOME=$TOOL_HOME/sdk # command-line-tools/sdk
       export PATH=$TOOL_HOME/tools/ohpm/bin:$PATH # command-line-tools/ohpm/bin
       export PATH=$TOOL_HOME/tools/hvigor/bin:$PATH # command-line-tools/hvigor/bin
       export PATH=$TOOL_HOME/tools/node/bin:$PATH # command-line-tools/tool/node/bin
      ```

## 构建步骤

1. 运行 `flutter doctor -v` 检查环境变量配置是否正确，**Futter**与**OpenHarmony**应都为ok标识，若两处提示缺少环境，按提示补上相应环境即可。

2. 创建工程

   ```
    # 创建工程
    flutter create --platforms ohos <projectName>
   ```

3. 编译hap包，编译产物在\<projectName\>/ohos/entry/build/default/outputs/default/entry-default-signed.hap下。

   ```
    # 进入工程根目录编译
    # 示例：flutter build hap [--target-platform ohos-arm64] --release
    flutter build hap --release
   ```

4. 安装应用，通过```flutter devices```指令发现真机设备之后，然后安装到鸿蒙手机中。

   方式一：进入编译产物目录，然后安装到鸿蒙手机中
   ```sh
   hdc -t <deviceId> install <hap file path>
   ```

   方式二：进入项目目录，直接运行安装到鸿蒙手机中
   ```sh
   flutter run --debug -d <deviceId>
   ```

5. 构建app包命令：
   ```
    # 示例：flutter build app --release
    flutter build app --release
   ```

## 版本说明
 - [3.7.12-ohos-1.0.3 Release](/release-notes/Flutter%203.7.12-ohos%201.0.3%20ReleaseNote.md)
 - [3.7.12-ohos-1.0.2 Release](/release-notes/Flutter%203.7.12-ohos%201.0.2%20ReleaseNote.md)
 - [3.7.12-ohos-1.0.1 Release](/release-notes/Flutter%203.7.12-ohos%201.0.1%20ReleaseNote.md)
 - [3.7.12-ohos-1.0.0 Release](/release-notes/Flutter%203.7.12-ohos%201.0.0%20ReleaseNote.md)

## 已兼容OpenHarmony开发的指令列表
| 指令名称 | 指令描述 | 使用说明                                                              |
| ------- | ------- |-------------------------------------------------------------------|
| doctor | 环境检测 | flutter doctor                                                    |
| config | 环境配置 | flutter config --\<key\> \<value\>                                |
| create | 创建新项目 | flutter create --platforms ohos,android,ios --org \<org\> \<appName\> |
| create | 创建module模板 | flutter create -t module \<module_name\> |
| create | 创建plugin模板 | flutter create -t plugin --platforms ohos,android,ios \<plugin_name\> |
| create | 创建plugin_ffi模板 | flutter create -t plugin_ffi --platforms ohos,android,ios \<plugin_name\> |
| devices | 已连接设备查找 | flutter devices                                                   |
| install | 应用安装 | flutter install -t \<deviceId\> \<hap文件路径\>                                                   |
| assemble | 资源打包 | flutter assemble                                                  |
| build  | 测试应用构建 | flutter build hap --debug [--target-platform ohos-arm64]      |
| build  | 正式应用构建 | flutter build hap --release [--target-platform ohos-arm64]   |
| run    | 应用运行 | flutter run                |
| attach | 调试模式 | flutter attach                                                    |
| screenshot | 截屏 | flutter screenshot                                                 |
| pub | 获取依赖 | flutter pub get                                                 |
| clean | 清除项目依赖 | flutter clean                                                 |
| cache | 清除全局缓存数据 | flutter pub cache clean                                                  |

附：[Flutter高频使用的三方库（部分鸿蒙化）列表](https://gitee.com/openharmony-sig/flutter_packages#openharmony%E5%B9%B3%E5%8F%B0%E5%B7%B2%E5%85%BC%E5%AE%B9%E5%BA%93)


## 常见问题

1. 模拟器调试只支持Mac(arm64)，还不支持Mac(x86) 和 Windows。

2. 切换FLUTTER_STORAGE_BASE_URL后需删除\<flutter\>/bin/cache 目录，并在项目中执行flutter clean后再运行

3. 构建Hap任务时报错：Error: The hvigor depends on the npmrc file. Configure the npmrc file first.


   请在用户目录`~`下创建文件`.npmrc`，该配置也可参考[DevEco Studio官方文档](https://developer.harmonyos.com/cn/docs/documentation/doc-guides-V3/environment_config-0000001052902427-V3)，编辑内容如下：

   ```
    registry=https://repo.huaweicloud.com/repository/npm/
    @ohos:registry=https://repo.harmonyos.com/npm/
   ```

4. 查日志时，存在日志丢失现象。
    解决方案：关闭全局日志，只打开自己领域的日志

    ```
     步骤一：关闭所有领域的日志打印（部分特殊日志无法关闭）
     hdc shell hilog -b X
     步骤二：只打开自己领域的日志
     hdc shell hilog <level> -D <domain> 
     其中<level>为日志打印的级别：D/I/W/E/F,<domain>为Tag前面的数字
     举例：
     打印A00000/XComFlutterOHOS_Native的日志，需要设置hdc shell hilog -b D -D A00000
     注：上面的设置在机器重启后会失效，如果要继续使用，需要重新设置。
    ```
5. 若Api11 Beta1版本的机器上无法启动debug签名的应用，可以通过将签名换成正式签名，或在手机端打开开发者模式解决（步骤：设置->通用->开发者模式）

6. 如果报`Invalid CEN header (invalid zip64 extra data field size)`异常，请更换Jdk版本，参见[JDK-8313765](https://bugs.openjdk.org/browse/JDK-8313765)

7. 运行debug版本的flutter应用用到鸿蒙设备后报错（release和profile版本正常）
    1. 报错信息: `Error while initializing the Dart VM: Wrong full snapshot version, expected '8af474944053df1f0a3be6e6165fa7cf' found 'adb4292f3ec25074ca70abcd2d5c7251'`
    2. 解决方案: 依次执行以下操作
        1. 设置环境变量 `export FLUTTER_STORAGE_BASE_URL=https://flutter-ohos.obs.cn-south-1.myhuaweicloud.com`
        2. 删除 <flutter>/bin/cache 目录下的缓存
        3. 执行 `flutter clean`，清除项目编译缓存
        4. 运行 `flutter run -d $DEVICE --debug`
    3. 补充信息: 运行android或ios出现类似错误，也可以尝试还原环境变量 FLUTTER_STORAGE_BASE_URL ，清除缓存后重新运行。 

8. Beta2版本的ROM更新后，不再支持申请有执行权限的匿名内存，导致debug运行闪退。
    1. 解决方案：更新 flutter_flutter 到 a44b8a6d (2024-07-25) 之后的版本。
    2. 关键日志：

   ```
    #20 at attachToNative (oh_modules/.ohpm/@ohos+flutter_ohos@g8zhdaqwu8gotysbmqcstpfpcpy=/oh_modules/@ohos/flutter_ohos/src/main/ets/embedding/engine/FlutterNapi.ets:78:32)
    #21 at attachToNapi (oh_modules/.ohpm/@ohos+flutter_ohos@g8zhdaqwu8gotysbmqcstpfpcpy=/oh_modules/@ohos/flutter_ohos/src/main/ets/embedding/engine/FlutterEngine.ets:144:5)
    #22 at init (oh_modules/.ohpm/@ohos+flutter_ohos@g8zhdaqwu8gotysbmqcstpfpcpy=/oh_modules/@ohos/flutter_ohos/src/main/ets/embedding/engine/FlutterEngine.ets:133:7)
   ```

9. 构建Hap命令直接执行`flutter build hap`即可，不再需要`--local-engine`参数，直接从云端获取编译产物。

10. 配置环境完成后执行 flutter 命令 出现闪退。
    1. 解决方案：windows环境中添加git环境变量配置。
    ```
     export PATH=<git path>/cmd:$PATH
    ```

11. 执行`flutter pub cache clean` 正常 执行`flutter clean` 报错，按照报错信息执行 update 命令也没有效果。
    1. 解决方案：通过注释掉 build.json5 文件中的配置规避： "modules":[{ // 删除报错对应的整个对象 }]
    2. 报错信息:
    ```
     #Parse ohos module. json5 error: Exception: Can not found module.json5 at
     #D:\pub_cache\git\flutter_packages-b00939bb44d018f0710d1b080d91dcf4c34ed06\packages\video_player\video_player_ohos\ohossrc\main\module.json5.
     #You need to update the Flutter plugin project structure.
     #See
     #https://gitee.com/openharmony-sig/flutter_samples/tree/master/ohos/docs/09_specifications/update_flutter_plugin_structure.md
    ```

12. 执行`flutter build hap` 时遇到路径校验报错。
    1. 解决方案：
      ·打开 deveco 安装路径 D:\DevEco Studio\tools\hvigor\hvigor-ohos-plugin\res\schemas 下的 ohos-project-build-profile-schema.json文件。
      ·在该文件中找到包含："pattern": "^(\\./|\\.\\./)[\\s\\S]+$"的行,并删除此行。
    2. 报错信息:
    ```
     #hvigor  ERROR: Schema validate failed.
     #        Detail: Please check the following fields.
     #instancePath: 'modules[1].scrPath',
     #keyword: 'pattern'
     #params: { pattern:'^(\\./|\\.\\./)[\\s\\S]+$' },
     #message: 'must match pattern "^(\\./|\\.\\./)[\\s\\S]+$"',
     #location: 'D:/work/videoplayerdemo/video_cannot_stop_at_background/ohos/build-profile.json:42:146'
    ```

13. 执行`flutter build hap` 报错。
    1. 解决方案：打开 deveco 安装路径 D:\DevEco Studio\tools\hvigor\hvigor-ohos-plugin\src\model\module 下的 core-module-model-impl.js,
       修改 findBelongProjectPath 方法（需要管理员权限，可另存为后替换）
       ```
        findBelongProjectPath(e) {
          if (e === path_1.default.dirname(e)) {
             return this.parentProject.getProjectDir()
          }
        }
       ```
    2. 报错信息:
      ```
       # hvigor  ERROR: Cannot find belonging project path for module at D:\.
       # hvigor  ERROR:  BUILD FAILED in 2s 556ms.
       #Running Hvigor task assembleHap...
       #Oops; flutter has exited unexpectedly: "ProcessException: The command failed
       #  <Command: hvigorw --mode module -p module=video_player_ohos@default -p product=default assmbleHar --no-daemon"
       #A crash report has been written to D:\work\videoplayerdemo\video_cannot_stop_at_background\flutter_03.log.
      ```

14. 在.ohos的项目执行`flutter clean` 报错，然后再执行`flutter pub get`也报错。
    1. 解决方案：删除.ohos文件夹，重新flutter pub get 即可
    2.报错信息：
      ```
       Oops; flutter has exited unexpectedly: "PathNotFoundException: Cannot open file, path = 'D:\code\.ohos\build-profile.json5' (OS Error: 系统找不到指定的文件。，error = 2)".
       A crash report has been written to D:\code\flutter_01.log.
      ``` 

[更多FAQ](https://gitee.com/openharmony-sig/flutter_samples/blob/master/ohos/docs/08_FAQ/README.md)
