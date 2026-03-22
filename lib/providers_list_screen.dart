import 'package:flutter/material.dart';
import 'provider_profile_screen.dart';

class ProvidersListScreen extends StatefulWidget {
  final String category;

  const ProvidersListScreen({
    super.key,
    required this.category,
  });

  @override
  State<ProvidersListScreen> createState() => _ProvidersListScreenState();
}

class _ProvidersListScreenState extends State<ProvidersListScreen> {
  String _sortBy = 'distance';

  final List<Map<String, dynamic>> _providers = [
    {
      'avatar': '👨🏾‍🔧',
      'name': 'Kouassi Jean',
      'shop': 'KJ Plomberie Pro',
      'service': 'Plombier',
      'rating': 4.8,
      'reviews': 127,
      'distance': 0.5,
      'price': '8 000 – 25 000 FCFA',
      'available': true,
      'missions': 312,
    },
    {
      'avatar': '👩🏾‍💻',
      'name': 'Diallo Fatou',
      'shop': 'Tech Mobile Angré',
      'service': 'Réparation téléphone',
      'rating': 4.6,
      'reviews': 89,
      'distance': 1.2,
      'price': '5 000 – 20 000 FCFA',
      'available': true,
      'missions': 241,
    },
    {
      'avatar': '👨🏾‍🔩',
      'name': 'Traoré Seydou',
      'shop': 'Auto Expert Cocody',
      'service': 'Mécanicien',
      'rating': 4.9,
      'reviews': 203,
      'distance': 2.1,
      'price': '10 000 – 80 000 FCFA',
      'available': false,
      'missions': 584,
    },
    {
      'avatar': '👩🏾‍🎨',
      'name': 'Adjoua Marie',
      'shop': 'Beauty House',
      'service': 'Coiffeuse',
      'rating': 4.7,
      'reviews': 167,
      'distance': 0.8,
      'price': '3 000 – 25 000 FCFA',
      'available': true,
      'missions': 428,
    },
    {
      'avatar': '👨🏾‍🏭',
      'name': 'N\'Goran Yves',
      'shop': 'ClimPro Service',
      'service': 'Climatisation',
      'rating': 4.5,
      'reviews': 74,
      'distance': 1.7,
      'price': '12 000 – 60 000 FCFA',
      'available': true,
      'missions': 189,
    },
  ];

  List<Map<String, dynamic>> get _sortedProviders {
    final sorted = List<Map<String, dynamic>>.from(_providers);
    if (_sortBy == 'distance') {
      sorted.sort((a, b) =>
          (a['distance'] as double).compareTo(b['distance'] as double));
    } else if (_sortBy == 'note') {
      sorted.sort((a, b) =>
          (b['rating'] as double).compareTo(a['rating'] as double));
    } else if (_sortBy == 'missions') {
      sorted.sort((a, b) =>
          (b['missions'] as int).compareTo(a['missions'] as int));
    } else if (_sortBy == 'avis') {
      sorted.sort((a, b) =>
          (b['reviews'] as int).compareTo(a['reviews'] as int));
    }
    return sorted;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F4EF),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A1A2E),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          widget.category,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w800,
            fontSize: 18,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.map_outlined, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          // Filtres scrollables
          Container(
            color: const Color(0xFF1A1A2E),
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _FilterChip(
                    label: '📍 Distance',
                    selected: _sortBy == 'distance',
                    onTap: () => setState(() => _sortBy = 'distance'),
                  ),
                  const SizedBox(width: 8),
                  _FilterChip(
                    label: '⭐ Note',
                    selected: _sortBy == 'note',
                    onTap: () => setState(() => _sortBy = 'note'),
                  ),
                  const SizedBox(width: 8),
                  _FilterChip(
                    label: '✅ Missions',
                    selected: _sortBy == 'missions',
                    onTap: () => setState(() => _sortBy = 'missions'),
                  ),
                  const SizedBox(width: 8),
                  _FilterChip(
                    label: '💬 Avis clients',
                    selected: _sortBy == 'avis',
                    onTap: () => setState(() => _sortBy = 'avis'),
                  ),
                ],
              ),
            ),
          ),

          // Nombre de résultats
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${_sortedProviders.length} prestataires trouvés',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF8A8A9A),
                  ),
                ),
                Text(
                  'Trié par : $_sortBy',
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFFFF6B35),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),

          // Liste des prestataires
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: _sortedProviders.length,
              itemBuilder: (context, index) {
                final p = _sortedProviders[index];
                return _ProviderCard(provider: p);
              },
            ),
          ),
        ],
      ),
    );
  }
}

// Chip de filtre
class _FilterChip extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _FilterChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: selected ? const Color(0xFFFF6B35) : Colors.white12,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w700,
            color: selected ? Colors.white : Colors.white70,
          ),
        ),
      ),
    );
  }
}

// Carte prestataire
class _ProviderCard extends StatelessWidget {
  final Map<String, dynamic> provider;

  const _ProviderCard({required this.provider});

  @override
  Widget build(BuildContext context) {
    final p = provider;
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
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
          // Avatar
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: const Color(0xFFFF6B35).withOpacity(0.12),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Center(
              child: Text(
                p['avatar'],
                style: const TextStyle(fontSize: 32),
              ),
            ),
          ),
          const SizedBox(width: 14),

          // Infos
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Nom + disponibilité
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      p['name'],
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
                        color: p['available']
                            ? const Color(0xFF2EC4B6).withOpacity(0.12)
                            : const Color(0xFF8A8A9A).withOpacity(0.12),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        p['available'] ? 'Disponible' : 'Occupé',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: p['available']
                              ? const Color(0xFF2EC4B6)
                              : const Color(0xFF8A8A9A),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 2),

                // Boutique
                Text(
                  p['shop'],
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFFFF6B35),
                    fontWeight: FontWeight.w600,
                  ),
                ),

                const SizedBox(height: 6),

                // Note + Avis + Distance
                Row(
                  children: [
                    const Text('⭐', style: TextStyle(fontSize: 12)),
                    const SizedBox(width: 4),
                    Text(
                      '${p['rating']}',
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF1A1A2E),
                      ),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '(${p['reviews']} avis)',
                      style: const TextStyle(
                        fontSize: 12,
                        color: Color(0xFF8A8A9A),
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Icon(
                      Icons.location_on_outlined,
                      size: 12,
                      color: Color(0xFF8A8A9A),
                    ),
                    Text(
                      '${p['distance']} km',
                      style: const TextStyle(
                        fontSize: 12,
                        color: Color(0xFF8A8A9A),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 4),

                // Missions
                Row(
                  children: [
                    const Icon(
                      Icons.check_circle_outline,
                      size: 12,
                      color: Color(0xFF2EC4B6),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '${p['missions']} missions réalisées',
                      style: const TextStyle(
                        fontSize: 12,
                        color: Color(0xFF8A8A9A),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 8),

                // Prix + bouton
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      p['price'],
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFFFF6B35),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProviderProfileScreen(
                              provider: p,
                            ),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFF6B35),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                      ),
                      child: const Text(
                        'Voir profil',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                        ),
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