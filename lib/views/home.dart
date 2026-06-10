import 'package:flutter/material.dart';

class home extends StatelessWidget {
  const home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF7F4EE),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),

          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,

              children: [

                const SizedBox(height: 10),

                const Text(
                  "Welcome to\nPharaonic civilization",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff8B5E2B),
                  ),
                ),

                const SizedBox(height: 20),

                SizedBox(
                  height: 45,
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "search ........",
                      prefixIcon: const Icon(Icons.search),
                      isDense: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 25),

                const Text(
                  "Quote",
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff8B5E2B),
                  ),
                ),

                const SizedBox(height: 15),

                SizedBox(
                  height: 200,

                  child: ListView.builder(
                    scrollDirection:
                    Axis.horizontal,

                    itemCount: 5,

                    itemBuilder:
                        (context, index) {

                      return Container(
                        width: 280,
                        margin:
                        const EdgeInsets.only(
                          right: 15,
                        ),

                        decoration:
                        BoxDecoration(
                          borderRadius:
                          BorderRadius
                              .circular(
                            20,
                          ),

                          color: Colors
                              .grey.shade300,
                        ),

                        child: ClipRRect(
                          borderRadius:
                          BorderRadius
                              .circular(
                            20,
                          ),

                          child: Image.network(
                            "https://picsum.photos/400/300?random=$index",
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    },
                  ),
                ),

                const SizedBox(height: 25),

                const Text(
                  "Statues",
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff8B5E2B),
                  ),
                ),

                const SizedBox(height: 15),

                SizedBox(
                  height: 220,

                  child: ListView.builder(
                    scrollDirection:
                    Axis.horizontal,

                    itemCount: 5,

                    itemBuilder:
                        (context, index) {

                      return Container(
                        width: 280,
                        margin:
                        const EdgeInsets.only(
                          right: 15,
                        ),

                        decoration:
                        BoxDecoration(
                          color:
                          Colors.grey.shade300,

                          borderRadius:
                          BorderRadius
                              .circular(
                            20,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}