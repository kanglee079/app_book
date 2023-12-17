import 'package:flutter/material.dart';

class ItemAdminPage extends StatelessWidget {
  String nameItem;
  Function()? ontap;
  ItemAdminPage({
    super.key,
    required this.nameItem,
    required this.ontap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: Container(
          height: 60,
          decoration: BoxDecoration(
            color: Theme.of(context).hintColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              const SizedBox(width: 20),
              Expanded(
                child: Text(nameItem),
              ),
              const Icon(
                Icons.arrow_forward_ios,
              ),
              const SizedBox(width: 20),
            ],
          ),
        ),
      ),
    );
  }
}
