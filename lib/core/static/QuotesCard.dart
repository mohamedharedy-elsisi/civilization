import 'package:flutter/material.dart';

class QuoteCard extends StatelessWidget {

  final String imagePath;
  final String quote;
  final String author;

  const QuoteCard({
    super.key,
    required this.imagePath,
    required this.quote,
    required this.author,
  });

  @override
  Widget build(BuildContext context) {

    return Container(

      width: 280,

      margin:
      const EdgeInsets.only(
        right: 15,
      ),

      decoration:
      BoxDecoration(

        borderRadius:
        BorderRadius.circular(
          20,
        ),
      ),

      child: Stack(

        children: [

          ClipRRect(

            borderRadius:
            BorderRadius.circular(
              20,
            ),

            child: Image.asset(

              imagePath,

              width: double.infinity,

              height: double.infinity,

              fit: BoxFit.cover,
            ),
          ),

          Padding(

            padding:
            const EdgeInsets.all(
              20,
            ),

            child: Column(

              mainAxisAlignment:
              MainAxisAlignment
                  .center,

              children: [

                Text(

                  quote,

                  textAlign:
                  TextAlign.center,

                  style:
                  const TextStyle(
                    fontSize: 18,
                    fontWeight:
                    FontWeight.bold,
                    color:
                    Colors.black87,
                  ),
                ),

                const SizedBox(
                  height: 15,
                ),

                Text(

                  author,

                  style:
                  const TextStyle(
                    fontSize: 16,
                    color:
                    Colors.black54,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}