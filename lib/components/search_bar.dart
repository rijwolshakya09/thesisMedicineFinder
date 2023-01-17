import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/ep.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({
    Key? key,
    required this.outlineInputBorder,
  }) : super(key: key);

  final OutlineInputBorder outlineInputBorder;

  @override
  Widget build(BuildContext context) {
    return Form(
      child: TextFormField(
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: Color.fromARGB(255, 255, 255, 255),
          fontSize: 14,
          fontFamily: 'Merienda',
        ),
        decoration: InputDecoration(
          labelText: "Search Medicine or Pharmacy",
          labelStyle: const TextStyle(color: Color(0xFFFFFFFF)),
          // hintText: "Search Medicines/Pharmacies...",
          // hintStyle: const TextStyle(
          //   // color: Color(0xFF535699),
          //   fontWeight: FontWeight.bold,
          //   fontSize: 14,
          //   fontFamily: 'Merienda',
          // ),
          filled: true,
          fillColor: const Color(0xFF6BB3ED),
          border: outlineInputBorder,
          enabledBorder: outlineInputBorder,
          focusedBorder: outlineInputBorder,
          prefixIcon: const Padding(
            padding: EdgeInsets.fromLTRB(14, 6, 14, 6),
            child: Iconify(
              Ep.search,
              color: Color(0xFFFFFFFF),
            ),
          ),
          suffixIcon: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
            ),
            child: SizedBox(
              height: 50,
              width: 50,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(12),
                    ),
                  ),
                ),
                child: const Iconify(
                  Ep.search,
                  color: Color(0xFF6BB3ED),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
