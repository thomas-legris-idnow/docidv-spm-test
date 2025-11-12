# DocIDV - IDnow

[![Platform](https://img.shields.io/badge/Platform-iOS-brightgreen.svg)](https://developer.apple.com/ios/)
[![Swift](https://img.shields.io/badge/Swift-5.9-blue.svg)](https://developer.apple.com/swift/)
[![iOS](https://img.shields.io/badge/iOS-14.0-red.svg)](https://developer.apple.com/swift/)
[![Swift Package Manager](https://img.shields.io/badge/Swift_Package_Manager-compatible-orange)](https://img.shields.io/badge/Swift_Package_Manager-compatible-orange)

## Table of Contents

- [About](#about)
- [Key Features](#key-features)
- [Requirements](#requirements)
- [Installation](#installation)
- [Integration](#integration)
  - [Starting the SDK](#starting-the-sdk)
  - [Handling the Result](#handling-the-result)
  - [Error Handling](#error-handling)
- [Customization](#customization)
- [Additional Features](#additional-features)

## About
Welcome to the IDnow DocIDV project. This repository provides the official Swift Package for the DocIDV iOS SDK, which enables you to capture identity documents using the device's camera, performing several security checks and offering various other features.

The DocIDV framework incorporates the IDnow platform into your iOS app. We offer two SDK variants as xcframeworks: one with the bank transfer feature (XS2A) and one without.

- **DocIDV**: The complete SDK including all features.
- **DocIDV-without-XS2A**: The SDK without the bank transfer functionality.

This guide provides detailed instructions on how to install, set up, and integrate the SDK.

## Key Features

* **OCR**: Identity document capture.
* **OTP**: Phone number verification.
* **Liveness**: Liveness check for a secure flow.
* **NFC**: NFC chip scanning.
* And many other features!

## Requirements

* **Xcode:** version 26.0 or higher.
* **Minimum deployment version:** iOS 14.0.
* **Swift:** 5.0.
* **NFC:** An NFC-enabled iPhone (iPhone 7 or newer models).

## Installation

Follow these steps to integrate the DocIDV library into your application.

### Import SDK

The DocIDV SDK is available exclusively through Swift Package Manager (SPM).
1. Copy the official SPM repository URL: `https://github.com/idnow/docidv-sdk-ios`
2. In Xcode, navigate to `File` > `Add Package Dependencies...` and paste the URL.
3. Choose the desired package version. We recommend selecting "Up to Next Major Version" to receive compatible updates automatically. Click `Add Package`.
4. Add one of the two Package Products to your application's target: `DocIDV` or `DocIDV-without-XS2A`. Here is how it will look in Xcode:

![package_target_selection](./img/package_target_selection.png)

5. Click `Add Package`.

📥 DocIDV is now imported into your project.
Note that Xcode has also imported several other libraries that our SDK depends on. You will find them in the `Package Dependencies` list in the Project Navigator.

### Configure Your App

To use our SDK, you need to configure your project to allow the use of the camera and NFC.

#### Entitlements File

1. Open your entitlements file (If you don't already have one, File > New File > Property List, and name it, e.g., `YourApp.entitlements`).
2. Add a new key `Near Field Communication Tag Reader Session Formats` of type `Array`.
3. In this array, add an item:
    - key: `Item 0 (Near Field Communication Tag Reading Session Format)`
    - value: `Tag-Specific Data Protocol (TAG)`

#### Info.plist File

1. Open your main `Info.plist` file.
2. Add a new key `ISO7816 application identifiers for NFC Tag Reader Session` of type `Array`.
3. Add the following two strings to this array:
   - `A00000045645444C2D3031`
   - `A0000002471001`
4. Add an entry for `Privacy - NFC Scan Usage Description` that describes why your app needs to use NFC.
5. Add an entry for `Privacy - Camera Usage Description` that describes why your app needs to use the camera.
6. Add an entry for `Privacy - Photo Library Usage Description` that describes why your app needs to store photos on the device.
7. If you use the video call feature, please add `Privacy - Microphone Usage Description` that describes the use of the microphone for calls with an agent.

👏 You are now ready to integrate the DocIDV SDK.

## Integration
### Starting the SDK
Here is an example of how to launch the SDK from your host app:

```swift
func startDocIDV() {
    IDnowDocIDV.shared.start(
        token: "YOUR_TOKEN",
        fromViewController: self,
        listener: { [weak self] (result: IDnowDocIDV.IdentResult.type, statusCode: IDnowDocIDV.IdentResult.statusCode, message: String) in 
            // Handle the result here 
    })
}
```
This code calls the main `start` method to launch the DocIDV library. It takes several parameters:

| Parameter | Type | Description |
|---|---|---|
| `token` | `String` | The identification token provided for the session. |
| `isRoutedSession` | `Bool` | Boolean which can be set by customers to allow resuming an ident that was started from another side. |
| `preferredLanguage` | `String` | The preferred language code for the SDK, e.g., `"fr"`. Defaults to English (`"en"`) if not specified. |
| `bindingKey` | `String` | Used for device binding use cases. It helps establish a correlation between a user's verified identity and their mobile device. This is particularly useful for device authentication and re-authentication scenarios. The `bindingKey` for a completed identification can be fetched via an API endpoint and compared with the one used during SDK initialization. |
| `fromViewController` | `UIViewController` | The view controller that will present the SDK. It is also used to determine the appearance mode (light/dark) from your app. |
| `listener` | `IDnowDocIDVResultListener` | A callback used to receive the result of the identification session, providing a result type and a status code. |

### Handling the Result

Ensure the SDK is started with the `listener` callback to handle the session's outcome:

```swift
switch result {
    case .ERROR:
        print("Session finished with error. Status code: \(statusCode), Message: \(message)")
    case .CANCELLED:
        print("Session cancelled by user. Status code: \(statusCode), Message: \(message)")
    case .FINISHED:
        print("Session finished successfully.")
    default:
        break
}       
```

### Error Handling
#### All Error Codes
When the result is `.ERROR`, the `statusCode` will indicate the specific issue. Here is the enum describing each case:
```swift
public enum statusCode: Int {
    case E10 = 10      // Default Error
    case E100 = 100    // Token format incorrect
    case E101 = 101    // Token not found (404 on get-info call)
    case E102 = 102    // Token expired or already used (410 on get-info call)
    case E103 = 103    // Identification already completed (412 on start call)
    case E110 = 110    // Failed to parse ident-info response
    case E111 = 111    // Server error on ident-info call
    // ... and so on for the other error codes
    case E170 = 170    // Backend forced websocket closure (e.g., timeout)
    case E171 = 171    // Backend sent PROCESS_FAILED command
    case EUnreachable = 1000 // Network unreachable
}
```
*(Note: The full list of error codes is provided in the SDK for detailed handling.)*

#### Handling Specific Errors
*   For `E102` (Token expired), it is recommended to request a new identification token and restart the process.
*   For `E103` (Already completed), it is recommended to inform the user that they have already submitted all required information and should wait for the final result.
*   For `E170` (Timeout), it is recommended to notify the user that the session timed out or was started on a different device and ask them to try again.
*   For all other error codes, it is recommended to show a generic error message and ask the user to try restarting the process.

🎉 That's it! DocIDV can now be launched from your host app.

## Additional Features
### Dark Mode
Each screen of the SDK natively supports dark mode. It automatically adopts your app's appearance settings (light, dark, or system default).

### Localization
The SDK supports multiple languages (ISO 639-1). The list of supported languages is provided below:

English, Arabic, Bulgarian, Czech, Danish, German, Spanish, Estonian, Finnish, French, Gujarati, Croatian, Hungarian, Italian, Dutch, Punjabi, Polish, Portuguese, Romanian, Russian, Slovak, Serbian, Swedish, Turkish, Ukrainian.