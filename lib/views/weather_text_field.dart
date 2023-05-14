import 'package:flutter/material.dart';

class WeatherTextField extends StatefulWidget {
  final ValueSetter<String> city;

  const WeatherTextField({
    Key? key,
    required this.city,
  }) : super(key: key);

  @override
  State<WeatherTextField> createState() => _WeatherTextFieldState();
}

class _WeatherTextFieldState extends State<WeatherTextField> {
  bool _isHide = true;
  void _onIconPressed(){
    setState(() {
      _isHide = !_isHide;
    });
  }
  IconData _getIconData() {
    if (_isHide) {
      return Icons.search;
    }
    return Icons.cancel;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          onPressed: _onIconPressed,
          icon: Icon(
            _getIconData(),
          ),
        ),
        if(!_isHide)
          _buildTextField(),
      ],
    );
  }

  Widget _buildTextField() {
    return Expanded(
      child: TextField(
        onSubmitted:(city) => widget.city(city),
        decoration: const InputDecoration(
          hintText: 'choose the city',
          hintStyle: TextStyle(
            color: Colors.white60,
            fontSize: 18,
            fontStyle: FontStyle.italic,
          ),
          border: InputBorder.none,
        ),
        style: const TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }
}
