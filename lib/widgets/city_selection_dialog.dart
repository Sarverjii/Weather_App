import 'package:flutter/material.dart';
import 'package:weather_app/Data_Base/cities_list.dart'; // Import the cities list

class CitySelectionDialog extends StatefulWidget {
  final void Function(String, String) onCitySelected;

  const CitySelectionDialog({super.key, required this.onCitySelected});

  @override
  CitySelectionDialogState createState() => CitySelectionDialogState();
}

class CitySelectionDialogState extends State<CitySelectionDialog> {
  List<Map<String, String>> filteredCitiesList = citiesList;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_filterCities);
  }

  void _filterCities() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      filteredCitiesList = citiesList
          .where((city) => city['city']!.toLowerCase().contains(query))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Select City'),
      content: SizedBox(
        width: double.maxFinite,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _searchController,
                decoration: const InputDecoration(
                  labelText: 'Search City',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              // Wrap ListView.builder with an expanded container to manage height
              SizedBox(
                height: 300, // Adjust height as needed
                child: ListView.builder(
                  itemCount: filteredCitiesList.length,
                  itemBuilder: (context, index) {
                    final city = filteredCitiesList[index];
                    return CityListTile(
                      city: city['city']!,
                      countryCode: city['countryCode']!,
                      onCitySelected: widget.onCitySelected,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Close the dialog
          },
          child: const Text('Cancel'),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}

class CityListTile extends StatelessWidget {
  final String city;
  final String countryCode;
  final void Function(String, String) onCitySelected;

  const CityListTile({
    super.key,
    required this.city,
    required this.countryCode,
    required this.onCitySelected,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text('$city, $countryCode'),
      onTap: () {
        onCitySelected(city, countryCode);
        Navigator.of(context).pop(); // Close the dialog
      },
    );
  }
}
