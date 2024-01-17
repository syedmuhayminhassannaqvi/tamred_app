import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomButtonSheet extends StatefulWidget {
  final String image;
  final String title;
  final String subtitle;

  CustomButtonSheet({
    Key? key,
    required this.image,
    required this.subtitle,
    required this.title,
  }) : super(key: key);

  @override
  State<CustomButtonSheet> createState() => _CustomButtonSheetState();
}

class _CustomButtonSheetState extends State<CustomButtonSheet> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.symmetric(vertical:  MediaQuery.of(context).size.height * 0.004),
      child: GestureDetector(
        onTap: () {
          setState(() {
            isSelected = !isSelected;
          });
        },
        child: Row(
          children: [
            Image.asset(
              widget.image,
              height: MediaQuery.of(context).size.height * 0.065,
              width: MediaQuery.of(context).size.width * 0.16,
            ),
            SizedBox(width: MediaQuery.of(context).size.width * 0.02),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: MediaQuery.of(context).size.height * 0.02,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    widget.subtitle,
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.height * 0.015,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            isSelected? SvgPicture.asset(
              'assets/images/tick-circle.svg',
            ):SvgPicture.asset('assets/images/add.svg'),
            SizedBox(width: MediaQuery.of(context).size.width * 0.02),
          ],
        ),
      ),
    );
  }
}
