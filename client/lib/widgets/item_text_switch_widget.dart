import 'package:flutter/cupertino.dart';

class ItemTextSwitchWidget extends StatefulWidget {
  const ItemTextSwitchWidget({super.key, required this.text, this.switchValue});

  final String text;
  final bool? switchValue;

  @override
  State<ItemTextSwitchWidget> createState() => _ItemTextSwitchWidgetState();
}

class _ItemTextSwitchWidgetState extends State<ItemTextSwitchWidget> {
  @override
  Widget build(BuildContext context) {
    bool isSwitch = widget.switchValue ?? false;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          widget.text,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
        CupertinoSwitch(
          value: isSwitch,
          onChanged: (value) {
            setState(() {
              isSwitch = value;
            });
          },
        ),
      ],
    );
  }
}
