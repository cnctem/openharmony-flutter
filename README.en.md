Flutter SDK Repository
==============

Source of the original repository: https://github.com/flutter/flutter

## Repository Description
This repository is an extension of the Flutter SDK for compatibility with OpenHarmony. It allows IDEs or terminals to use Flutter Tools instructions to compile and build OpenHarmony applications.

## Development Documentation
[Flutter_samples](https://gitee.com/openharmony-sig/flutter_samples/tree/master/ohos/docs)

## Environment Dependencies

* Development system

  Linux, macOS, or Windows that supports the Flutter Tools instructions.

* Development restrictions

  For Windows, the Flutter project and the dependent plugin project must be in the same disk.

* Environment configuration
   **Download the supporting development kits from [HarmonyOS SDK](https://developer.huawei.com/consumer/en/develop).**
   *For Unix-like systems (Linux and macOS), you can refer to the environment variable configuration below. For Windows, set environment variables by following the instructions provided in "Edit System Environment Variables."*

  1. Configure the HarmonyOS SDK and the environment variables.
   * API 12, DevEco Studio 5.0, or command-line-tools-5.0.
   * Download JDK 17 and configure environment variables.

        ```sh
        # macOS environment
        export JAVA_HOME=<JAVA_HOME path>/Contents/Home
        export PATH=$JAVA_HOME/bin:$PATH

        # Windows environment
        JAVA_HOME = <JAVA_HOME path>
        PATH=%JAVA_HOME%\bin
        ```

   * Configure the environment variables (SDK, node, ohpm, and hvigor).

        ```sh
        # macOS environment
        export TOOL_HOME=/Applications/DevEco-Studio.app/Contents # macOS environment
        export DEVECO_SDK_HOME=$TOOL_HOME/sdk # command-line-tools/sdk
        export PATH=$TOOL_HOME/tools/ohpm/bin:$PATH # command-line-tools/ohpm/bin
        export PATH=$TOOL_HOME/tools/hvigor/bin:$PATH # command-line-tools/hvigor/bin
        export PATH=$TOOL_HOME/tools/node/bin:$PATH # command-line-tools/tool/node/bin

        # Windows environment
        TOOL_HOME = D:\devecostudio-windows\DevEco Studio
        DEVECO_SDK_HOME=%TOOL_HOME%\sdk
        PATH=%TOOL_HOME%\tools\ohpm\bin
        PATH=%TOOL_HOME%\tools\hvigor\bin
        PATH=%TOOL_HOME%\tools\node
        ```

  2. Use a code editor to download the current repository code by running `git clone https://gitee.com/openharmony-sig/flutter_flutter.git`, specify the dev or master branch, and set up the environment.

        ```sh
        export PUB_CACHE=D:/PUB
        export PATH=<flutter_flutter path>/bin:$PATH
        export PUB_HOSTED_URL=https://pub.flutter-io.cn
        export FLUTTER_STORAGE_BASE_URL=https://storage.flutter-io.cn
        ```

   3. The code snippet below shows how to configure all the preceding environment variables. Use the actual username and code paths in practice.

        ```sh
        #Dependency cache
        export PUB_CACHE=D:/PUB (custom path)

        # Mirror inside China
        export PUB_HOSTED_URL=https://pub.flutter-io.cn
        export FLUTTER_STORAGE_BASE_URL=https://storage.flutter-io.cn

        # flutter_flutter/bin directory pulled from Gitee
        export PATH=/home/<user>/ohos/flutter_flutter/bin:$PATH

        # HamonyOS SDK
        export TOOL_HOME=/Applications/DevEco-Studio.app/Contents # macOS environment
        export DEVECO_SDK_HOME=$TOOL_HOME/sdk # command-line-tools/sdk
        export PATH=$TOOL_HOME/tools/ohpm/bin:$PATH # command-line-tools/ohpm/bin
        export PATH=$TOOL_HOME/tools/hvigor/bin:$PATH # command-line-tools/hvigor/bin
        export PATH=$TOOL_HOME/tools/node/bin:$PATH # command-line-tools/tool/node/bin
        ```

## How to Build

1. Run `flutter doctor -v` to check whether the environment variable configuration is correct. The check results for both Flutter and OpenHarmony should be **ok**. If there are any prompts indicating missing environment variable configuration, follow the prompts to configure the environment.

2. Create a project.

   ```
    # Create a project.
    flutter create --platforms ohos <projectName>
   ```

3. Build the HAP file. The build product is stored in **\<projectName\>/ohos/entry/build/default/outputs/default/entry-default-signed.hap**.

   ```
    # Enter the root directory of the project and build the project.
    # Example: flutter build hap [--target-platform ohos-arm64] --release
    flutter build hap --release
   ```

4. Install the application. Execute `flutter devices` instruction to discover a real device and install the application on the real device.

   Method 1: Go to the build product directory and install the application on the device.
   ```sh
   hdc -t <deviceId> install <hap file path>
   ```

   Method 2: Go to the project directory and run the application to install it on the device.
   ```sh
   flutter run --debug -d <deviceId>
   ```

5. Build the application using the following instruction:
   ```
    # Example: flutter build app --release
    flutter build app --release
   ```

## Release Notes
 - [3.7.12-ohos-1.0.3 Release](/release-notes/Flutter%203.7.12-ohos%201.0.3%20ReleaseNote.en.md)
 - [3.7.12-ohos-1.0.2 Release](/release-notes/Flutter%203.7.12-ohos%201.0.2%20ReleaseNote.en.md)
 - [3.7.12-ohos-1.0.1 Release](/release-notes/Flutter%203.7.12-ohos%201.0.1%20ReleaseNote.en.md)
 - [3.7.12-ohos-1.0.0 Release](/release-notes/Flutter%203.7.12-ohos%201.0.0%20ReleaseNote.en.md)

## Instruction List Compatible with OpenHarmony
| Instruction| Description| How to Use                                                             |
| ------- | ------- |-------------------------------------------------------------------|
| doctor | Detects the environment. | flutter doctor                                                    |
| config | Configures the environment.| flutter config --\<key\> \<value\>                                |
| create | Creates a project.| flutter create --platforms ohos,android,ios --org \<org\> \<appName\> |
| create | Creates a module template.| flutter create -t module \<module_name\> |
| create | Creates a plugin template.| flutter create -t plugin --platforms ohos,android,ios \<plugin_name\> |
| create | Creates a plugin_ffi template.| flutter create -t plugin_ffi --platforms ohos,android,ios \<plugin_name\> |
| devices | Searches for connected devices.| flutter devices                                                   |
| install | Installs an application.| flutter install -t \<deviceId\> \<hap file path\>                                                  |
| assemble | Pack resources.| flutter assemble                                                  |
| build  | Builds the test application.| flutter build hap --debug [--target-platform ohos-arm64]      |
| build  | Builds the formal application.| flutter build hap --release [--target-platform ohos-arm64]   |
| run    | Runs the application.| flutter run                |
| attach | Enters debug mode.| flutter attach                                                    |
| screenshot | Takes a screenshot.| flutter screenshot                                                 |
| pub | Obtains the dependencies.| flutter pub get                                                 |
| clean | Clears the project dependencies.| flutter clean                                                 |
| cache | Clears global cache data.| flutter pub cache clean                                                  |

Appendix: [Flutter Third-Party Library Adaptation Program](https://docs.qq.com/sheet/DVVJDWWt1V09zUFN2)


## FAQs

1. The emulator can be only debugged on macOS (ARM64).

2. After switching to **FLUTTER_STORAGE_BASE_URL**, you need to delete the **\<flutter\>/bin/cache** directory and execute **flutter clean** in the project before running the project.

3. The message `Error: The hvigor depends on the npmrc file. Configure the npmrc file first.` is displayed when building the HAP.

   Solution: Create the `.npmrc` file in the `~` directory. For details about the configuration, see [DevEco Studio User Guide](https://developer.huawei.com/consumer/en/doc/harmonyos-guides-V2/environment_config-0000001052902427-V2). The file content is as follows:

    ```
    registry=https://repo.huaweicloud.com/repository/npm/
    @ohos:registry=https://repo.harmonyos.com/npm/
    ```

4. Logs are lost.
    Solution: Disable global logging and enable logging of your own domain.

    ```
    Step 1: Disable logging in all domains. (Printing for some special logs cannot be disabled.)
    hdc shell hilog -b X
    Step 2: Enable logging of your own domain.
    hdc shell hilog <level> -D <domain> 
    In the preceding instruction, \<level> indicates the log levels such as D, I, W, E, and F; \<domain> indicates the number before tag.
    Example:
    To print A00000/XComFlutterOHOS_Native logs, set `hdc shell hilog -b D -D A00000`.
    Note: The preceding settings become invalid after the device is restarted. If you want to continue using the settings, configure them again.
    ```
5. If the application with the debug signature cannot be started on a device of API 11 Beta1, replace the debug signature with a formal signature or enable the developer mode on the device. (Steps: Go to **Settings** > **General** > **Developer mode**.)

6. If the message `Invalid CEN header (invalid zip64 extra data field size)` is reported, replace the JDK version. For details, see [JDK-8313765](https://bugs.openjdk.org/browse/JDK-8313765).

7. An error is reported when a Flutter application of the debug version is running on the HarmonyOS device. (The applications of the release and profile versions are running properly.)
    1. Error message: `Error while initializing the Dart VM: Wrong full snapshot version, expected '8af474944053df1f0a3be6e6165fa7cf' found 'adb4292f3ec25074ca70abcd2d5c7251'`
    2. Solution:
        1. Set the environment variables: `export FLUTTER_STORAGE_BASE_URL=https://flutter-ohos.obs.cn-south-1.myhuaweicloud.com`.
        2. Delete the cache in the **\<flutter>/bin/cache** directory.
        3. Execute `flutter clean` to clear the project build cache.
        4. Run `flutter run -d $DEVICE --debug`.
    3. Supplementary information: If a similar error occurs when the application runs on an Android or iOS device, you can restore the environment variable **FLUTTER_STORAGE_BASE_URL**, clear the cache, and run the application again.

8. Updated ROM of Beta2 no longer supports anonymous memory with the execution permission. As a result, debugging crashes.
   1. Solution: Update **flutter_flutter** to a version later than a44b8a6d (2024-07-25).
   2. Key logs:

    ```
    #20 at attachToNative (oh_modules/.ohpm/@ohos+flutter_ohos@g8zhdaqwu8gotysbmqcstpfpcpy=/oh_modules/@ohos/flutter_ohos/src/main/ets/embedding/engine/FlutterNapi.ets:78:32)
    #21 at attachToNapi (oh_modules/.ohpm/@ohos+flutter_ohos@g8zhdaqwu8gotysbmqcstpfpcpy=/oh_modules/@ohos/flutter_ohos/src/main/ets/embedding/engine/FlutterEngine.ets:144:5)
    #22 at init (oh_modules/.ohpm/@ohos+flutter_ohos@g8zhdaqwu8gotysbmqcstpfpcpy=/oh_modules/@ohos/flutter_ohos/src/main/ets/embedding/engine/FlutterEngine.ets:133:7)
    ```

9. Run the `flutter build hap` instruction to build an HAP file without using the parameter of `--local-engine`. You can obtain the build product from the cloud.

10. After the environment is configured, crash occurs when execute the `flutter` instruction.
    1. Solution: Add the Git environment variable configuration to the Windows environment.

    ```
    export PATH=<git path>/cmd:$PATH
    ```

11. The `flutter pub cache clean` instruction is executed successfully, but an error is reported when the `flutter clean` instruction is executed. In this case, executing the `update` instruction according to the error message does not take effect.
    1. Solution: Add comment to the configuration in the **build.json5** file. For example, "modules": [{ // Delete the entire object corresponding to the error}].
    2. Error message:

    ```
    #Parse ohos module. json5 error: Exception: Cannot found module.json5 at
    #D:\pub_cache\git\flutter_packages-b00939bb44d018f0710d1b080d91dcf4c34ed06\packages\video_player\video_player_ohos\ohossrc\main\module.json5.
    #You need to update the Flutter plugin project structure.
    #See
    #https://gitee.com/openharmony-sig/flutter_samples/tree/master/ohos/docs/09_specifications/update_flutter_plugin_structure.md
    ```

12. A path verification error is reported when the `flutter build hap` instruction is executed.
    1. Solution:
        (1) Open the **ohos-project-build-profile-schema.json** file in the DevEco Studio installation path **D:\DevEco Studio\tools\hvigor\hvigor-ohos-plugin\res\schemas**.
        (2) Find the line that contains "pattern": "^(\\./|\\.\\./)[\\s\\S]+$" in the file and delete this line.
    2. Error message:

         ```
          #hvigor  ERROR: Schema validate failed.
          #        Detail: Please check the following fields.
          #instancePath: 'modules[1].scrPath',
          #keyword: 'pattern'
          #params: { pattern:'^(\\./|\\.\\./)[\\s\\S]+$' },
          #message: 'must match pattern "^(\\./|\\.\\./)[\\s\\S]+$"',
          #location: 'D:/work/videoplayerdemo/video_cannot_stop_at_background/ohos/build-profile.json:42:146'
         ```

13. An error is reported when the `flutter build hap` instruction is executed.
    1. Solution:<br>(1) Open the **core-module-model-impl.js** file in the DevEco Studio installation path **D:\DevEco Studio\tools\hvigor\hvigor-ohos-plugin\src\model\module**.
       (2) Modify the **findBelongProjectPath** method. (Administrator permission is required. You can save the method as a new copy and replace it.)
       ```
        findBelongProjectPath(e) {
          if (e === path_1.default.dirname(e)) {
             return this.parentProject.getProjectDir()
          }
        }
       ```
    2. Error message:

         ```
          # hvigor  ERROR: Cannot find belonging project path for module at D:\.
          # hvigor  ERROR:  BUILD FAILED in 2s 556ms.
          #Running Hvigor task assembleHap...
          #Oops; flutter has exited unexpectedly: "ProcessException: The command failed
          #  <Command: hvigorw --mode module -p module=video_player_ohos@default -p product=default assmbleHar --no-daemon"
          #A crash report has been written to D:\work\videoplayerdemo\video_cannot_stop_at_background\flutter_03.log.
         ```

14. In the **.ohos** project, errors are reported when the `flutter clean` and the `flutter pub get` instructions are executed.
    1. Solution: Delete the **.ohos** folder and execute the **flutter pub get** instruction again.
    2. Error message:

         ```
          Oops; flutter has exited unexpectedly: "PathNotFoundException: Cannot open file, path = 'D:\code\.ohos\build-profile.json5' (OS Error: Specified file not found, error = 2)".
          A crash report has been written to D:\code\flutter_01.log.
         ```

Reference: [FAQs] (https://gitee.com/openharmony-sig/flutter_samples/blob/master/ohos/docs/08_FAQ/README_EN.md)
