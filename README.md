# Food App (Flutter + GetX + Firebase)

## Setup steps
1. Project folder me terminal kholein aur chalayein:
   flutter create .          # android/ios folders bana dega (lib/ aur pubspec same rehte hain)
2. flutter pub get
3. Firebase:
   dart pub global activate flutterfire_cli
   flutterfire configure     # apna Firebase project select karein -> firebase_options.dart ban jayegi
4. Firebase Console me:
   - Authentication -> Sign-in method -> **Email/Password** enable
   - Firestore Database -> Create database (test mode)
5. Figma se images export karke assets/images/ me rakhein (names lib/app/core/constants/app_assets.dart me hain)
6. flutter run
