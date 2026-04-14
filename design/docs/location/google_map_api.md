# 🗺️ Setting up Google Maps API for Flutter

To use Google Maps in this application, you must obtain an API Key from the Google Cloud Console and configure it for each platform.

---

## Step 1: Create a Google Cloud Project
1. Go to the [Google Cloud Console](https://console.cloud.google.com/).
2. Create a new project or select an existing one.
3. Search for **"APIs & Services"** in the sidebar.

---

## Step 2: Enable the Maps SDKs
In the **Library** section of "APIs & Services", search for and enable the following:
*   **Maps SDK for Android**
*   **Maps SDK for iOS**
*   *Optional but recommended:* **Places API** and **Geocoding API**.

---

## Step 3: Create an API Key
1. Go to **APIs & Services > Credentials**.
2. Click **Create Credentials > API key**.
3. Copy your API Key.

### 🛑 Security Best Practice: Restrict your API Key
*   Under **API restrictions**, select "Restrict key".
*   In the dropdown, select "Maps SDK for Android" and "Maps SDK for iOS".
*   Under **Application restrictions**, add your package name and SHA-1 certificate fingerprint for Android, and Bundle ID for iOS.

---

## Step 4: Configure Flutter App

### 🤖 Android Setup
Add your API key inside the `<application>` tag in `android/app/src/main/AndroidManifest.xml`:

```xml
<meta-data 
    android:name="com.google.android.geo.API_KEY"
    android:value="YOUR_API_KEY_HERE"/>
```

### 🍎 iOS Setup
Edit `ios/Runner/AppDelegate.swift` (or `AppDelegate.m`) to include your API key:

**AppDelegate.swift:**
```swift
import UIKit
import Flutter
import GoogleMaps // Import this

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GMSServices.provideAPIKey("YOUR_API_KEY_HERE") // Add this line
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
```

---

## Step 5: Verify the setup
Restart your Flutter app using:
```bash
flutter clean
flutter pub get
flutter run
```
