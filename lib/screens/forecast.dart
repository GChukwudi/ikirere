import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/weather_provider.dart';

class Forecast extends StatelessWidget {
  final String city;

  const Forecast({super.key, required this.city});

  @override
  Widget build(BuildContext context) {
    final weatherProvider = Provider.of<WeatherProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Forecast for $city'),
      ),
      body: Builder(
        builder: (context) {
          if (weatherProvider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (weatherProvider.forecast == null) {
            return const Center(child: Text('No forecast available'));
          }
          return ListView.builder(
            itemCount: weatherProvider.forecast!.length,
            itemBuilder: (context, index) {
              final forecast = weatherProvider.forecast![index];
              return ListTile(
                title: Text(forecast['dt_txt']),
                subtitle: Text('${forecast['main']['temp']}°C'),
              );
            },
          );
        },
      ),
    );
  }
}
