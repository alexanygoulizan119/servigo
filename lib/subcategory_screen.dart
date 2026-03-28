import 'package:flutter/material.dart';
import 'providers_list_screen.dart';

class SubcategoryScreen extends StatelessWidget {
  final String category;
  final String categoryIcon;

  const SubcategoryScreen({
    super.key,
    required this.category,
    required this.categoryIcon,
  });

  // Sous-catégories par catégorie
  static Map<String, List<Map<String, String>>> subcategories = {
    'Maison & Travaux': [
      {'icon': '🚿', 'name': 'Plombier'},
      {'icon': '⚡', 'name': 'Électricien'},
      {'icon': '🪚', 'name': 'Menuisier'},
      {'icon': '🖌️', 'name': 'Peintre'},
      {'icon': '🧱', 'name': 'Maçon'},
      {'icon': '🔑', 'name': 'Serrurier'},
      {'icon': '❄️', 'name': 'Climatisation'},
      {'icon': '🔌', 'name': 'Électroménager'},
      {'icon': '🪟', 'name': 'Carreleur'},
      {'icon': '🏗️', 'name': 'Rénovation'},
    ],
    'Réparation Électronique': [
      {'icon': '📱', 'name': 'Téléphone'},
      {'icon': '💻', 'name': 'Ordinateur'},
      {'icon': '📺', 'name': 'Télévision'},
      {'icon': '🖨️', 'name': 'Imprimante'},
      {'icon': '🎮', 'name': 'Console de jeux'},
      {'icon': '📡', 'name': 'Installation réseau'},
      {'icon': '🔋', 'name': 'Batterie & Chargeur'},
      {'icon': '💾', 'name': 'Récupération données'},
    ],
    'Beauté & Bien-être': [
      {'icon': '💇', 'name': 'Coiffeur'},
      {'icon': '💈', 'name': 'Barbier'},
      {'icon': '💄', 'name': 'Maquillage'},
      {'icon': '💅', 'name': 'Manucure'},
      {'icon': '🦶', 'name': 'Pédicure'},
      {'icon': '💆', 'name': 'Massage'},
      {'icon': '🧴', 'name': 'Soins de peau'},
      {'icon': '🏋️', 'name': 'Coach sportif'},
    ],
    'Nettoyage': [
      {'icon': '🏠', 'name': 'Ménage maison'},
      {'icon': '🏢', 'name': 'Nettoyage bureau'},
      {'icon': '🪟', 'name': 'Nettoyage vitres'},
      {'icon': '🪣', 'name': 'Nettoyage tapis'},
      {'icon': '🌿', 'name': 'Entretien jardin'},
      {'icon': '🐀', 'name': 'Dératisation'},
      {'icon': '🚿', 'name': 'Nettoyage piscine'},
    ],
    'Événementiel': [
      {'icon': '🎧', 'name': 'DJ'},
      {'icon': '📸', 'name': 'Photographe'},
      {'icon': '🎥', 'name': 'Vidéaste'},
      {'icon': '🍽️', 'name': 'Traiteur'},
      {'icon': '🎪', 'name': 'Animateur'},
      {'icon': '💒', 'name': 'Wedding planner'},
      {'icon': '🏛️', 'name': 'Location de salle'},
      {'icon': '🎂', 'name': 'Décoration événement'},
    ],
    'Services Pro': [
      {'icon': '📊', 'name': 'Comptable'},
      {'icon': '📱', 'name': 'Marketing digital'},
      {'icon': '💬', 'name': 'Community manager'},
      {'icon': '🎨', 'name': 'Graphiste'},
      {'icon': '💻', 'name': 'Développeur web'},
      {'icon': '📝', 'name': 'Rédacteur'},
      {'icon': '👥', 'name': 'Recrutement RH'},
      {'icon': '📣', 'name': 'Publicité'},
    ],
  };

  @override
  Widget build(BuildContext context) {
    final subs = subcategories[category] ?? [];

    return Scaffold(
      backgroundColor: const Color(0xFFF8F4EF),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A1A2E),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Row(
          children: [
            Text(categoryIcon, style: const TextStyle(fontSize: 22)),
            const SizedBox(width: 10),
            Text(
              category,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w800,
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF1A1A2E),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  Text(
                    categoryIcon,
                    style: const TextStyle(fontSize: 40),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          category,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${subs.length} types de services disponibles',
                          style: const TextStyle(
                            color: Color(0xFF8A8A9A),
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              'Choisissez un service',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w900,
                color: Color(0xFF1A1A2E),
              ),
            ),

            const SizedBox(height: 14),

            // Grille des sous-catégories
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 1.5,
                ),
                itemCount: subs.length,
                itemBuilder: (context, index) {
                  final sub = subs[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProvidersListScreen(
                            category: sub['name']!,
                          ),
                        ),
                      );
                    },
                    child: Container(
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
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 52,
                            height: 52,
                            decoration: BoxDecoration(
                              color: const Color(0xFFFF6B35).withOpacity(0.1),
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: Center(
                              child: Text(
                                sub['icon']!,
                                style: const TextStyle(fontSize: 26),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            sub['name']!,
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF1A1A2E),
                            ),
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}