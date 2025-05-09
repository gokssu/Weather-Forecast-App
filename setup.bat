@echo off

echo 🧼 Running clean in generated package...
cd generated
flutter clean

echo 📦 Running pub get in generated package...
cd generated
flutter pub get

echo 🛠️  Running build_runner in generated package...
dart run build_runner build --delete-conflicting-outputs

cd ..
echo 🔄 Running pub get in main project...
flutter pub get

echo ✅ Setup complete. You can now run the app with:
echo    flutter run
pause
