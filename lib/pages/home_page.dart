import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final genres = [
      'Action',
      'Comédie',
      'Drame',
      'Thriller',
      'Sci‑Fi',
      'Aventure',
    ];

    final movies = [
      {
        'title': 'The Hitch',
        'rating': 8.5,
        'poster': 'https://via.placeholder.com/300x450.png?text=The+Hitch',
      },
      {
        'title': 'Lost in Paris',
        'rating': 7.8,
        'poster': 'https://via.placeholder.com/300x450.png?text=Lost+in+Paris',
      },
      {
        'title': 'Night Run',
        'rating': 8.1,
        'poster': 'https://via.placeholder.com/300x450.png?text=Night+Run',
      },
      {
        'title': 'Space Dreams',
        'rating': 7.4,
        'poster': 'https://via.placeholder.com/300x450.png?text=Space+Dreams',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Hitch DB'),
        centerTitle: true,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Trouvez votre prochain film',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 12),
              TextField(
                decoration: InputDecoration(
                  hintText: 'Rechercher un film (ex: Inception, Godfather)',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
              const SizedBox(height: 18),

              // Genres
              Text('Genres', style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 8),
              SizedBox(
                height: 40,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: genres.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 8),
                  itemBuilder: (context, index) {
                    return ChoiceChip(
                      label: Text(genres[index]),
                      selected: index == 0,
                      onSelected: (_) {},
                    );
                  },
                ),
              ),
              const SizedBox(height: 18),

              // Popular
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Populaires',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  TextButton(onPressed: () {}, child: const Text('Voir tout')),
                ],
              ),
              const SizedBox(height: 8),
              SizedBox(
                height: 230,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: movies.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 12),
                  itemBuilder: (context, index) {
                    final m = movies[index];
                    return MovieCard(
                      title: m['title'] as String,
                      rating: m['rating'] as double,
                      posterUrl: m['poster'] as String,
                    );
                  },
                ),
              ),
              const SizedBox(height: 18),

              // Grid of movies (Nouveautés)
              Text(
                'Nouveautés',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.55,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                ),
                itemCount: movies.length,
                itemBuilder: (context, index) {
                  final m = movies[index];
                  return MovieCard(
                    title: m['title'] as String,
                    rating: m['rating'] as double,
                    posterUrl: m['poster'] as String,
                    compact: true,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MovieCard extends StatelessWidget {
  final String title;
  final double rating;
  final String posterUrl;
  final bool compact;

  const MovieCard({
    super.key,
    required this.title,
    required this.rating,
    required this.posterUrl,
    this.compact = false,
  });

  @override
  Widget build(BuildContext context) {
    final cardWidth = compact ? double.infinity : 150.0;
    return SizedBox(
      width: cardWidth,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Use a fixed height for the poster so the card fits inside
          // constrained containers (horizontal list or grid)
          SizedBox(
            // slightly smaller poster heights to avoid overflow in constrained
            // horizontal lists used by the homepage and during widget tests
            height: compact ? 150 : 160,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                posterUrl,
                fit: BoxFit.cover,
                width: double.infinity,
                errorBuilder:
                    (context, error, stackTrace) => Container(
                      color: Colors.grey[300],
                      child: const Center(child: Icon(Icons.broken_image)),
                    ),
              ),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 3),
          Row(
            children: [
              const Icon(Icons.star, color: Colors.amber, size: 16),
              const SizedBox(width: 4),
              Text(rating.toString()),
            ],
          ),
        ],
      ),
    );
  }
}
