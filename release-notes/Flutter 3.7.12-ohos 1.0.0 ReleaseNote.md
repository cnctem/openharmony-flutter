## 版本概述
本版本为Flutter OpenHarmony平台1.0.0版本，基于Flutter 3.7.12版本适配。本版本支持和完善OpenHarmony平台侧能力，提供平台化Channel、外接纹理、云端SDK等特性，并优化性能。

## 发布范围
HarmonyOS NEXT, API12

## 新增特性
- 支持OpenHarmony平台Flutter Channel
- 支持OpenHarmony平台Flutter Engine
- 支持OpenHarmony平台Flutter命令行工具
- 支持外接纹理
- 支持云端SDK
- 官方库&三方库OpenHarmony平台适配

## 版本发布时间
2024年8月28日

## 版本配套
- ROM: 205.0.0.61(SP1C00E63R4P9) / NEXT.0.0.61(SP1C00E63R4P9)
- IDE: DevEco Studio 5.0.3.706
- SDK: HarmonyOS SDK 5.0.0.61(SP1)，API12
- Flutter SDK: 3.7.12-ohos-1.0.0

## 赋能文档

- [文档链接](https://gitee.com/openharmony-sig/flutter_samples/tree/master/ohos/docs)

## 三方库列表
- 官方库：

    [官方库链接](https://gitee.com/openharmony-sig/flutter_packages)

- 三方库：

    |三方库名称|仓库地址|
    |:----|:----|
    |sqflite|https://gitee.com/openharmony-sig/flutter_sqflite|
    |permission_handler|https://gitee.com/openharmony-sig/flutter_permission_handler|
    |fluttertoast|https://gitee.com/openharmony-sig/flutter_fluttertoast|
    |connectivity_plus|https://gitee.com/openharmony-sig/flutter_plus_plugins|
    |device_info_plus|https://gitee.com/openharmony-sig/flutter_plus_plugins|
    |package_info_plus|https://gitee.com/openharmony-sig/flutter_plus_plugins|
    |connectivity|https://gitee.com/openharmony-sig/flutter_plus_plugins|
    |package_info|https://gitee.com/openharmony-sig/flutter_plus_plugins|
    |audio_session|https://gitee.com/openharmony-sig/flutter_audio_session/|
    |flutter_native_image|https://gitee.com/openharmony-sig/flutter_native_image|
    |flutter_sound|https://gitee.com/openharmony-sig/flutter_sound|
    |image_gallery_saver|https://gitee.com/openharmony-sig/flutter_image_gallery_saver|
    |location|https://gitee.com/openharmony-sig/flutter_location|
    |power_image|https://gitee.com/openharmony-sig/flutter_power_image|
    |share_plus|https://gitee.com/openharmony-sig/flutter_plus_plugins|
    |wakelock|https://gitee.com/openharmony-sig/flutter_wakelock|
    |flutter_console|https://gitee.com/openharmony-sig/flutter_console|
    |audioplayers|https://gitee.com/openharmony-sig/flutter_audioplayers|
    |gpu_image|https://gitee.com/openharmony-sig/flutter_gpu_image|
    |image_crop|https://gitee.com/openharmony-sig/flutter_image_crop|
    |bitmap|https://gitee.com/openharmony-sig/flutter_bitmap|
    |leak_detector|https://gitee.com/openharmony-sig/flutter_leak_detector|
    |flutter_math_fork|https://gitee.com/openharmony-sig/flutter_math_fork|
    |flutter_contacts|https://gitee.com/openharmony-sig/flutter_contacts|
    |flutter_inappwebview|https://gitee.com/openharmony-sig/flutter_inappwebview|
    |flutter_keyboard_visibility|https://gitee.com/openharmony-sig/flutter_keyboard_visibility|
    |flutter_widget_from_html|https://gitee.com/openharmony-sig/flutter_widget_from_html|
    |mobile_scanner|https://gitee.com/openharmony-sig/fluttertpc_mobile_scanner|
    |device_util|https://gitee.com/openharmony-sig/fluttertpc_device_util|
    |export_video_frame|https://gitee.com/openharmony-sig/fluttertpc_export_video_frame|
    |flutter_local_notifications|https://gitee.com/openharmony-sig/fluttertpc_flutter_local_notifications|
    |flutter_phone_direct_caller|https://gitee.com/openharmony-sig/fluttertpc_flutter_phone_direct_caller|
    |flutter_screenshot_callback|https://gitee.com/openharmony-sig/fluttertpc_screenshot_callback|
    |flutter_sms|https://gitee.com/openharmony-sig/fluttertpc_flutter_sms|
    |media_info|https://gitee.com/openharmony-sig/fluttertpc_media_info|
    |orientation|https://gitee.com/openharmony-sig/fluttertpc_orientation|
    |recognition_qrcode|https://gitee.com/openharmony-sig/fluttertpc_recognition_qrcode|
    |video_compress|https://gitee.com/openharmony-sig/fluttertpc_video_compress|
    |share_extend|https://gitee.com/openharmony-sig/fluttertpc_share_extend|
    |catcher|https://gitee.com/openharmony-sig/fluttertpc_catcher|
    |flutter_mailer|https://gitee.com/openharmony-sig/fluttertpc_flutter_mailer|
    |gallery_saver|https://gitee.com/openharmony-sig/fluttertpc_gallery_saver|
    |flutter_localization|https://gitee.com/openharmony-sig/flutter_localization|
    |keyboard_actions|https://gitee.com/openharmony-sig/fluttertpc_keyboard_actions|
    |native_device_orientation|https://gitee.com/openharmony-sig/fluttertpc_native_device_orientation|
    |screen|https://gitee.com/openharmony-sig/fluttertpc_screen|
    |pdf_render|https://gitee.com/openharmony-sig/fluttertpc_pdf_render|


## 已知问题
- 多个PlatformView与原生混合开发时，打开第二个页面返回再返回第一个页面，第一个PlatformView页面不会更新