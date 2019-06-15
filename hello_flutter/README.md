# Add WebView widget in sample code

第一週的 workshop，帶大家操作 IDE，並且建立第一個 Flutter project，解釋裡面的 sample code，接著我們在裡面試著加上 [WebView widget](https://pub.dev/packages/webview_flutter)，將原本的累加頁面換成網頁。

## Getting Started

以下步驟以 Flutter Team 提供的 WebView libary 為例，說明如何找到並將 library 加到專案中。

### Step 1: Create a new Flutter project

兩個方式建立新專案

- Open Terminal and run following command
```
flutter create [project_name]
```
- Use Android Studio => start a new Flutter project


### Step 2: Find library

在 [pub.dev](https://pub.dev/) 這個網站搜尋 webview，找到 [webview_flutter](https://pub.dev/packages/webview_flutter)，這是由 Flutter Team 建立的 widget。  
以這個為範例，點選頁面中的 [installing](https://pub.dev/packages/webview_flutter#-installing-tab-) 可以知道如何加入到專案中。

### Step 3: Use this package as a library

1. Add this to your package's pubspec.yaml file
```
dependencies:
  webview_flutter: ^0.3.9+1
```

2. Run following command from the command line, or click 'Packages get' in Android Studio to install package
```
flutter pub get
```
  
3. Import it in your Dart code
```dart
import 'package:webview_flutter/webview_flutter.dart';
```

### Step 4: Add following code in main.dart
```dart
class MyWebViewWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('WebView demo'),
      ),
      body: WebView(
        initialUrl: 'https://flutter.dev',
        // JavaScript execution is not restricted.
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}
```

### Step 5: Replace MyHomePage() with MyWebViewWidget()
```dart
home: MyWebViewWidget(),
```

### Step 6: Add config for iOS
在 iOS / Runner / info.plist 加上下面設定，避免在 iOS 裝置上報錯
```xml
<key>io.flutter.embedded_views_preview</key>
<string>YES</string>
```

## Reference
- [如何在 Flutter 中使用 WebView？- 小女 Android 工程師實驗筆記](https://medium.com/@chloe.thhsu/%E5%A6%82%E4%BD%95%E5%9C%A8-flutter-%E4%B8%AD%E4%BD%BF%E7%94%A8-webview-%E5%B0%8F%E5%A5%B3-android-%E5%B7%A5%E7%A8%8B%E5%B8%AB%E5%AF%A6%E9%A9%97%E7%AD%86%E8%A8%98-75969b36abba)

## Demo

![Image](https://github.com/claireliu14/flutter_study_group/blob/master/screenshot/webview_demo.gif)
