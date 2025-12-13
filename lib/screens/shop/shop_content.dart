import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/theme_provider.dart';
import '../../models/book.dart';
import '../../models/chat_character.dart';
import '../../widgets/book/book_card.dart';
import '../../widgets/shop/genre_chip.dart';
import 'book_detail_screen.dart';

class ShopContent extends StatelessWidget {
  final AppThemeColors colors;
  final String searchQuery;

  const ShopContent({super.key, required this.colors, this.searchQuery = ''});

  // Lista de géneros disponibles
  List<String> get _genres => [
    'Romance',
    'Health, mind & body',
    'Art & recreation',
    'Business & investing',
    'Self-help',
    'Biographies & memoirs',
    'Science fiction',
    'Mystery',
    'Fantasy',
    'History',
  ];

  // Lista de libros disponibles en la tienda con todos los detalles
  List<Book> get _storeBooks => [
    Book(
      id: 's1',
      title: 'The Hobbit',
      author: 'J. R. R. Tolkien',
      price: 12500,
      releaseDate: DateTime(1937, 9, 21),
      pages: 310,
      aiCharactersCount: 3,
      minimumAge: 10,
      originalLanguage: 'English',
      genre: 'Fantasy / Adventure',
      publisher: 'George Allen & Unwin',
      setting: 'Middle-earth',
      description:
          'The Hobbit is a classic fantasy novel by J.R.R. Tolkien that follows Bilbo Baggins, a quiet hobbit who is unexpectedly swept into an epic adventure. Guided by the wizard Gandalf and accompanied by a group of dwarves, Bilbo journeys across Middle-earth to reclaim the dwarves\' homeland and treasure from the fearsome dragon Smaug. Along the way, he encounters trolls, goblins, elves, and a mysterious creature named Gollum, from whom he acquires a magical ring. The story explores themes of courage, friendship, and personal growth as Bilbo transforms from a timid homebody into a brave hero.',
      characters: [
        ChatCharacter(
          id: 'bilbo',
          name: 'Bilbo Baggins',
          lastMessageTime: DateTime.now(),
          description:
              'A comfort-loving hobbit from the Shire who unexpectedly becomes a burglar and hero.',
        ),
        ChatCharacter(
          id: 'gandalf',
          name: 'Gandalf',
          lastMessageTime: DateTime.now(),
          description:
              'A wise and powerful wizard who guides Bilbo on his unexpected journey.',
        ),
        ChatCharacter(
          id: 'gollum',
          name: 'Gollum',
          lastMessageTime: DateTime.now(),
          description:
              'A mysterious creature corrupted by the Ring, speaks in riddles and refers to himself as "precious".',
        ),
      ],
    ),
    Book(
      id: 's2',
      title: 'Fahrenheit 451',
      author: 'Ray Bradbury',
      price: 10900,
      releaseDate: DateTime(1953, 10, 19),
      pages: 194,
      aiCharactersCount: 2,
      minimumAge: 13,
      originalLanguage: 'English',
      genre: 'Dystopian / Science Fiction',
      publisher: 'Ballantine Books',
      setting: 'Dystopian America',
      description:
          'Fahrenheit 451 is a dystopian novel set in a future American society where books are outlawed and "firemen" burn any that are found. The story follows Guy Montag, a fireman who becomes disillusioned with his role of censoring literature and destroying knowledge, eventually quitting his job and committing himself to the preservation of literary and cultural writings.',
    ),
    Book(
      id: 's3',
      title: 'The Catcher in the Rye',
      author: 'J. D. Salinger',
      price: 9800,
      releaseDate: DateTime(1951, 7, 16),
      pages: 234,
      aiCharactersCount: 1,
      minimumAge: 14,
      originalLanguage: 'English',
      genre: 'Coming-of-age / Literary Fiction',
      publisher: 'Little, Brown and Company',
      setting: 'New York City, 1950s',
      description:
          'The Catcher in the Rye is a novel by J. D. Salinger that follows Holden Caulfield, a teenage boy who has been expelled from prep school. The story chronicles his experiences in New York City over a few days, exploring themes of adolescent angst, alienation, and the loss of innocence.',
    ),
    Book(
      id: 's4',
      title: 'To Kill a Mockingbird',
      author: 'Harper Lee',
      price: 11300,
      releaseDate: DateTime(1960, 7, 11),
      pages: 281,
      aiCharactersCount: 4,
      minimumAge: 12,
      originalLanguage: 'English',
      genre: 'Southern Gothic / Legal Drama',
      publisher: 'J. B. Lippincott & Co.',
      setting: 'Maycomb, Alabama, 1930s',
      description:
          'To Kill a Mockingbird is a novel by Harper Lee set in the fictional town of Maycomb, Alabama during the Great Depression. The story follows young Scout Finch as her father, lawyer Atticus Finch, defends a Black man falsely accused of raping a white woman. The novel explores themes of racial injustice, moral growth, and the destruction of innocence.',
      characters: [
        ChatCharacter(
          id: 'scout',
          name: 'Scout Finch',
          lastMessageTime: DateTime.now(),
          description:
              'A curious and tomboyish young girl who narrates the story with innocence and wisdom.',
        ),
        ChatCharacter(
          id: 'atticus',
          name: 'Atticus Finch',
          lastMessageTime: DateTime.now(),
          description:
              'A principled lawyer and loving father who believes in justice and equality for all.',
        ),
        ChatCharacter(
          id: 'jem',
          name: 'Jem Finch',
          lastMessageTime: DateTime.now(),
          description:
              'Scout\'s older brother who struggles with the harsh realities of injustice.',
        ),
        ChatCharacter(
          id: 'boo',
          name: 'Boo Radley',
          lastMessageTime: DateTime.now(),
          description:
              'A mysterious recluse who becomes a symbol of kindness and unexpected heroism.',
        ),
      ],
    ),
    Book(
      id: 's5',
      title: 'The Silent Patient',
      author: 'Alex Michaelides',
      price: 14200,
      releaseDate: DateTime(2019, 2, 5),
      pages: 336,
      aiCharactersCount: 2,
      minimumAge: 16,
      originalLanguage: 'English',
      genre: 'Psychological Thriller',
      publisher: 'Celadon Books',
      setting: 'London, Contemporary',
      description:
          'The Silent Patient is a psychological thriller about Alicia Berenson, a famous painter who stops speaking after allegedly murdering her husband. Theo Faber, a criminal psychotherapist, becomes obsessed with uncovering the truth behind her silence and her crime.',
    ),
    Book(
      id: 's6',
      title: 'Atomic Habits',
      author: 'James Clear',
      price: 15800,
      releaseDate: DateTime(2018, 10, 16),
      pages: 320,
      aiCharactersCount: 0,
      minimumAge: 13,
      originalLanguage: 'English',
      genre: 'Self-help / Personal Development',
      publisher: 'Avery',
      setting: 'Non-fiction',
      description:
          'Atomic Habits offers a proven framework for improving every day. James Clear reveals practical strategies that will teach you exactly how to form good habits, break bad ones, and master the tiny behaviors that lead to remarkable results.',
    ),
    Book(
      id: 's7',
      title: 'The Alchemist',
      author: 'Paulo Coelho',
      price: 8900,
      releaseDate: DateTime(1988, 1, 1),
      pages: 208,
      aiCharactersCount: 3,
      minimumAge: 12,
      originalLanguage: 'Portuguese',
      genre: 'Quest / Fantasy',
      publisher: 'HarperOne',
      setting: 'Andalusia, Egypt, and the desert',
      description:
          'The Alchemist follows Santiago, an Andalusian shepherd boy who dreams of finding a worldly treasure. His quest leads him to riches far different from what he originally sought. A magical fable about following your dreams.',
    ),
    Book(
      id: 's8',
      title: 'Dune',
      author: 'Frank Herbert',
      price: 13500,
      releaseDate: DateTime(1965, 8, 1),
      pages: 688,
      aiCharactersCount: 5,
      minimumAge: 14,
      originalLanguage: 'English',
      genre: 'Science Fiction / Space Opera',
      publisher: 'Chilton Books',
      setting: 'Planet Arrakis',
      description:
          'Dune is set in the distant future amidst a feudal interstellar society in which various noble houses control planetary fiefs. It tells the story of young Paul Atreides, whose family accepts the stewardship of the planet Arrakis, the only source of the most valuable substance in the universe: the spice melange.',
      characters: [
        ChatCharacter(
          id: 'paul',
          name: 'Paul Atreides',
          lastMessageTime: DateTime.now(),
          description:
              'The young heir of House Atreides destined to become the messianic Muad\'Dib.',
        ),
        ChatCharacter(
          id: 'jessica',
          name: 'Lady Jessica',
          lastMessageTime: DateTime.now(),
          description:
              'Paul\'s mother, a Bene Gesserit with powerful abilities and fierce loyalty.',
        ),
        ChatCharacter(
          id: 'leto',
          name: 'Duke Leto Atreides',
          lastMessageTime: DateTime.now(),
          description:
              'Paul\'s noble father, a just ruler beloved by his people.',
        ),
        ChatCharacter(
          id: 'chani',
          name: 'Chani',
          lastMessageTime: DateTime.now(),
          description:
              'A fierce Fremen warrior who becomes Paul\'s love and companion.',
        ),
        ChatCharacter(
          id: 'stilgar',
          name: 'Stilgar',
          lastMessageTime: DateTime.now(),
          description:
              'The wise leader of the Fremen tribe who guides Paul in desert survival.',
        ),
      ],
    ),
    Book(
      id: 's9',
      title: 'The Midnight Library',
      author: 'Matt Haig',
      price: 11800,
      releaseDate: DateTime(2020, 8, 13),
      pages: 304,
      aiCharactersCount: 2,
      minimumAge: 14,
      originalLanguage: 'English',
      genre: 'Fiction / Fantasy',
      publisher: 'Canongate Books',
      setting: 'Between life and death',
      description:
          'Between life and death there is a library, and within that library, the shelves go on forever. Every book provides a chance to try another life you could have lived. Nora Seed finds herself faced with the possibility of changing her life for a new one.',
    ),
    Book(
      id: 's10',
      title: 'Where the Crawdads Sing',
      author: 'Delia Owens',
      price: 12900,
      releaseDate: DateTime(2018, 8, 14),
      pages: 384,
      aiCharactersCount: 3,
      minimumAge: 15,
      originalLanguage: 'English',
      genre: 'Mystery / Coming-of-age',
      publisher: 'G.P. Putnam\'s Sons',
      setting: 'North Carolina marshlands',
      description:
          'Where the Crawdads Sing tells the story of Kya, the "Marsh Girl," who raised herself alone in the marshes of North Carolina. When a popular young man from town is found dead, Kya becomes the prime suspect. The novel weaves together a murder mystery with a coming-of-age story.',
    ),
    Book(
      id: 's11',
      title: 'Project Hail Mary',
      author: 'Andy Weir',
      price: 14500,
      releaseDate: DateTime(2021, 5, 4),
      pages: 496,
      aiCharactersCount: 2,
      minimumAge: 13,
      originalLanguage: 'English',
      genre: 'Science Fiction / Adventure',
      publisher: 'Ballantine Books',
      setting: 'Space',
      description:
          'Ryland Grace is the sole survivor on a desperate, last-chance mission—and if he fails, humanity and the Earth itself will perish. Except that right now, he doesn\'t know that. He can\'t even remember his own name, let alone the nature of his assignment or how to complete it.',
    ),
    Book(
      id: 's12',
      title: 'The Seven Husbands of Evelyn Hugo',
      author: 'Taylor Jenkins Reid',
      price: 10500,
      releaseDate: DateTime(2017, 6, 13),
      pages: 400,
      aiCharactersCount: 4,
      minimumAge: 16,
      originalLanguage: 'English',
      genre: 'Historical Fiction / Romance',
      publisher: 'Atria Books',
      setting: 'Hollywood, 1950s-2000s',
      description:
          'Aging Hollywood icon Evelyn Hugo finally decides to tell the truth about her glamorous and scandalous life. She chooses unknown magazine reporter Monique Grant for the job. The story reveals the truth about her seven husbands and the love of her life.',
    ),
  ];

