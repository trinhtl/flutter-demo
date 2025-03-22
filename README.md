# This is a Flutter CRUD app can be run on iOS

## Prerequites:
- macOS
- Visual Studio Code
- XCode and iOS Simulator*
- Docker
- Java jdk 21

## To run the code, follow under instruction:
- Install flutter: https://docs.flutter.dev/get-started/install/macos/mobile-ios
- Open **crud_app** folder on Visual Studio Code, then choose **target device** as your simulator (ios > 11)
- Build backend service:
```bash
    cd backend
    mvn clean install
```
- Run database and api service:
```bash
  cd ..
  docker compose up --build -f backend/docker-compose.yaml -d
```
- Run Flutter app
```bash
  cd crud_app
  flutter clean
  cd ios
  pod install --repo-update
  cd crud_app
  flutter pub get
  flutter run
```

