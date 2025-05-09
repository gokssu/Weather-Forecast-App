# 🌦️ Weather Forecast App

Weather forecast app that fetches real-time weather data using the Open-
WeatherMap API. The app should display current weather, a 7-day forecast, and
detailed information for each day, such as temperature, humidity, wind speed,
and weather conditions.
📸 Screenshots
<img src="https://github.com/user-attachments/assets/ce85f5f3-9ee1-4cc6-b5e4-a7994309ba8f" width="200">
<img src="https://github.com/user-attachments/assets/8831c487-3d1d-4e70-babc-0077641aef09" width="200">
<img src="https://github.com/user-attachments/assets/9cc1758e-38b8-44dc-aa1b-c619b1adfe35" width="200">

<img src="https://github.com/user-attachments/assets/210d549c-a33f-4a3d-87ba-2aeb401f2956" width="200">

<img src="https://github.com/user-attachments/assets/1ce62dc4-1165-4cef-bb36-df53b7e4483f" width="200">

<img src="https://github.com/user-attachments/assets/d693edff-a58e-4ea7-a503-41029a23ea7e" width="200">

<img src="https://github.com/user-attachments/assets/d215933c-7ae4-43ec-92b5-5decd1b502e8" width="200">

<img src="https://github.com/user-attachments/assets/096e8070-04fb-4c34-bdeb-8f26d4e64d1a" width="200">

<img src="https://github.com/user-attachments/assets/7384c4eb-ae9f-4c1c-91de-8e372fab1738" width="200">

<img src="https://github.com/user-attachments/assets/42e504c9-af78-493b-af86-0bca64ba776f" width="200">
<img src="https://github.com/user-attachments/assets/a2d216cb-d384-4527-ae9a-56acff93f9ad" width="200">

<img src="https://github.com/user-attachments/assets/f62579e6-b90a-47b1-968e-53f97baa5691" width="200">

<img src="https://github.com/user-attachments/assets/beb3e725-8586-4d2e-90e0-b2a478c658e2" width="200">

# Structure:
🗄️Assets:  
Path: `Weather-Forecast-App/assets`  
This folder contains files used for the app icon, localization (language support), and images used throughout the application.

♻️Generated:
Path: `Weather-Forecast-App/generated` 
This Flutter project includes a separate `generated` package created using `flutter create --template=package`. It isolates all build_runner-related generated Dart files, such as `.g.dart` or `.freezed.dart`, from the main application code. This separation improves project structure and allows independent control over code generation, versioning, and rebuilds, without cluttering the main `lib` directory.

Lib:

 ✅Core:
 
 Path: `Weather-Forecast-App/lib/core` 

The `lib/core` directory contains core-level components shared throughout the application.  
It is organized as follows:

- `init/`: Application initialization logic includes environment setup, localization, and startup configurations.
- `providers/`: Commonly used global Riverpod providers like Dio, router, theme, and location providers.
- `theme/`: Custom theming structure including color schemes and text styles for consistent UI across the app.
- `utils/`: Utility files including enums, constants, and configuration helpers.
- `widgets/`: Reusable and shared widgets such as base layouts, navigation bars, dialogs, and search bars.

🧱Features:

Path: `Weather-Forecast-App/lib/features` 

The `lib/features` directory contains feature-specific modules of the application.  
Each feature is structured to include:

- `view/`: UI layer files include screens and widgets.
- `controller/`: Contains the business logic, including providers and repositories for API or data operations.
- `view_model/`: (Where applicable) Holds state management logic separated from the controller, often used for complex UI logic.
  
This modular structure promotes the separation of concerns, making the codebase easier to scale and maintain.

## 🚀 Getting Started

To set up and run this project locally, follow these steps:

1. **Clone the repository:**
   ```bash
   git clone https://github.com/your-username/Weather-Forecast-App.git
   cd Weather-Forecast-App
2. **Replace the keys:**
Path: `lib/core/utils/config.dart`

// TODO: Replace these with your actual API keys before running the project.

static const apiKeyOpenWeather = 'apiKeyOpenWeather';

static const apiKeyGooglePlace = 'apiKeyGooglePlace';
4. **Run:**

Run these steps: 

- On **Mac/Linux**, use:
   ```bash
  chmod +x setup.sh
   ./setup.sh
  flutter run

- On **Windows**, use:
  ```bat
   setup.bat
   flutter run

📦 Requirements
Flutter SDK

Dart

An OpenWeatherMap API key

Optionally: a Google Places API key for location input

