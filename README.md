# Weather App

A simple and elegant weather application built using Flutter, utilizing the [OpenWeatherMap API](https://openweathermap.org/api) to fetch and display current weather data, including temperature, humidity, wind speed, and more.

## Features

- Display current weather for any location
- Sunrise and sunset times
- Weather icons and descriptions
- Light and dark themes

## Screenshots

![Light Theme](https://github.com/user-attachments/assets/4d8f820b-0539-4a05-b18b-03add0a6644c)
![Dark Theme](https://github.com/user-attachments/assets/7e154bfb-3b31-4fd5-94c3-122288d1e2ef)

<p align="center">
  <img src="https://github.com/rohittelgote23/weather_app_flutter/raw/main/screenshots/light_theme.png" alt="Light Theme" width="250" height="500">
  <img src="https://github.com/rohittelgote23/weather_app_flutter/raw/main/screenshots/dark_theme.png" alt="Dark Theme" width="250" height="500">
</p>

## Installation

1. **Clone the repository**:

    ```bash
    git clone https://github.com/rohittelgote23/weather_app_flutter.git
    cd weather_app_flutter
    ```

2. **Install dependencies**:

    ```bash
    flutter pub get
    ```

3. **Set up the OpenWeatherMap API**:

    - Sign up for a free API key at [OpenWeatherMap](https://home.openweathermap.org/users/sign_up).
    - Create a `.env` file in the root of the project and add your API key:

      ```bash
      API_KEY=your_openweathermap_api_key
      ```

4. **Run the app**:

    ```bash
    flutter run
    ```

## Usage

- Enter the name of a city to get the current weather data.
- Toggle between Celsius and Fahrenheit using the settings menu.
- Enjoy the app in both light and dark modes.

## Folder Structure

```plaintext
lib/
│
├── main.dart             # Entry point of the application
├── models/               # Data models for weather data
├── services/             # API service for fetching weather data
├── screens/              # Different screens (Home, Settings)
└── widgets/              # Reusable widgets (WeatherCard, ThemeToggle)
