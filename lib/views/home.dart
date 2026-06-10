import 'package:flutter/material.dart';

import '../core/static/QuotesCard.dart';
import '../core/static/customCard.dart';
import '../models/quote_model.dart';
import '../models/pharaoh_model.dart';
import '../models/statue_model.dart';
import '../models/temple_model.dart';
import '../models/museum_model.dart';
import '../models/obelisk_model.dart';

import '../repositories/quotes_repository.dart';
import '../repositories/pharaohs_repository.dart';
import '../repositories/statues_repository.dart';
import '../repositories/temples_repository.dart';
import '../repositories/museums_repository.dart';
import '../repositories/obelisks_repository.dart';
import 'CategoryScreen.dart';

// import '../widgets/custom_card.dart';
// import '../widgets/quote_card.dart';

class home extends StatefulWidget {
  const home({super.key});

  @override
  State<home> createState() =>
      _homeState();
}

class _homeState
    extends State<home> {

  final QuotesRepository
  quotesRepository =
  QuotesRepository();

  final PharaohsRepository
  pharaohsRepository =
  PharaohsRepository();

  final StatuesRepository
  statuesRepository =
  StatuesRepository();

  final TemplesRepository
  templesRepository =
  TemplesRepository();

  final MuseumsRepository
  museumsRepository =
  MuseumsRepository();

  final ObelisksRepository
  obelisksRepository =
  ObelisksRepository();

  List<QuoteModel> quotes = [];
  List<PharaohModel> pharaohs = [];
  List<StatueModel> statues = [];
  List<TempleModel> temples = [];
  List<MuseumModel> museums = [];
  List<ObeliskModel> obelisks = [];

  bool isLoading = true;

  final quoteImages = [
    "assets/quotes_img/quote1.jpeg",
    "assets/quotes_img/quote3.jpeg",
  ];

  @override
  void initState() {
    super.initState();

    loadData();
  }

  Future<void> loadData() async {
    try {
      final results =
      await Future.wait([

        quotesRepository
            .getQuotes(),

        pharaohsRepository
            .getPharaohs(),

        statuesRepository
            .getStatues(),

        templesRepository
            .getTemples(),

        museumsRepository
            .getMuseums(),

        obelisksRepository
            .getObelisks(),
      ]);

      quotes =
      results[0]
      as List<QuoteModel>;

      pharaohs =
      results[1]
      as List<PharaohModel>;

      statues =
      results[2]
      as List<StatueModel>;

      temples =
      results[3]
      as List<TempleModel>;

      museums =
      results[4]
      as List<MuseumModel>;

      obelisks =
      results[5]
      as List<ObeliskModel>;
    } catch (e) {
      debugPrint(e.toString());
    }

    setState(() {
      isLoading = false;
    });
  }

  Widget sectionTitle(
      String title) {
    return Padding(
      padding:
      const EdgeInsets.only(
        bottom: 12,
      ),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 24,
          fontWeight:
          FontWeight.bold,
          color:
          Color(0xff8B5E2B),
        ),
      ),
    );
  }

  @override
  Widget build(
      BuildContext context) {
    return Scaffold(
      backgroundColor:
      const Color(
          0xffF7F4EE),

      body: SafeArea(
        child: isLoading
            ? const Center(
          child:
          CircularProgressIndicator(),
        )
            : SingleChildScrollView(
          padding:
          const EdgeInsets
              .all(16),

          child: Column(
            crossAxisAlignment:
            CrossAxisAlignment
                .start,

            children: [

              const Text(
                "Welcome to\nPharaonic civilization",
                style:
                TextStyle(
                  fontSize: 30,
                  fontWeight:
                  FontWeight
                      .bold,
                  color: Color(
                      0xff8B5E2B),
                ),
              ),

              const SizedBox(
                  height: 16),
              SizedBox(
                height: 50,
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Search...",
                    prefixIcon: const Icon(
                      Icons.search,
                    ),
                    border: OutlineInputBorder(
                      borderRadius:
                      BorderRadius.circular(25),
                    ),
                  ),
                ),
              ),

              const SizedBox(
                  height: 20),

              sectionTitle(
                  "Quotes"),

              SizedBox(
                height: 220,

                child:
                ListView.builder(
                  scrollDirection:
                  Axis.horizontal,

                  itemCount:
                  quotes.length,

                  itemBuilder:
                      (context,
                      index) {

                    return QuoteCard(
                      imagePath:
                      quoteImages[index %
                          quoteImages.length],

                      quote:
                      quotes[index]
                          .quote,

                      author:
                      quotes[index]
                          .author,
                    );
                  },
                ),
              ),

              const SizedBox(
                  height: 25),

              Row(
                mainAxisAlignment:
                MainAxisAlignment.spaceBetween,

                children: [

                  const Text(
                    "Statues",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff8B5E2B),
                    ),
                  ),

                  IconButton(

                    onPressed: () {

                      Navigator.push(

                        context,

                        MaterialPageRoute(

                          builder: (_) =>
                              CategoryScreen(

                                title: "Statues",

                                items: statues,
                              ),
                        ),
                      );
                    },

                    icon: const Icon(
                      Icons.arrow_forward_ios,
                      color: Color(0xff8B5E2B),
                    ),
                  ),
                ],
              ),

              SizedBox(
                height: 260,

                child:
                ListView.builder(
                  scrollDirection:
                  Axis.horizontal,

                  itemCount:
                  statues.length > 5
                      ? 5
                      : statues.length,

                  itemBuilder:
                      (context,
                      index) {

                    return CustomCard(
                      imageUrl:
                      statues[index]
                          .image,

                      title:
                      statues[index]
                          .name,
                    );
                  },
                ),
              ),

              const SizedBox(
                  height: 25),

              Row(
                mainAxisAlignment:
                MainAxisAlignment.spaceBetween,

                children: [

                  const Text(
                    "Temples",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff8B5E2B),
                    ),
                  ),

                  IconButton(

                    onPressed: () {

                      Navigator.push(

                        context,

                        MaterialPageRoute(

                          builder: (_) =>
                              CategoryScreen(

                                title: "Temples",

                                items: temples,
                              ),
                        ),
                      );
                    },

                    icon: const Icon(
                      Icons.arrow_forward_ios,
                      color: Color(0xff8B5E2B),
                    ),
                  ),
                ],
              ),

              SizedBox(
                height: 260,

                child:
                ListView.builder(
                  scrollDirection:
                  Axis.horizontal,

                  itemCount:
                  temples.length > 5
                      ? 5
                      : temples.length,

                  itemBuilder:
                      (context,
                      index) {

                    return CustomCard(
                      imageUrl:
                      temples[index]
                          .image,

                      title:
                      temples[index]
                          .name,
                    );
                  },
                ),
              ),

              const SizedBox(
                  height: 25),

              Row(
                mainAxisAlignment:
                MainAxisAlignment.spaceBetween,

                children: [

                  const Text(
                    "Museums",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff8B5E2B),
                    ),
                  ),

                  IconButton(

                    onPressed: () {

                      Navigator.push(

                        context,

                        MaterialPageRoute(

                          builder: (_) =>
                              CategoryScreen(

                                title: "Museums",

                                items: museums,
                              ),
                        ),
                      );
                    },

                    icon: const Icon(
                      Icons.arrow_forward_ios,
                      color: Color(0xff8B5E2B),
                    ),
                  ),
                ],
              ),

              SizedBox(
                height: 260,

                child:
                ListView.builder(
                  scrollDirection:
                  Axis.horizontal,

                  itemCount:
                  museums.length > 5
                      ? 5
                      : museums.length,

                  itemBuilder:
                      (context,
                      index) {

                    return CustomCard(
                      imageUrl:
                      museums[index]
                          .image,

                      title:
                      museums[index]
                          .name,
                    );
                  },
                ),
              ),

              const SizedBox(
                  height: 25),

              Row(
                mainAxisAlignment:
                MainAxisAlignment.spaceBetween,

                children: [

                  const Text(
                    "Pharaohs",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff8B5E2B),
                    ),
                  ),

                  IconButton(

                    onPressed: () {

                      Navigator.push(

                        context,

                        MaterialPageRoute(

                          builder: (_) =>
                              CategoryScreen(

                                title: "Pharaohs",

                                items: pharaohs,
                              ),
                        ),
                      );
                    },

                    icon: const Icon(
                      Icons.arrow_forward_ios,
                      color: Color(0xff8B5E2B),
                    ),
                  ),
                ],
              ),

              SizedBox(
                height: 260,

                child:
                ListView.builder(
                  scrollDirection:
                  Axis.horizontal,

                  itemCount:
                  pharaohs.length > 5
                      ? 5
                      : pharaohs.length,

                  itemBuilder:
                      (context,
                      index) {

                    return CustomCard(
                      imageUrl:
                      pharaohs[index]
                          .image,

                      title:
                      pharaohs[index]
                          .name,
                    );
                  },
                ),
              ),

              const SizedBox(
                  height: 25),

              Row(
                mainAxisAlignment:
                MainAxisAlignment.spaceBetween,

                children: [

                  const Text(
                    "Obelisks",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff8B5E2B),
                    ),
                  ),

                  IconButton(

                    onPressed: () {

                      Navigator.push(

                        context,

                        MaterialPageRoute(

                          builder: (_) =>
                              CategoryScreen(

                                title: "Obelisks",

                                items: obelisks,
                              ),
                        ),
                      );
                    },

                    icon: const Icon(
                      Icons.arrow_forward_ios,
                      color: Color(0xff8B5E2B),
                    ),
                  ),
                ],
              ),

              SizedBox(
                height: 260,

                child:
                ListView.builder(
                  scrollDirection:
                  Axis.horizontal,

                  itemCount:
                  obelisks.length > 5
                      ? 5
                      : obelisks.length,

                  itemBuilder:
                      (context,
                      index) {

                    return CustomCard(
                      imageUrl:
                      obelisks[index]
                          .images[0],

                      title:
                      obelisks[index]
                          .name,
                    );
                  },
                ),
              ),

              const SizedBox(
                  height: 30),
            ],
          ),
        ),
      ),
    );
  }
}