# E Commerce

This app is a e-commerce application developed on flutter. App contains two different screens.
  1) Home screen shows the list of products.
  2) Clicking on each product from Home screen navigates to Product specific screen where user can add an entry for the product.

Please find an APK file in example/apk directory to install and verify and I've attached my screenshots in example/screenshot directory.

In this app I've used two libraries from [pub.dev](https://pub.dev/)

- [Http: To make HTTP requests](https://pub.dev/packages/http)
- [Toast: To Show Toast message](https://pub.dev/packages/toast)

## Note:
01. In Second screen, the form validation will work only when the submit button is clicked. If the all the fields are valid, It'll show a success toast message and moves back to first screen.
02. In Second screen, the json data from pub.dev contains below entry for field "Width"
    {"caption":"Width","type":"int","mandatory":false,"defaultValue":"Yes","validationMessage":""}.
    As per "type" defition the value of the "Width" field is an integer value. However, the defaultValue specifies it as a "Yes" (a string value) and validationMessage as "empty". Since it is not a mandatory field, validation will not work here and you will oberse default value of "Yes" and upon edit, you will see only number can be typed.

## Getting Started

To run this Project, execute the following commands:
01. **flutter pub get** - This command gets all the dependencies listed in the pubspec.yaml file in the current working directory.
02. **flutter run** - To run this Flutter app on a connected device or simulator.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
