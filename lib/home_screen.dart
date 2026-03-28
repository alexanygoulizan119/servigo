import 'package:flutter/material.dart';
import 'providers_list_screen.dart';
import 'subcategory_screen.dart';
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F4EF),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header
            Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Color(0xFF1A1A2E),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(28),
                  bottomRight: Radius.circular(28),
                ),
              ),
              padding: const EdgeInsets.fromLTRB(20, 56, 20, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '📍 Abidjan, Côte d\'Ivoire',
                            style: TextStyle(
                              color: Color(0xFF8A8A9A),
                              fontSize: 14,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Bonjour 👋',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 26,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          Text(
                            'Quel service cherchez-vous ?',
                            style: TextStyle(
                              color: Color(0xFF8A8A9A),
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          color: Colors.white12,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(
                          Icons.notifications_outlined,
                          color: Colors.white,
                          size: 26,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // Barre de recherche
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 4,
                    ),
                    child: const Row(
                      children: [
                        Icon(Icons.search,
                            color: Color(0xFF8A8A9A), size: 24),
                        SizedBox(width: 10),
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: 'Plombier, électricien, coiffeur...',
                              hintStyle: TextStyle(
                                color: Color(0xFF8A8A9A),
                                fontSize: 15,
                              ),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Catégories
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Catégories',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFF1A1A2E),
                    ),
                  ),
                  const SizedBox(height: 14),
                  GridView.count(
                    crossAxisCount: 2,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 1.4,
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.push(context,
                          MaterialPageRoute(builder: (context) =>
                             SubcategoryScreen(
        category: 'Maison & Travaux',
        categoryIcon: '🏠',
      ))),
                        child: const _CategoryCard(
                          icon: '🏠',
                          label: 'Maison & Travaux',
                          count: '142 prestataires',
                          color: Color(0xFFFF6B35),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => Navigator.push(context,
                          MaterialPageRoute(builder: (context) =>
                             SubcategoryScreen(category: 'Réparation Électronique', categoryIcon: '🔧'))),
                        child: const _CategoryCard(
                          icon: '🔧',
                          label: 'Réparation Électronique',
                          count: '89 prestataires',
                          color: Color(0xFF2EC4B6),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => Navigator.push(context,
                          MaterialPageRoute(builder: (context) =>
                            SubcategoryScreen(category: 'Beauté & Bien-être', categoryIcon: '💄'))),
                        child: const _CategoryCard(
                          icon: '💄',
                          label: 'Beauté & Bien-être',
                          count: '113 prestataires',
                          color: Color(0xFFFF6B35),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => Navigator.push(context,
                          MaterialPageRoute(builder: (context) =>
                              SubcategoryScreen(category: 'Nettoyage', categoryIcon: '🧹'))),
                        child: const _CategoryCard(
                          icon: '🧹',
                          label: 'Nettoyage',
                          count: '54 prestataires',
                          color: Color(0xFF2EC4B6),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => Navigator.push(context,
                          MaterialPageRoute(builder: (context) =>
                             SubcategoryScreen(category: 'Événementiel', categoryIcon: '🎉'))),
                        child: const _CategoryCard(
                          icon: '🎉',
                          label: 'Événementiel',
                          count: '38 prestataires',
                          color: Color(0xFF1A1A2E),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => Navigator.push(context,
                          MaterialPageRoute(builder: (context) =>
                            SubcategoryScreen(category: 'Services Pro', categoryIcon: '💼'))),
                        child: const _CategoryCard(
                          icon: '💼',
                          label: 'Services Pro',
                          count: '71 prestataires',
                          color: Color(0xFFFF6B35),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  // Section près de vous
                  const Text(
                    'Près de vous ⚡',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFF1A1A2E),
                    ),
                  ),
                  const SizedBox(height: 14),

                  _ProviderCard(
                    avatar: '👨🏾‍🔧',
                    name: 'Kouassi Jean',
                    service: 'Plombier',
                    rating: '4.8',
                    distance: '0.5 km',
                    price: '8 000 – 25 000 FCFA',
                    available: true,
                  ),
                  const SizedBox(height: 10),
                  _ProviderCard(
                    avatar: '👩🏾‍💻',
                    name: 'Diallo Fatou',
                    service: 'Réparation téléphone',
                    rating: '4.6',
                    distance: '1.2 km',
                    price: '5 000 – 20 000 FCFA',
                    available: true,
                  ),
                  const SizedBox(height: 10),
                  _ProviderCard(
                    avatar: '👨🏾‍🔩',
                    name: 'Traoré Seydou',
                    service: 'Mécanicien',
                    rating: '4.9',
                    distance: '2.1 km',
                    price: '10 000 – 80 000 FCFA',
                    available: false,
                  ),
                  const SizedBox(height: 80),
                ],
              ),
            ),
          ],
        ),
      ),

      // Barre de navigation
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFFFF6B35),
        unselectedItemColor: const Color(0xFF8A8A9A),
        backgroundColor: Colors.white,
        currentIndex: 0,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Accueil',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search_outlined),
            activeIcon: Icon(Icons.search),
            label: 'Recherche',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map_outlined),
            activeIcon: Icon(Icons.map),
            label: 'Carte',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_balance_wallet_outlined),
            activeIcon: Icon(Icons.account_balance_wallet),
            label: 'Wallet',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outlined),
            activeIcon: Icon(Icons.person),
            label: 'Profil',
          ),
        ],
      ),
    );
  }
}

// Widget Carte Catégorie
class _CategoryCard extends StatelessWidget {
  final String icon;
  final String label;
  final String count;
  final Color color;

  const _CategoryCard({
    required this.icon,
    required this.label,
    required this.count,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.all(14),
      child: Row(
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: color.withOpacity(0.12),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Text(icon, style: const TextStyle(fontSize: 28)),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1A1A2E),
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  count,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Color(0xFF8A8A9A),
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

// Widget Carte Prestataire
class _ProviderCard extends StatelessWidget {
  final String avatar;
  final String name;
  final String service;
  final String rating;
  final String distance;
  final String price;
  final bool available;

  const _ProviderCard({
    required this.avatar,
    required this.name,
    required this.service,
    required this.rating,
    required this.distance,
    required this.price,
    required this.available,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.all(14),
      child: Row(
        children: [
          Container(
            width: 62,
            height: 62,
            decoration: BoxDecoration(
              color: const Color(0xFFFF6B35).withOpacity(0.12),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Center(
              child: Text(avatar, style: const TextStyle(fontSize: 32)),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF1A1A2E),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: available
                            ? const Color(0xFF2EC4B6).withOpacity(0.12)
                            : const Color(0xFF8A8A9A).withOpacity(0.12),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        available ? 'Disponible' : 'Occupé',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: available
                              ? const Color(0xFF2EC4B6)
                              : const Color(0xFF8A8A9A),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  service,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Color(0xFF8A8A9A),
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    const Text('⭐', style: TextStyle(fontSize: 13)),
                    const SizedBox(width: 4),
                    Text(
                      rating,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF1A1A2E),
                      ),
                    ),
                    const SizedBox(width: 10),
                    const Icon(
                      Icons.location_on_outlined,
                      size: 13,
                      color: Color(0xFF8A8A9A),
                    ),
                    const SizedBox(width: 2),
                    Text(
                      distance,
                      style: const TextStyle(
                        fontSize: 13,
                        color: Color(0xFF8A8A9A),
                      ),
                    ),
                    const Spacer(),
                    Text(
                      price,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFFFF6B35),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}