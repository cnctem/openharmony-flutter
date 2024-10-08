## Version Overview
This version is Flutter OpenHarmony platform 1.0.1, based on Flutter 3.7.12 version. This version supports and enhances the platform-side capabilities of OpenHarmony, providing features such as large font accessibility, English documents, and third-party libraries. 

## Release scope
HarmonyOS NEXT, API12


## New features
- Support for large font capability in accessibility mode
- Provide English documentation
- Provide more third-party libraries 

## Release Date
September 29, 2024 

## Version Compatibility 

- ROM: 205.0.0.68
- IDE: DevEco Studio 5.0.3.810
- SDK: OpenHarmony 5.0.0.68
- Flutter SDK: 3.7.12-ohos-1.0.1 

## Development Documentation

- [Documentation Link](https://gitee.com/openharmony-sig/flutter_samples/tree/master/ohos/docs) 

## Third-party library list

|Library Name|Address|
|:----|:----|
|yfree|https://gitee.com/openharmony-sig/fluttertpc_flutter_yfree|
|r_upgrade|https://gitee.com/openharmony-sig/fluttertpc_r_upgrade|
|flutter_custom_cursor|https://gitee.com/openharmony-sig/fluttertpc_flutter_custom_cursor|
|scan|https://gitee.com/openharmony-sig/fluttertpc_scan|
|flutter_downloader|https://gitee.com/openharmony-sig/fluttertpc_flutter_downloader|
|open_app_settings|https://gitee.com/openharmony-sig/fluttertpc_open_app_settings|
|mobile_scanner|https://gitee.com/openharmony-sig/fluttertpc_mobile_scanner|
|flutter_qr_reader|https://gitee.com/openharmony-sig/fluttertpc_flutter_qr_reader|
|open_filex|https://gitee.com/openharmony-sig/fluttertpc_open_filex|
|auto_orientation|https://gitee.com/openharmony-sig/fluttertpc_auto_orientation|
|flutter_filereader|https://gitee.com/openharmony-sig/fluttertpc_flutter_filereader|
|flutter_phone_direct_caller|https://gitee.com/openharmony-sig/fluttertpc_flutter_phone_direct_caller|
|media_info|https://gitee.com/openharmony-sig/fluttertpc_media_info|
|get|https://gitee.com/openharmony-sig/fluttertpc_get|
|catcher|https://gitee.com/openharmony-sig/fluttertpc_catcher|
|flutter_document_picker|https://gitee.com/openharmony-sig/fluttertpc_flutter_document_picker|
|flutter_keychain|https://gitee.com/openharmony-sig/fluttertpc_flutter_keychain|
|flutter_udid|https://gitee.com/openharmony-sig/fluttertpc_flutter_udid|
|r_scan|https://gitee.com/openharmony-sig/fluttertpc_r_scan|
|pdf_viewer_plugin|https://gitee.com/openharmony-sig/fluttertpc_pdf_viewer_plugin|
|flutter_keychain|https://gitee.com/openharmony-sig/fluttertpc_flutter_keychain|
|audio_service|https://gitee.com/openharmony-sig/fluttertpc_audio_service|

Fixes:
- When using multiple PlatformViews in a hybrid app with native integration, the second page will not update the first PlatformView page when returning and returning to it.
- Resolves the crashing issue when running in debug mode.