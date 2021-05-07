# unweather
unweather allows you to view today’s temperature, weather forecast for the next 5 days and all weather data in detail.

The app is written using [Flutter](https://flutter.dev/) stable 2.0.5 and following the MVVM pattern.

unweather use the [OpenWeather API](https://openweathermap.org/api).
## Screenshots
<p>
<img src="./screenshots/1.png?raw=true" width="200">
<img src="./screenshots/2.png?raw=true" width="200">
</p>
<p>
<img src="./screenshots/3.png?raw=true" width="200">
<img src="./screenshots/4.png?raw=true" width="200">
</p>

## Video
[![unweather Video](https://img.youtube.com/vi/6nqumNbkSgE/0.jpg)](http://www.youtube.com/watch?v=6nqumNbkSgE)
## APP Mockup
In the project root you can find the [Adobe XD mockup](./unweather.xd) project, created before developing the app to have a guideline.
## APP Flow
unweather start by showing the weather forecast in Turin. Show hourly forecast for 12 hours, data on rain volume, humidity, wind speed, cloudiness, visibility, pressure and weather forecast for the next 5 days.
You can also change the city using the searchbar at the top.
The background color adapts according to the time of day.
## External libraries
External libraries used:
```
http: ^0.13.2
intl: ^0.17.0
flutter_svg: ^0.22.0
```
## Unit Tests
I wrote some tests for the ViewModel.
## Icons
 Some of the weather icons are from [Freebie: Weather icons](https://dribbble.com/shots/8565420-Freebie-Weather-icons), others were made by me.
