import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/weather_provider.dart';
import 'forecast.dart';

class HomeScreen extends StatelessWidget {
  final TextEditingController _cityController = TextEditingController();

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final weatherProvider = Provider.of<WeatherProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather App'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _cityController,
              decoration: InputDecoration(
                hintText: 'Enter city name',
                border: const OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    weatherProvider.fetchCurrentWeather(_cityController.text);
                  },
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                weatherProvider.fetchCurrentWeather(_cityController.text);
              },
              child: const Text('Get Weather'),
            ),
            weatherProvider.isLoading
                ? const CircularProgressIndicator()
                : weatherProvider.currentWeather != null
                    ? Column(
                        children: [
                          Text(
                            "${weatherProvider.currentWeather!['name']} - ${weatherProvider.currentWeather!['weather'][0]['description']}",
                            style: const TextStyle(fontSize: 24),
                          ),
                          // const SizedBox(height: 20),
                          Text(
                            "${weatherProvider.currentWeather['main']['temp']}°C",
                            style: const TextStyle(fontSize: 48),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Forecast(
                                          city: _cityController.text)));
                            },
                            child: const Text('View Forecast'),
                          ),
                        ],
                      )
                    : const Text('No data available'),
          ],
        ),
      ),
    );
  }
}