  List<Book> get filteredBooks {
    if (searchQuery.isEmpty) return _storeBooks;
    final query = searchQuery.toLowerCase();
    return _storeBooks.where((book) {
      return book.title.toLowerCase().contains(query) ||
          book.author.toLowerCase().contains(query);
    }).toList();
  }

  void _onBookTap(BuildContext context, Book book) {
    final themeProvider = context.read<ThemeProvider>();
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder:
            (context, animation, secondaryAnimation) =>
                BookDetailScreen(book: book),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          // Animación de slide de derecha a izquierda (igual que el chat)
          const begin = Offset(1.0, 0.0);
          const end = Offset.zero;
          const curve = Curves.easeInOut;

          var tween = Tween(
            begin: begin,
            end: end,
          ).chain(CurveTween(curve: curve));

          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        },
        transitionDuration: const Duration(milliseconds: 300),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final displayBooks = filteredBooks;

    return SliverList(
      delegate: SliverChildListDelegate([
        // Sección "Genres"
        _buildSectionTitle('Genres'),

        // Lista horizontal de géneros
        _buildGenresList(),

        const SizedBox(height: 24),

        // Sección "Books"
        _buildSectionTitle('Books'),

        const SizedBox(height: 8),

        // Lista de libros
        ...displayBooks.map(
          (book) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: BookCard(
              book: book,
              colors: colors,
              mode: BookCardMode.store,
              onTap: () => _onBookTap(context, book),
            ),
          ),
        ),

        // Espacio inferior
        const SizedBox(height: 16),
      ]),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: colors.textPrimary,
        ),
      ),
    );
  }

  Widget _buildGenresList() {
    return SizedBox(
      height: 44,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: _genres.length,
        separatorBuilder: (context, index) => const SizedBox(width: 10),
        itemBuilder: (context, index) {
          return GenreChip(
            label: _genres[index],
            colors: colors,
            onTap: () {
              debugPrint('Género seleccionado: ${_genres[index]}');
            },
          );
        },
      ),
    );
  }
}
