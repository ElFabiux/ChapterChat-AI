import 'package:flutter/material.dart';
import '../core/theme/theme_provider.dart';
import '../models/book.dart';
import '../widgets/common/bottom_nav_bar.dart';
import '../widgets/common/search_header.dart';
import 'home/home_content.dart';
import 'chat/chat_content.dart';
import 'shop/shop_content.dart';
import 'profile/profile_content.dart';

class MainShell extends StatefulWidget {
  final ThemeProvider themeProvider;

  const MainShell({super.key, required this.themeProvider});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  NavTab _currentTab = NavTab.home;
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  // Lista de libros de ejemplo
  final List<Book> _books = [
    Book(
      id: '1',
      title: 'Cien años de soledad',
      author: 'Gabriel García Márquez',
      isRead: false,
      isDownloaded: true,
      readingProgress: 0.30,
    ),
    Book(
      id: '2',
      title: 'Sapiens',
      author: 'Yuval Noah Harari',
      isRead: false,
      isDownloaded: false,
      readingProgress: 0.0,
    ),
    Book(
      id: '3',
      title: 'El Principito',
      author: 'Antoine de Saint-Exupéry',
      isRead: false,
      isDownloaded: true,
      readingProgress: 0.67,
    ),
    Book(
      id: '4',
      title: 'The Hobbit',
      author: 'J. R. R. Tolkien',
      isRead: false,
      isDownloaded: true,
      readingProgress: 0.11,
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

  void _onTabSelected(NavTab tab) {
    setState(() {
      _currentTab = tab;
      // Limpiar búsqueda al cambiar de tab
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

  @override
  Widget build(BuildContext context) {
    final colors = widget.themeProvider.colors;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      color: colors.background,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        resizeToAvoidBottomInset: false, // El navbar no se mueve con el teclado
        body: SafeArea(
          child: Column(
            children: [
              // Contenido principal con CustomScrollView
              Expanded(
                child: CustomScrollView(
                  slivers: [
                    // Header con barra de búsqueda (scroll natural, sin fade)
                    SliverToBoxAdapter(
                      child: SearchHeader(
                        colors: colors,
                        controller: _searchController,
                        onChanged: _onSearchChanged,
                        hintText: 'Search Books',
                      ),
                    ),

                    // Contenido según el tab seleccionado
                    _buildContent(),
                  ],
                ),
              ),

              // Footer de navegación (siempre fijo)
              BottomNavBar(
                currentTab: _currentTab,
                onTabSelected: _onTabSelected,
                colors: colors,
                profileInitial: 'F',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContent() {
    final colors = widget.themeProvider.colors;

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
        return ChatContent(
          colors: colors,
          themeProvider: widget.themeProvider,
          searchQuery: _searchQuery,
        );
      case NavTab.shop:
        return ShopContent(colors: colors);
      case NavTab.profile:
        return ProfileContent(
          colors: colors,
          themeProvider: widget.themeProvider,
        );
    }
  }
}
