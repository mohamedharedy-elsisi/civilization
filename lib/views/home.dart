import 'package:civilization/views/cubits/home/home_cubit.dart';
import 'package:civilization/views/cubits/home/home_state.dart';
import 'package:civilization/views/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../core/static/QuotesCard.dart';
import '../core/static/customCard.dart';
import '../widgets/section_title.dart';
import 'CategoryScreen.dart';
import 'DetailsScreen.dart';

class home extends StatefulWidget {
  const home({super.key});

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    super.initState();

    final homeCubit = context.read<HomeCubit>();

    if (homeCubit.state is HomeInitial) {
      homeCubit.loadData();
    }
  }

  Widget sectionTitle(String title) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Theme.of(context).textTheme.bodyLarge?.color,
        ),
      ),
    );
  }

  Widget buildErrorState(HomeError state) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.error_outline,
              size: 48,
              color: Theme.of(context).colorScheme.error,
            ),
            const SizedBox(height: 16),
            Text(
              "Something went wrong",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).textTheme.bodyLarge?.color,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              state.message,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Theme.of(context).textTheme.bodyMedium?.color,
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () {
                context.read<HomeCubit>().loadData();
              },
              icon: const Icon(Icons.refresh),
              label: const Text("Try again"),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildHomeContent(HomeLoaded state) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Welcome to\nPharaonic civilization",
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).textTheme.bodyLarge?.color,
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            readOnly: true,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => SearchScreen()),
              );
            },
            decoration: const InputDecoration(
              hintText: "Search...",
              prefixIcon: Icon(Icons.search),
            ),
          ),
          const SizedBox(height: 20),
          sectionTitle("Quotes"),
          SizedBox(
            height: 220,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: state.quotes.length,
              itemBuilder: (context, index) {
                return QuoteCard(
                  imagePath: "assets/quotes_img/quote3.jpeg",
                  quote: state.quotes[index].quote,
                  author: state.quotes[index].author,
                );
              },
            ),
          ),
          const SizedBox(height: 25),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SectionTitle(title: "Statues"),
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => CategoryScreen(
                        title: "Statues",
                        items: state.statues,
                        imageBuilder: (item) => item.images.first,
                        detailsBuilder: (item) => DetailsScreen(
                          id: item.id,
                          title: item.name,
                          arabicName: item.arabicName,
                          description: item.description,
                          images: item.images,
                          heightM: item.heightM,
                          material: item.material,
                          period: item.period,
                        ),
                      ),
                    ),
                  );
                },
                icon: Icon(
                  Icons.arrow_forward_ios,
                  color: Theme.of(context).textTheme.bodyLarge?.color,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 260,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: state.statues.length > 5 ? 5 : state.statues.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => DetailsScreen(
                          title: state.statues[index].name,
                          images: state.statues[index].images,
                          description: state.statues[index].description,
                          arabicName: state.statues[index].arabicName,
                          id: state.statues[index].id,
                          material: state.statues[index].material,
                          heightM: state.statues[index].heightM,
                          period: state.statues[index].period,
                        ),
                      ),
                    );
                  },
                  child: CustomCard(
                    imageUrl: state.statues[index].images.first,
                    title: state.statues[index].name,
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 25),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SectionTitle(title: "Temples"),
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => CategoryScreen(
                        title: "Temples",
                        items: state.temples,
                        imageBuilder: (item) => item.images.first,
                        detailsBuilder: (item) => DetailsScreen(
                          id: item.id,
                          title: item.name,
                          arabicName: item.arabicName,
                          description: item.description,
                          images: item.images,
                          city: item.city,
                          period: item.period,
                          builtBy: item.builtBy,
                        ),
                      ),
                    ),
                  );
                },
                icon: Icon(
                  Icons.arrow_forward_ios,
                  color: Theme.of(context).textTheme.bodyLarge?.color,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 260,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: state.temples.length > 5 ? 5 : state.temples.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => DetailsScreen(
                          title: state.temples[index].name,
                          images: state.temples[index].images,
                          description: state.temples[index].description,
                          arabicName: state.temples[index].arabicName,
                          id: state.temples[index].id,
                          city: state.temples[index].city,
                          period: state.temples[index].period,
                          builtBy: state.temples[index].builtBy,
                        ),
                      ),
                    );
                  },
                  child: CustomCard(
                    imageUrl: state.temples[index].images.first,
                    title: state.temples[index].name,
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 25),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SectionTitle(title: "Museums"),
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => CategoryScreen(
                        title: "Museums",
                        items: state.museums,
                        imageBuilder: (item) => item.images.first,
                        detailsBuilder: (item) => DetailsScreen(
                          id: item.id,
                          title: item.name,
                          arabicName: item.arabicName,
                          description: item.description,
                          images: item.images,
                          established: item.established,
                          city: item.city,
                        ),
                      ),
                    ),
                  );
                },
                icon: Icon(
                  Icons.arrow_forward_ios,
                  color: Theme.of(context).textTheme.bodyLarge?.color,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 260,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: state.museums.length > 5 ? 5 : state.museums.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => DetailsScreen(
                          title: state.museums[index].name,
                          images: state.museums[index].images,
                          description: state.museums[index].description,
                          arabicName: state.museums[index].arabicName,
                          id: state.museums[index].id,
                          established: state.museums[index].established,
                          city: state.museums[index].city,
                        ),
                      ),
                    );
                  },
                  child: CustomCard(
                    imageUrl: state.museums[index].images.first,
                    title: state.museums[index].name,
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 25),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SectionTitle(title: "Pharaohs"),
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => CategoryScreen(
                        title: "Pharaohs",
                        items: state.pharaohs,
                        imageBuilder: (item) => item.images.first,
                        detailsBuilder: (item) => DetailsScreen(
                          id: item.id,
                          title: item.name,
                          arabicName: item.arabicName,
                          description: item.description,
                          images: item.images,
                          capital: item.capital,
                          achievements: item.achievements,
                          dynasty: item.dynasty,
                        ),
                      ),
                    ),
                  );
                },
                icon: Icon(
                  Icons.arrow_forward_ios,
                  color: Theme.of(context).textTheme.bodyLarge?.color,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 260,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: state.pharaohs.length > 5 ? 5 : state.pharaohs.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => DetailsScreen(
                          title: state.pharaohs[index].name,
                          images: state.pharaohs[index].images,
                          description: state.pharaohs[index].description,
                          arabicName: state.pharaohs[index].arabicName,
                          id: state.pharaohs[index].id,
                          capital: state.pharaohs[index].capital,
                          achievements: state.pharaohs[index].achievements,
                          dynasty: state.pharaohs[index].dynasty,
                        ),
                      ),
                    );
                  },
                  child: CustomCard(
                    imageUrl: state.pharaohs[index].images.first,
                    title: state.pharaohs[index].name,
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 25),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SectionTitle(title: "Obelisks"),
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => CategoryScreen(
                        title: "Obelisks",
                        items: state.obelisks,
                        imageBuilder: (item) => item.images.first,
                        detailsBuilder: (item) => DetailsScreen(
                          id: item.id,
                          title: item.name,
                          arabicName: item.arabicName,
                          description: item.description,
                          images: item.images,
                          city: item.city,
                          historicalEra: item.historicalEra,
                          location: item.location,
                        ),
                      ),
                    ),
                  );
                },
                icon: Icon(
                  Icons.arrow_forward_ios,
                  color: Theme.of(context).textTheme.bodyLarge?.color,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 260,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: state.obelisks.length > 5 ? 5 : state.obelisks.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => DetailsScreen(
                          title: state.obelisks[index].name,
                          description: state.obelisks[index].description,
                          arabicName: state.obelisks[index].arabicName,
                          id: state.obelisks[index].id,
                          images: state.obelisks[index].images,
                          city: state.obelisks[index].city,
                          location: state.obelisks[index].location,
                          historicalEra: state.obelisks[index].historicalEra,
                        ),
                      ),
                    );
                  },
                  child: CustomCard(
                    imageUrl: state.obelisks[index].images.first,
                    title: state.obelisks[index].name,
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SectionTitle(title: "Pyramids"),
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => CategoryScreen(
                        title: "Pyramids",
                        items: state.pyramids,
                        imageBuilder: (item) => item.images.first,
                        detailsBuilder: (item) => DetailsScreen(
                          id: item.id,
                          title: item.name,
                          arabicName: item.arabicName,
                          description: item.description,
                          images: item.images,
                          city: item.city,
                          period: item.period,
                          builtBy: item.builtBy,
                        ),
                      ),
                    ),
                  );
                },
                icon: Icon(
                  Icons.arrow_forward_ios,
                  color: Theme.of(context).textTheme.bodyLarge?.color,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 260,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: state.pyramids.length > 5 ? 5 : state.pyramids.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => DetailsScreen(
                          title: state.pyramids[index].name,
                          images: state.pyramids[index].images,
                          description: state.pyramids[index].description,
                          arabicName: state.pyramids[index].arabicName,
                          id: state.pyramids[index].id,
                          city: state.pyramids[index].city,
                          period: state.pyramids[index].period,
                          builtBy: state.pyramids[index].builtBy,
                        ),
                      ),
                    );
                  },
                  child: CustomCard(
                    imageUrl: state.pyramids[index].images.first,
                    title: state.pyramids[index].name,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            if (state is HomeLoaded) {
              return buildHomeContent(state);
            }

            if (state is HomeError) {
              return buildErrorState(state);
            }

            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}