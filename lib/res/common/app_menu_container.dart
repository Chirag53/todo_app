import 'package:flutter/material.dart';

class AppMenuContainer extends StatelessWidget {
  final String? image;
  final String? text;
  final String? texttwo;
  final String? textthree;
  final String? imagetwo;
  const AppMenuContainer(
      {Key? key,
      this.image,
      this.text,
      this.texttwo,
      this.textthree,
      this.imagetwo})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 59, left: 10, right: 10),
          child: Container(
            height: 80,
            width: 327,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40),
              color: const Color(0xFFF3F3F3),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 80,
                  width: 80,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Center(
                    child: Text(
                      text!,
                      style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 25),
                    ),
                  ),
                ),
                SizedBox(
                  width: 45,
                ),
                Center(
                  child: Text(
                    texttwo!,
                    style: const TextStyle(
                      color: Color(0xFF000000),
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
                Center(
                  child: Text(
                    textthree!,
                    style: const TextStyle(
                        fontWeight: FontWeight.normal,
                        color: Color(0xFF474747),
                        fontSize: 22),
                  ),
                ),
                Center(
                  child: Image(
                    image: AssetImage(image!),
                  ),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 90),
          child: Image(
            image: AssetImage(imagetwo!),
          ),
        ),
      ],
    );
  }
}
