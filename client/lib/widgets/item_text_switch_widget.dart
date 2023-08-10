import 'package:flutter/cupertino.dart';

class ItemTextSwitchWidget extends StatefulWidget {
  const ItemTextSwitchWidget({super.key, required this.text, this.switchValue});

  final String text;
  final bool? switchValue;

  @override
  State<ItemTextSwitchWidget> createState() => _ItemTextSwitchWidgetState();
}

class _ItemTextSwitchWidgetState extends State<ItemTextSwitchWidget> {
  bool isSwitch = false;

  @override
  void initState() {
    if (widget.switchValue != null && widget.switchValue == true) {
      isSwitch = true;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isSwitch = !isSwitch;
        });
      },
      child: Row(
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
      ),
    );
  }
}
