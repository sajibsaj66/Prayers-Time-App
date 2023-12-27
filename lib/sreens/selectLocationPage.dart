import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'bottomNavBar.dart';

class LocationSelectionPage extends StatefulWidget {
  const LocationSelectionPage({Key? key}) : super(key: key);

  @override
  _LocationSelectionPageState createState() => _LocationSelectionPageState();
}

class _LocationSelectionPageState extends State<LocationSelectionPage> {
  late String _selectedDivision ;
  late String _selectedDistrict;
  bool _dataLoaded = false;
  final List<String> _divisions = [
    'Dhaka',
    'Chattogram',
    'Rajshahi',
    'Khulna',
    'Barishal',
    'Sylhet',
    'Rangpur',
    'Mymensingh'
  ];

  final Map<String, List<String>> _districts = {
    'Dhaka': [
      'Dhaka',
      'Gazipur',
      'Narayanganj',
      'Manikganj',
      'Munshiganj',
      'Narsingdi',
      'Tangail',
      'Kishoreganj',
      'Faridpur',
      'Gopalganj',
      'Madaripur',
      'Rajbari',
      'Shariatpur',
      'Netrokona',
      'Sherpur',
      '',
    ],
    'Chattogram': [
      'Chattogram',
      'Cox\'s Bazar',
      'Rangamati',
      'Khagrachhari',
      'Bandarban',
      'Feni',
      'Noakhali',
      'Lakshmipur',
      'Chandpur',
      '',
    ],
    'Rajshahi': [
      'Rajshahi',
      'Bogura',
      'Joypurhat',
      'Naogaon',
      'Natore',
      'Chapainawabganj',
      'Pabna',
      'Sirajganj',
      '',
    ],
    'Khulna': [
      'Khulna',
      'Bagerhat',
      'Chuadanga',
      'Jashore',
      'Jhenaidah',
      'Kushtia',
      'Magura',
      'Meherpur',
      'Narail',
      'Satkhira',
      '',
    ],
    'Barishal': [
      'Barishal',
      'Barguna',
      'Bhola',
      'Jhalokati',
      'Patuakhali',
      'Pirojpur',
      '',
    ],
    'Sylhet': [
      'Habiganj',
      'Moulvibazar',
      'Sunamganj',
      'Sylhet',
      '',
    ],
    'Rangpur': [
      'Rangpur',
      'Dinajpur',
      'Gaibandha',
      'Kurigram',
      'Lalmonirhat',
      'Nilphamari',
      'Panchagarh',
      'Thakurgaon',
      '',
    ],
    'Mymensingh': [
      'Mymensingh',
      'Jamalpur',
      'Sherpur',
      'Netrokona',
      '',
    ],
  };

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_dataLoaded) {
      SharedPreferences.getInstance().then((prefs) {
        _selectedDivision =
            prefs.getString('selectedDivision') ?? _divisions.first;
        _selectedDistrict = prefs.getString('selectedDistrict') ??
            _districts[_selectedDivision]!.first;
        setState(() {
          _dataLoaded = true;
        });
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _selectedDivision = _divisions.first;
    _selectedDistrict = _districts[_selectedDivision]!.first;
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Your Location'),
      ),
      body: Container(
        height: screenSize,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              'assets/images/bg.jpg',
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: Card(
                margin: const EdgeInsets.all(24),
                elevation: 4,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      DropdownButtonFormField<String>(
                        decoration: const InputDecoration(
                          labelText: 'Select Division',
                          border: OutlineInputBorder(),
                        ),
                        value: _selectedDivision,
                        onChanged: (String? value) async {
                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          setState(() {
                            _selectedDivision = value!;
                            _selectedDistrict = '';
                          });
                          await prefs.setString(
                              'selectedDivision', _selectedDivision);
                        },
                        items: _divisions
                            .map((division) => DropdownMenuItem(
                                  value: division,
                                  child: Text(division),
                                ))
                            .toList(),
                      ),
                      const SizedBox(height: 16.0),
                      DropdownButtonFormField<String>(
                        decoration: const InputDecoration(
                          labelText: 'Select District',
                          border: OutlineInputBorder(),
                        ),
                        value: _selectedDistrict,
                        onChanged: (String? value) async {
                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          setState(() {
                            _selectedDistrict = value!;
                          });
                          await prefs.setString(
                              'selectedDistrict', _selectedDistrict);
                        },
                        items: _districts[_selectedDivision]!
                            .map((district) => DropdownMenuItem(
                                  value: district,
                                  child: Text(district),
                                ))
                            .toList(),
                      ),
                      const SizedBox(height: 16.0),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => BotomNavBar(
                                  district: _selectedDistrict,
                                  division: _selectedDivision,
                                ),
                              ),
                              (route) => false);
                          _selectedDistrict = _selectedDistrict;
                          _selectedDivision = _selectedDivision;
                        },
                        child: const Text('Get Prayer Times'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                elevation: 4,
                margin: const EdgeInsets.all(24),
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      ListTile(
                        title: Text(
                          " یٰۤاَیُّهَا الَّذِیۡنَ اٰمَنُوا اسۡتَعِیۡنُوۡا بِالصَّبۡرِ وَ الصَّلٰوۃِ ؕ اِنَّ اللّٰهَ مَعَ الصّٰبِرِیۡنَ",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text("(۱۵۳)سورة البقرة "),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      ListTile(
                        title: Text(
                            "হে বিশ্বাস স্থাপনকারীগণ! তোমরা ধৈর্য ও সালাতের মাধ্যমে সাহায্য প্রার্থনা কর; নিশ্চয়ই আল্লাহ ধৈর্যশীলগণের সাথে আছেন।"),
                        subtitle: Text("সূরাঃ আল-বাকারা (আয়াত নং - ১৫৩)"),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16.0),
          ],
        ),
      ),
    );
  }
}
