# Flutter SDK 仓库

原始仓来源：[https://github.com/flutter/flutter](https://github.com/flutter/flutter)

## 仓库说明

本仓库是基于 Flutter SDK 对于 OpenHarmony 平台的兼容拓展，可支持 IDE 或者终端使用 Flutter Tools 指令编译和构建 OpenHarmony 应用程序。

## 开发文档

文档入口：[https://gitee.com/openharmony-sig/flutter_samples/tree/master/ohos/docs](https://gitee.com/openharmony-sig/flutter_samples/tree/master/ohos/docs)

## 环境依赖

- 开发系统

  Flutter Tools 指令目前已支持在 Linux、Mac 和 Windows 下使用。

- 环境配置

  **请优先从[鸿蒙套件列表](https://developer.harmonyos.com/deveco-developer-suite/enabling/kit?currentPage=1&pageSize=100)下载配套开发工具，暂不支持非该渠道下载的套件**

  _下列环境变量配置，类 Unix 系统（Linux、Mac），下可直接参照配置，Windows 下环境变量配置请在‘编辑系统环境变量’中设置_

   1. 配置 HarmonyOS SDK 和环境变量
      - API12, deveco-studio-5.0.3.300 或 command-line-tools-5.0.3.300
      - 配置 Java17
      - 配置环境变量 (SDK, node, ohpm, hvigor)

         ```sh
         export TOOL_HOME=/Applications/DevEco-Studio-5.0.3.300.app/Contents # mac环境
         export DEVECO_SDK_HOME=$TOOL_HOME/sdk # command-line-tools/sdk
         epxort HDC_HOME=$DEVECO_SDK_HOME/HarmonyOS-NEXT-DB1/openharmony/toolchains # windows 中需要配置该变量，否则拉取代码可能会卡死不动
         export PATH=$TOOL_HOME/tools/ohpm/bin:$PATH # command-line-tools/ohpm/bin
         export PATH=$TOOL_HOME/tools/hvigor/bin:$PATH # command-line-tools/hvigor/bin
         export PATH=$TOOL_HOME/tools/node/bin:$PATH # command-line-tools/tool/node/bin
         ```

  2. 通过代码工具下载当前仓库代码`git clone https://gitee.com/openharmony-sig/flutter_flutter.git`，指定 dev 或 master 分支，并配置环境

     ```sh
     export PATH=<flutter_flutter path>/bin:$PATH
     export PUB_HOSTED_URL=https://pub.flutter-io.cn
     export FLUTTER_STORAGE_BASE_URL=https://storage.flutter-io.cn
     ```

  3. `--local-engine` 成为可选参数，可以不传，默认从云端获取。

     - 使用示例：`--local-engine=src/out/<engine产物目录\>`
     - 可在该路径下载[编译产物](https://docs.qq.com/sheet/DUnljRVBYUWZKZEtF?tab=BB08J2)
     - engine 路径指向需带上 `src/out` 目录

     上述所有环境变量的配置（Windows 下环境变量配置请在‘编辑系统环境变量’中设置），可参考下面的示例（其中 user 和具体代码路径请替换成实际路径）：

     ```sh
     # 国内镜像
     export PUB_HOSTED_URL=https://pub.flutter-io.cn
     export FLUTTER_STORAGE_BASE_URL=https://storage.flutter-io.cn

     # 拉取下来的flutter_flutter/bin目录
     export PATH=/home/<user>/ohos/flutter_flutter/bin:$PATH

     # HamonyOS SDK
     export TOOL_HOME=/Applications/DevEco-Studio-5.0.3.300.app/Contents # mac环境
     export DEVECO_SDK_HOME=$TOOL_HOME/sdk # command-line-tools/sdk
     epxort HDC_HOME=$DEVECO_SDK_HOME/HarmonyOS-NEXT-DB1/openharmony/toolchains # windows 中需要配置该变量，否则拉取代码可能会卡死不动
     export PATH=$TOOL_HOME/tools/ohpm/bin:$PATH # command-line-tools/ohpm/bin
     export PATH=$TOOL_HOME/tools/hvigor/bin:$PATH # command-line-tools/hvigor/bin
     export PATH=$TOOL_HOME/tools/node/bin:$PATH # command-line-tools/tool/node/bin
     ```

## 构建步骤

1. 运行 `flutter doctor -v` 检查环境变量配置是否正确，**Futter**与**OpenHarmony**应都为 ok 标识，若两处提示缺少环境，按提示补上相应环境即可。

2. 创建工程与编译命令，编译产物在\<projectName\>/ohos/entry/build/default/outputs/default/entry-default-signed.hap 下。

   ```
   # 创建工程
   flutter create --platforms ohos <projectName>

   # 进入工程根目录编译
   # 示例：flutter build hap [--target-platform ohos-arm64] [--local-engine=<DIR>/src/out/ohos_release_arm64] --release
   flutter build hap --release
   ```

3. 通过`flutter devices`指令发现 ohos 设备之后，使用 `hdc -t <deviceId> install <hap file path>`进行安装。

4. 也可直接使用下列指令运行：

```
   # 示例：flutter run [--local-engine=<DIR>/src/out/ohos_debug_unopt_arm64] -d <device-id>
   flutter run --debug -d <device-id>
```

5. 构建 app 包命令：

```
   # 示例：flutter build app --release [--local-engine=<DIR>/src/out/ohos_release_arm64]  local-engine为可选项
   flutter build app --release
```

## 已兼容 OpenHarmony 开发的指令列表

| 指令名称   | 指令描述             | 使用说明                                                                                                             |
| ---------- | -------------------- | -------------------------------------------------------------------------------------------------------------------- |
| doctor     | 环境检测             | flutter doctor                                                                                                       |
| config     | 环境配置             | flutter config --\<key\> \<value\>                                                                                   |
| create     | 创建新项目           | flutter create --platforms ohos,android,ios --org \<org\> \<appName\>                                                |
| create     | 创建 module 模板     | flutter create -t module \<module_name\>                                                                             |
| create     | 创建 plugin 模板     | flutter create -t plugin --platforms ohos,android,ios \<plugin_name\>                                                |
| create     | 创建 plugin_ffi 模板 | flutter create -t plugin_ffi --platforms ohos,android,ios \<plugin_name\>                                            |
| devices    | 已连接设备查找       | flutter devices                                                                                                      |
| install    | 应用安装             | flutter install -t \<deviceId\> \<hap 文件路径\>                                                                     |
| assemble   | 资源打包             | flutter assemble                                                                                                     |
| build      | 测试应用构建         | flutter build hap --debug [--target-platform ohos-arm64] [--local-engine=\<兼容 ohos 的 debug engine 产物路径\>]     |
| build      | 正式应用构建         | flutter build hap --release [--target-platform ohos-arm64] [--local-engine=\<兼容 ohos 的 release engine 产物路径\>] |
| run        | 应用运行             | flutter run [--local-engine=\<兼容 ohos 的 engine 产物路径\>]                                                        |
| attach     | 调试模式             | flutter attach                                                                                                       |
| screenshot | 截屏                 | flutter screenshot                                                                                                   |

附：[Flutter 三方库适配计划](https://docs.qq.com/sheet/DVVJDWWt1V09zUFN2)

## 常见问题

1. 切换 FLUTTER_STORAGE_BASE_URL 后需删除\<flutter\>/bin/cache 目录，并在项目中执行 flutter clean 后再运行

2. 若出现报错：`The SDK license agreement is not accepted`，参考执行以下命令后再次编译：

   ```
   ./ohsdkmgr install ets:9 js:9 native:9 previewer:9 toolchains:9 --sdk-directory='/home/xc/code/sdk/ohos-sdk/' --accept-license
   ```

3. 如果你使用的是 DevEco Studio 的 Beta 版本，编译工程时遇到“must have required property 'compatibleSdkVersion', location: demo/ohos/build-profile.json5:17:11"错误，请参考《DevEco Studio 环境配置指导.docx》中的‘6 创建工程和运行 Hello World’【配置插件】章节修改 hvigor/hvigor-config.json5 文件。

4. 若提示安装报错：`fail to verify pkcs7 file` 请执行指令

   ```
   hdc shell param set persist.bms.ohCert.verify true
   ```

5. linux 虚拟机通过 hdc 无法直接发现 OpenHarmony 设备

   解决方案：在 windows 宿主机中，开启 hdc server，具体指令如下：

   ```
   hdc kill
   hdc -s serverIP:8710 -m
   ```

   在 linux 中配置环境变量：

   ```
   HDC_SERVER=<serverIP>
   HDC_SERVER_PORT=8710
   ```

   配置完成后 flutter sdk 可以通过 hdc server 完成设备连接，也可参考[官方指导](https://docs.openharmony.cn/pages/v4.0/zh-cn/device-dev/subsystems/subsys-toolchain-hdc-guide.md/#hdc-client%E5%A6%82%E4%BD%95%E8%BF%9C%E7%A8%8B%E8%AE%BF%E9%97%AEhdc-server)。

6. 构建 Hap 任务时报错：Error: The hvigor depends on the npmrc file. Configure the npmrc file first.

   请在用户目录`~`下创建文件`.npmrc`，该配置也可参考[DevEco Studio 官方文档](https://developer.harmonyos.com/cn/docs/documentation/doc-guides-V3/environment_config-0000001052902427-V3)，编辑内容如下：

   ```
   registry=https://repo.huaweicloud.com/repository/npm/
   @ohos:registry=https://repo.harmonyos.com/npm/
   ```

7. 查日志时，存在日志丢失现象。
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

8. 若 Api11 Beta1 版本的机器上无法启动 debug 签名的应用，可以通过将签名换成正式签名，或在手机端打开开发者模式解决（步骤：设置->通用->开发者模式）

9. 如果报`Invalid CEN header (invalid zip64 extra data field size)`异常，请更换 Jdk 版本，参见[JDK-8313765](https://bugs.openjdk.org/browse/JDK-8313765)

10. 运行 debug 版本的 flutter 应用用到鸿蒙设备后报错（release 和 profile 版本正常）

    1. 报错信息: `Error while initializing the Dart VM: Wrong full snapshot version, expected '8af474944053df1f0a3be6e6165fa7cf' found 'adb4292f3ec25074ca70abcd2d5c7251'`
    2. 解决方案: 依次执行以下操作
       1. 设置环境变量 `export FLUTTER_STORAGE_BASE_URL=https://flutter-ohos.obs.cn-south-1.myhuaweicloud.com`
       2. 删除 <flutter>/bin/cache 目录下的缓存
       3. 执行 `flutter clean`，清除项目编译缓存
       4. 运行 `flutter run -d $DEVICE --debug`
    3. 补充信息: 运行 android 或 ios 出现类似错误，也可以尝试还原环境变量 FLUTTER_STORAGE_BASE_URL ，清除缓存后重新运行。

11. Beta2 版本的 ROM 更新后，不再支持申请有执行权限的匿名内存，导致 debug 运行闪退。
    1. 解决方案：更新 flutter_flutter 到 a44b8a6d (2024-07-25) 之后的版本。
    2. 关键日志：

         ```
         #20 at attachToNative (oh_modules/.ohpm/@ohos+flutter_ohos@g8zhdaqwu8gotysbmqcstpfpcpy=/oh_modules/@ohos/flutter_ohos/src/main/ets/embedding/engine/FlutterNapi.ets:78:32)
         #21 at attachToNapi (oh_modules/.ohpm/@ohos+flutter_ohos@g8zhdaqwu8gotysbmqcstpfpcpy=/oh_modules/@ohos/flutter_ohos/src/main/ets/embedding/engine/FlutterEngine.ets:144:5)
         #22 at init (oh_modules/.ohpm/@ohos+flutter_ohos@g8zhdaqwu8gotysbmqcstpfpcpy=/oh_modules/@ohos/flutter_ohos/src/main/ets/embedding/engine/FlutterEngine.ets:133:7)
         ```

12. 构建 Hap 命令直接执行`flutter build hap`即可，不再需要`--local-engine`参数，直接从云端获取编译产物。

13. 拉取代码出现文件名太长问题
执行 `git config --global core.longpaths true` 后，再尝试拉取。建议不管有没有遇到该问题，都配置这个选项。

14. [更多 FAQ](https://gitee.com/openharmony-sig/flutter_samples/blob/master/ohos/docs/08_FAQ/README.md)。
