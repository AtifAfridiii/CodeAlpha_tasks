import 'package:dukan/provider/drop.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Dropdown extends StatefulWidget {
  dynamic buyer;
  dynamic seller;
  Dropdown({super.key, this.buyer, this.seller});

  @override
  State<Dropdown> createState() => _DropdownState();
}

class _DropdownState extends State<Dropdown> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Consumer<dropValue>(
          builder: (context, val, child) {
            return DropdownButtonFormField<String>(
              hint: const Text('Account type'),
              value: val.Value.isEmpty ? null : val.Value,
              items: [
                DropdownMenuItem(
                  value: widget.buyer,
                  child: const Text('Buyer'),
                ),
                DropdownMenuItem(
                  value: widget.seller,
                  child: const Text('Seller'),
                ),
              ],
              onChanged: (newvalue) {
                val.setValue(newvalue);
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Select the account type ';
                }
                return null;
              },
            );
          },
        ),
      ],
    );
  }
}
