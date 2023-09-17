import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CategoryRow extends StatefulWidget {
  const CategoryRow(
      {Key? key, required this.categories, required this.setSector})
      : super(key: key);

  final List<String> categories;
  final Function setSector;

  @override
  State<CategoryRow> createState() => _CategoryRowState();
}

class _CategoryRowState extends State<CategoryRow> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48.0,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: widget.categories.map((category) {
          return Container(
              margin: EdgeInsets.symmetric(vertical: 4.0),
              child:
                  CategoryChip(label: category, setSector: widget.setSector));
        }).toList(),
      ),
    );
  }
}

class CategoryChip extends StatelessWidget {
  const CategoryChip({Key? key, required this.label, required this.setSector})
      : super(key: key);

  final String label;
  final Function setSector;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: ElevatedButton(
        onPressed: () {
          print(label);
          setSector(label);
        },
        child: Text(
          label,
          style: GoogleFonts.nunito(
            fontSize: 16.0,
            color: Color.fromARGB(255, 13, 76, 128),
            fontWeight: FontWeight.bold,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: Color.fromARGB(255, 255, 229, 208),
          elevation: 1,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
      ),
    );
  }
}
