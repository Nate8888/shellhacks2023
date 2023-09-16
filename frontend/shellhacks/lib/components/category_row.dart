import 'package:flutter/material.dart';

class CategoryRow extends StatefulWidget {
  const CategoryRow({Key? key, required this.categories});

  final List<String> categories;

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
          return CategoryChip(label: category);
        }).toList(),
      ),
    );
  }
}

class CategoryChip extends StatelessWidget {
  const CategoryChip({Key? key, required this.label}) : super(key: key);

  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: ElevatedButton(
        onPressed: () {},
        child: Text(label),
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
        ),
      ),
    );
  }
}
