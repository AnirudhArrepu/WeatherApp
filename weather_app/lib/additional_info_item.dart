import 'package:flutter/material.dart';

class AdditionalInfoItem extends StatelessWidget {
  final IconData icon;
  final String type;
  final String value;
  const AdditionalInfoItem({
    super.key,
    required this.icon,
    required this.type,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(13)),
          elevation: 0,
          child: Padding(
            padding: const EdgeInsets.all(9.0),
            child: Column(
              children: [
                Icon(
                  icon,
                  size: 35,
                ),
                SizedBox(height: 5),
                Text(
                  type,
                  style: TextStyle(
                    fontSize: 15.0,
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
