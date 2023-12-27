import 'package:flutter/material.dart';

import '../Api/ApiClint.dart';
import '../models/prayersTimeDataFromApi.dart';

class PrayerTimesPage extends StatefulWidget {
  final String division;
  final String district;

  const PrayerTimesPage(
      {super.key, required this.division, required this.district});

  @override
  _PrayerTimesPageState createState() => _PrayerTimesPageState();
}

class _PrayerTimesPageState extends State<PrayerTimesPage> {
  late Future<PrayerTimes> _futurePrayerTimes;

  @override
  void initState() {
    super.initState();
    _futurePrayerTimes = fetchPrayerTimes(widget.district, widget.division);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Prayer Times in ${widget.district}, ${widget.division}',
          style:  const TextStyle(
            fontSize: 15.0,
            color: Colors.yellow,
          ),
        ),
      ),
      body: Center(
        child: FutureBuilder<PrayerTimes>(
          future: _futurePrayerTimes,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final prayerTimes = snapshot.data!;

              return Column(
                children: <Widget>[
                  ListTile(
                    tileColor: Colors.red[100],
                    title: const Text('Fajr'),
                    trailing: Text('${prayerTimes.fajr} AM'),
                  ),
                  ListTile(
                    tileColor: Colors.orange[100],
                    title: const Text('Sunrise'),
                    trailing: Text('${prayerTimes.sunrise} AM'),
                  ),
                  ListTile(
                    tileColor: Colors.yellow[100],
                    title: const Text('Dhuhr'),
                    trailing: Text('${prayerTimes.dhuhr} PM'),
                  ),
                  ListTile(
                    tileColor: Colors.green[100],
                    title: const Text('Asr'),
                    trailing: Text('${prayerTimes.asr} PM'),
                  ),
                  ListTile(
                    tileColor: Colors.blue[100],
                    title: const Text('Maghrib'),
                    trailing: Text('${prayerTimes.maghrib} PM'),
                  ),
                  ListTile(
                    tileColor: Colors.blue[200],
                    title: const Text('Sunset'),
                    trailing: Text('${prayerTimes.sunset} PM'),
                  ),
                  ListTile(
                    tileColor: Colors.purple[100],
                    title: const Text('Isha'),
                    trailing: Text('${prayerTimes.isha} PM'),
                  ),
                ],
              );
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }
            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
