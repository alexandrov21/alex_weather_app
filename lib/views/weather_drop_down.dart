import 'package:flutter/material.dart';

class WeatherDropDown extends StatefulWidget {
  final ValueSetter<bool> onDropDownChanged;

  const WeatherDropDown({
    Key? key,
    required this.onDropDownChanged,
  }) : super(key: key);

  @override
  State<WeatherDropDown> createState() => _WeatherDropDownState();
}

class _WeatherDropDownState extends State<WeatherDropDown> {
  final List<String> _items = [
    'By hours',
    'By days',
  ];
  String? _selectedItem;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(32),
        ),
        color: Colors.black26,
      ),
      child: Padding(
        padding: const EdgeInsets.only(
          left: 12,
        ),
        child: _buildDropDownButton(),
      ),
    );
  }

  Widget _buildDropDownButton() {
    return DropdownButton<String>(
      dropdownColor: Colors.blueGrey,
      icon: const Icon(
        Icons.arrow_drop_down,
        color: Colors.white,
      ),
      style: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w500,
      ),
      hint: const Text(
        'Weather view',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w500,
        ),
      ),
      underline: const SizedBox(),
      items: _items
          .map(
            (item) => DropdownMenuItem<String>(
              value: item,
              child: Text(item),
            ),
          )
          .toList(),
      onChanged: (item) {
        _selectedItem = item;
        if(_selectedItem == 'By days'){
          widget.onDropDownChanged(true);
        }
        else{
          widget.onDropDownChanged(false);
        }
      },
      value: _selectedItem,
    );
  }
}
