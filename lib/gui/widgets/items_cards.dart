import 'package:flutter/material.dart';

class ItemsCards extends StatelessWidget {
  const ItemsCards({
    Key? key,
    this.icon,
    this.onTap,
    this.flex = 1,
    required this.label,
    required this.value,
  }) : super(key: key);

  final int? flex;
  final String label;
  final String value;
  final IconData? icon;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            textAlign: TextAlign.start,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black87,
            ),
          ),
          const SizedBox(width: 5),
          icon != null
              ? GestureDetector(
                  onTap: onTap,
                  child: Icon(
                    icon,
                    size: 24,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                )
              : const SizedBox(),
          Expanded(
            flex: flex!,
            child: Text(
              value,
              maxLines: 1,
              textAlign: TextAlign.end,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black87,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
