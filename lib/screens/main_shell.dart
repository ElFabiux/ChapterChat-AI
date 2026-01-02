import 'package:chapter_chat_ai/blocs/book/bloc/book_bloc.dart';
import 'package:chapter_chat_ai/blocs/book/bloc/book_event.dart';
import 'package:chapter_chat_ai/blocs/user/bloc/user_bloc.dart';
import 'package:chapter_chat_ai/blocs/user/bloc/user_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../core/theme/theme_provider.dart';
import '../models/book.dart';
import '../models/chat_character.dart';
import '../widgets/common/bottom_nav_bar.dart';
import '../widgets/common/search_header.dart';
import '../widgets/common/sticky_section_header.dart';
import 'home/home_content.dart';
import 'chat/chat_content.dart';
import 'shop/shop_content.dart';
import 'profile/profile_content.dart';
import 'publish/publish_book_screen.dart';

class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  NavTab _currentTab = NavTab.home;
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  bool _isSearchFocused = false;

  // Lista de libros de ejemplo con personajes para chat
  final List<Book> _books = [
    Book(
      id: '1',
      title: 'The Hobbit',
      author: 'J.R.R. Tolkien',
      isRead: false,
      isDownloaded: true,
      readingProgress: 0.45,
      releaseDate: DateTime(1937, 9, 21),
      characters: [
        ChatCharacter(
          id: 'gandalf_hobbit',
          name: 'Gandalf',
          lastMessageTime: DateTime.now(),
          description:
              'Wise, mysterious, and direct. Offers guidance, riddles, and magical insight.',
        ),
        ChatCharacter(
          id: 'bilbo_hobbit',
          name: 'Bilbo Baggins',
          lastMessageTime: DateTime.now(),
          description:
              'Curious, polite, and adventurous. Shares experiences from his unexpected journey.',
        ),
        ChatCharacter(
          id: 'thorin_hobbit',
          name: 'Thorin Oakenshield',
          lastMessageTime: DateTime.now(),
          description:
              'Serious, proud, and determined. Talks about honor, dwarven culture, and reclaiming the mountain.',
        ),
      ],
    ),
    Book(
      id: '2',
      title: '1984',
      author: 'George Orwell',
      isRead: false,
      isDownloaded: true,
      readingProgress: 0.72,
      releaseDate: DateTime(1949, 6, 8),
      characters: [
        ChatCharacter(
          id: 'winston_1984',
          name: 'Winston Smith',
          lastMessageTime: DateTime.now(),
          description:
              'A disillusioned party member who secretly rebels against Big Brother.',
        ),
        ChatCharacter(
          id: 'julia_1984',
          name: 'Julia',
          lastMessageTime: DateTime.now(),
          description:
              'A bold, pragmatic rebel who seeks freedom through small acts of defiance.',
        ),
      ],
    ),
    Book(
      id: '3',
      title: 'Pride and Prejudice',
      author: 'Jane Austen',
      isRead: true,
      isDownloaded: true,
      readingProgress: 1.0,
      releaseDate: DateTime(1813, 1, 28),
      characters: [
        ChatCharacter(
          id: 'elizabeth_pp',
          name: 'Elizabeth Bennet',
          lastMessageTime: DateTime.now(),
          description:
              'Witty, intelligent, and independent. Quick to judge but open to change.',
        ),
        ChatCharacter(
          id: 'darcy_pp',
          name: 'Mr. Darcy',
          lastMessageTime: DateTime.now(),
          description:
              'Proud and reserved, but deeply honorable. Struggles to express his feelings.',
        ),
      ],
    ),
    Book(
      id: '4',
      title: 'To Kill a Mockingbird',
      author: 'Harper Lee',
      isRead: false,
      isDownloaded: true,
      readingProgress: 0.33,
      releaseDate: DateTime(1960, 7, 11),
      characters: [
        ChatCharacter(
          id: 'scout_tkam',
          name: 'Scout Finch',
          lastMessageTime: DateTime.now(),
          description:
              'A curious, tomboyish girl learning about justice and compassion.',
        ),
        ChatCharacter(
          id: 'atticus_tkam',
          name: 'Atticus Finch',
          lastMessageTime: DateTime.now(),
          description:
              'A moral, wise lawyer who stands for justice and equality.',
        ),
      ],
    ),
    Book(
      id: '5',
      title: 'The Great Gatsby',
      author: 'F. Scott Fitzgerald',
      isRead: false,
      isDownloaded: false,
      readingProgress: 0.0,
      releaseDate: DateTime(1925, 4, 10),
      characters: [
        ChatCharacter(
          id: 'gatsby_gg',
          name: 'Jay Gatsby',
          lastMessageTime: DateTime.now(),
          description:
              'A mysterious millionaire obsessed with recapturing the past.',
        ),
        ChatCharacter(
          id: 'nick_gg',
          name: 'Nick Carraway',
          lastMessageTime: DateTime.now(),
          description:
              'The observant narrator, caught between admiration and moral judgment.',
        ),
      ],
    ),
    Book(
      id: '6',
      title: 'Harry Potter and the Sorcerer\'s Stone',
      author: 'J.K. Rowling',
      isRead: true,
      isDownloaded: true,
      readingProgress: 1.0,
      releaseDate: DateTime(1997, 6, 26),
      characters: [
        ChatCharacter(
          id: 'harry_potter',
          name: 'Harry Potter',
          lastMessageTime: DateTime.now(),
          description:
              'The Boy Who Lived. Brave, loyal, and always ready for adventure.',
        ),
        ChatCharacter(
          id: 'hermione_granger',
          name: 'Hermione Granger',
          lastMessageTime: DateTime.now(),
          description:
              'Brilliant, studious, and resourceful. The brightest witch of her age.',
        ),
        ChatCharacter(
          id: 'ron_weasley',
          name: 'Ron Weasley',
          lastMessageTime: DateTime.now(),
          description:
              'Loyal, funny, and courageous. Harry\'s best friend from a wizarding family.',
        ),
      ],
    ),
    Book(
      id: '7',
      title: 'The Catcher in the Rye',
      author: 'J.D. Salinger',
      isRead: false,
      isDownloaded: true,
      readingProgress: 0.58,
      releaseDate: DateTime(1951, 7, 16),
      characters: [
        ChatCharacter(
          id: 'holden_caulfield',
          name: 'Holden Caulfield',
          lastMessageTime: DateTime.now(),
          description:
              'A cynical teenager from New York. Critical of society and searching for authenticity.',
        ),
      ],
    ),
    Book(
      id: '8',
      title: 'Lord of the Flies',
      author: 'William Golding',
      isRead: false,
      isDownloaded: true,
      readingProgress: 0.21,
      releaseDate: DateTime(1954, 9, 17),
      characters: [
        ChatCharacter(
          id: 'ralph_lotf',
          name: 'Ralph',
          lastMessageTime: DateTime.now(),
          description:
              'The elected leader who tries to maintain order and civilization.',
        ),
        ChatCharacter(
          id: 'jack_lotf',
          name: 'Jack',
          lastMessageTime: DateTime.now(),
          description: 'An aggressive hunter who descends into savagery.',
        ),
        ChatCharacter(
          id: 'piggy_lotf',
          name: 'Piggy',
          lastMessageTime: DateTime.now(),
          description:
              'The intellectual voice of reason, often ignored by the others.',
        ),
      ],
    ),
    Book(
      id: '9',
      title: 'Brave New World',
      author: 'Aldous Huxley',
      isRead: false,
      isDownloaded: false,
      readingProgress: 0.0,
      releaseDate: DateTime(1932, 1, 1),
      characters: [
        ChatCharacter(
          id: 'bernard_bnw',
          name: 'Bernard Marx',
          lastMessageTime: DateTime.now(),
          description:
              'An Alpha who feels like an outsider in his perfect world.',
        ),
        ChatCharacter(
          id: 'john_bnw',
          name: 'John the Savage',
          lastMessageTime: DateTime.now(),
          description:
              'An outsider raised on a reservation, struggling to fit into the World State.',
        ),
      ],
    ),
    Book(
      id: '10',
      title: 'The Lord of the Rings',
      author: 'J.R.R. Tolkien',
      isRead: false,
      isDownloaded: true,
      readingProgress: 0.15,
      releaseDate: DateTime(1954, 7, 29),
      characters: [
        ChatCharacter(
          id: 'frodo_lotr',
          name: 'Frodo Baggins',
          lastMessageTime: DateTime.now(),
          description:
              'The ring-bearer, burdened with the fate of Middle-earth.',
        ),
        ChatCharacter(
          id: 'gandalf_lotr',
          name: 'Gandalf',
          lastMessageTime: DateTime.now(),
          description: 'The wise wizard who guides the Fellowship.',
        ),
        ChatCharacter(
          id: 'aragorn_lotr',
          name: 'Aragorn',
          lastMessageTime: DateTime.now(),
          description:
              'The rightful king, a ranger skilled in combat and leadership.',
        ),
        ChatCharacter(
          id: 'samwise_lotr',
          name: 'Samwise Gamgee',
          lastMessageTime: DateTime.now(),
          description:
              'Frodo\'s loyal gardener and best friend. Humble but brave.',
        ),
      ],
    ),
    Book(
      id: '11',
      title: 'Fahrenheit 451',
      author: 'Ray Bradbury',
      isRead: false,
      isDownloaded: true,
      readingProgress: 0.89,
      releaseDate: DateTime(1953, 10, 19),
      characters: [
        ChatCharacter(
          id: 'montag_f451',
          name: 'Guy Montag',
          lastMessageTime: DateTime.now(),
          description:
              'A fireman who begins to question his role in burning books.',
        ),
        ChatCharacter(
          id: 'clarisse_f451',
          name: 'Clarisse McClellan',
          lastMessageTime: DateTime.now(),
          description:
              'A curious young girl who opens Montag\'s eyes to the world.',
        ),
      ],
    ),
    Book(
      id: '12',
      title: 'Jane Eyre',
      author: 'Charlotte Brontë',
      isRead: true,
      isDownloaded: true,
      readingProgress: 1.0,
      releaseDate: DateTime(1847, 10, 16),
      characters: [
        ChatCharacter(
          id: 'jane_je',
          name: 'Jane Eyre',
          lastMessageTime: DateTime.now(),
          description:
              'An independent, strong-willed governess seeking love and belonging.',
        ),
        ChatCharacter(
          id: 'rochester_je',
          name: 'Mr. Rochester',
          lastMessageTime: DateTime.now(),
          description:
              'The brooding master of Thornfield Hall with a dark secret.',
        ),
      ],
    ),
    Book(
      id: '13',
      title: 'Moby Dick',
      author: 'Herman Melville',
      isRead: false,
      isDownloaded: true,
      readingProgress: 0.08,
      releaseDate: DateTime(1851, 10, 18),
      characters: [
        ChatCharacter(
          id: 'ishmael_md',
          name: 'Ishmael',
          lastMessageTime: DateTime.now(),
          description: 'The narrator and sailor, philosophical and observant.',
        ),
        ChatCharacter(
          id: 'ahab_md',
          name: 'Captain Ahab',
          lastMessageTime: DateTime.now(),
          description:
              'The obsessed captain hunting the white whale that took his leg.',
        ),
      ],
    ),
    Book(
      id: '14',
      title: 'The Chronicles of Narnia',
      author: 'C.S. Lewis',
      isRead: false,
      isDownloaded: false,
      readingProgress: 0.0,
      releaseDate: DateTime(1950, 10, 16),
      characters: [
        ChatCharacter(
          id: 'aslan_narnia',
          name: 'Aslan',
          lastMessageTime: DateTime.now(),
          description: 'The great lion, wise and powerful, representing good.',
        ),
        ChatCharacter(
          id: 'lucy_narnia',
          name: 'Lucy Pevensie',
          lastMessageTime: DateTime.now(),
          description:
              'The youngest Pevensie, kind-hearted and the first to discover Narnia.',
        ),
        ChatCharacter(
          id: 'edmund_narnia',
          name: 'Edmund Pevensie',
          lastMessageTime: DateTime.now(),
          description:
              'Initially traitorous but redeemed, learning the value of loyalty.',
        ),
      ],
    ),
    Book(
      id: '15',
      title: 'Wuthering Heights',
      author: 'Emily Brontë',
      isRead: false,
      isDownloaded: true,
      readingProgress: 0.42,
      releaseDate: DateTime(1847, 12, 1),
      characters: [
        ChatCharacter(
          id: 'heathcliff_wh',
          name: 'Heathcliff',
          lastMessageTime: DateTime.now(),
          description:
              'A tortured soul consumed by love, revenge, and obsession.',
        ),
        ChatCharacter(
          id: 'catherine_wh',
          name: 'Catherine Earnshaw',
          lastMessageTime: DateTime.now(),
          description:
              'Wild and passionate, torn between social status and true love.',
        ),
      ],
    ),
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged(String query) {
    setState(() {
      _searchQuery = query;
    });
  }

  void _onSearchFocusChanged(bool isFocused) {
    setState(() {
      _isSearchFocused = isFocused;
    });
  }

  void _onTabSelected(NavTab tab) {
    setState(() {
      _currentTab = tab;
      _searchController.clear();
      _searchQuery = '';
    });
  }

  void _onBookTap(Book book) {
    debugPrint('Libro seleccionado: ${book.title}');
  }

  void _onBookActionPressed(Book book) {
    debugPrint('Acción en libro: ${book.title}');
  }

  void _onPublishPressed() {
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder:
            (context, animation, secondaryAnimation) =>
                const PublishBookScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
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

  String? get _currentSectionTitle {
    switch (_currentTab) {
      case NavTab.home:
        return 'Your Books';
      case NavTab.chat:
        return 'AI Chats';
      case NavTab.shop:
      case NavTab.profile:
        return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.watch<ThemeProvider>().colors;

    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        if (state is ProfileLoaded) {
          return AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            color: colors.background,
            child: Scaffold(
              backgroundColor: Colors.transparent,
              resizeToAvoidBottomInset: false,
              body: SafeArea(
                child: Column(
                  children: [
                    Expanded(
                      child: CustomScrollView(
                        physics:
                            _isSearchFocused
                                ? const NeverScrollableScrollPhysics()
                                : const AlwaysScrollableScrollPhysics(),
                        slivers: [
                          SliverAppBar(
                            floating: true,
                            snap: false,
                            backgroundColor:
                                _currentTab == NavTab.shop
                                    ? Colors.transparent
                                    : colors.background,
                            surfaceTintColor: Colors.transparent,
                            shadowColor: Colors.transparent,
                            foregroundColor: Colors.transparent,
                            elevation: 0,
                            scrolledUnderElevation: 0,
                            toolbarHeight: 72,
                            automaticallyImplyLeading: false,
                            flexibleSpace: SearchHeader(
                              colors: colors,
                              controller: _searchController,
                              onChanged: _onSearchChanged,
                              onFocusChanged: _onSearchFocusChanged,
                              hintText: 'Search Books',
                              transparentBackground: _currentTab == NavTab.shop,
                              showPublishButton: true,
                              onPublishPressed: _onPublishPressed,
                            ),
                          ),

                          if (_currentSectionTitle != null)
                            StickySectionHeader(
                              title: _currentSectionTitle!,
                              colors: colors,
                            ),

                          _buildContent(),
                        ],
                      ),
                    ),

                    BottomNavBar(
                      currentTab: _currentTab,
                      onTabSelected: _onTabSelected,
                      colors: colors,
                      profileInitial: state.name.substring(0, 1).toUpperCase(),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildContent() {
    final colors = context.watch<ThemeProvider>().colors;

    switch (_currentTab) {
      case NavTab.home:
        return HomeContent(
          colors: colors,
          books: _books,
          searchQuery: _searchQuery,
          onBookTap: _onBookTap,
          onBookActionPressed: _onBookActionPressed,
        );
      case NavTab.chat:
        return ChatContent(colors: colors, searchQuery: _searchQuery);
      case NavTab.shop:
        return ShopContent(colors: colors, searchQuery: _searchQuery);
      case NavTab.profile:
        return ProfileContent(colors: colors);
    }
  }
}
