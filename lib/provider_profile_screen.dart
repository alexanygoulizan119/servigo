import 'package:flutter/material.dart';
import 'service_request_screen.dart';

class ProviderProfileScreen extends StatelessWidget {
  final Map<String, dynamic> provider;

  const ProviderProfileScreen({
    super.key,
    required this.provider,
  });

  @override
  Widget build(BuildContext context) {
    final p = provider;
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
              padding: const EdgeInsets.fromLTRB(20, 56, 20, 28),
              child: Column(
                children: [
                  // Bouton retour
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: Colors.white12,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ),
                      const Spacer(),
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.white12,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(
                          Icons.share_outlined,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // Avatar
                  Container(
                    width: 88,
                    height: 88,
                    decoration: BoxDecoration(
                      color: const Color(0xFFFF6B35).withOpacity(0.2),
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Center(
                      child: Text(
                        p['avatar'],
                        style: const TextStyle(fontSize: 48),
                      ),
                    ),
                  ),

                  const SizedBox(height: 14),

                  // Nom
                  Text(
                    p['name'],
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w900,
                    ),
                  ),

                  const SizedBox(height: 4),

                  // Boutique
                  Text(
                    '🏪 ${p['shop']}',
                    style: const TextStyle(
                      color: Color(0xFFFF6B35),
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  const SizedBox(height: 4),

                  // Service
                  Text(
                    p['service'],
                    style: const TextStyle(
                      color: Color(0xFF8A8A9A),
                      fontSize: 14,
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Stats
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _StatItem(
                        value: '${p['rating']}',
                        label: 'Note',
                        icon: '⭐',
                      ),
                      _StatItem(
                        value: '${p['missions']}',
                        label: 'Missions',
                        icon: '✅',
                      ),
                      _StatItem(
                        value: '${p['reviews']}',
                        label: 'Avis',
                        icon: '💬',
                      ),
                      _StatItem(
                        value: '${p['distance']} km',
                        label: 'Distance',
                        icon: '📍',
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Disponibilité
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: p['available']
                          ? const Color(0xFF2EC4B6).withOpacity(0.1)
                          : const Color(0xFF8A8A9A).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: p['available']
                            ? const Color(0xFF2EC4B6).withOpacity(0.3)
                            : const Color(0xFF8A8A9A).withOpacity(0.3),
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          p['available']
                              ? Icons.check_circle
                              : Icons.cancel,
                          color: p['available']
                              ? const Color(0xFF2EC4B6)
                              : const Color(0xFF8A8A9A),
                          size: 22,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          p['available']
                              ? 'Disponible maintenant'
                              : 'Actuellement occupé',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: p['available']
                                ? const Color(0xFF2EC4B6)
                                : const Color(0xFF8A8A9A),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Fourchette de prix
                  const Text(
                    'Fourchette de prix',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFF1A1A2E),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.payments_outlined,
                          color: Color(0xFFFF6B35),
                          size: 24,
                        ),
                        const SizedBox(width: 12),
                        Text(
                          p['price'],
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                            color: Color(0xFFFF6B35),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Services proposés
                  const Text(
                    'Services proposés',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFF1A1A2E),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: const Column(
                      children: [
                        _ServiceItem(
                          name: 'Service de base',
                          price: 'Sur devis',
                          isLast: false,
                        ),
                        _ServiceItem(
                          name: 'Service standard',
                          price: 'Sur devis',
                          isLast: false,
                        ),
                        _ServiceItem(
                          name: 'Service complet',
                          price: 'Sur devis',
                          isLast: true,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Avis clients
                  const Text(
                    'Avis clients',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFF1A1A2E),
                    ),
                  ),
                  const SizedBox(height: 10),

                  const _ReviewCard(
                    name: 'Ama Koné',
                    rating: 5,
                    comment: 'Très rapide et sérieux ! Je recommande.',
                    date: 'Il y a 2 jours',
                  ),
                  const SizedBox(height: 10),
                  const _ReviewCard(
                    name: 'Kofi Brou',
                    rating: 4,
                    comment: 'Bon travail, propre et professionnel.',
                    date: 'Il y a 1 semaine',
                  ),
                  const SizedBox(height: 10),
                  const _ReviewCard(
                    name: 'Sandrine Aka',
                    rating: 5,
                    comment: 'Excellent service, je referai appel à lui.',
                    date: 'Il y a 2 semaines',
                  ),

                  const SizedBox(height: 100),
                ],
              ),
            ),
          ],
        ),
      ),

      // Bouton Demander un service → relié au formulaire
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: SizedBox(
          width: double.infinity,
          height: 54,
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ServiceRequestScreen(
                    provider: p,
                  ),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFFF6B35),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
            child: const Text(
              '📋 Demander un service',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// Widget stat
class _StatItem extends StatelessWidget {
  final String value;
  final String label;
  final String icon;

  const _StatItem({
    required this.value,
    required this.label,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(icon, style: const TextStyle(fontSize: 20)),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 15,
            fontWeight: FontWeight.w800,
          ),
        ),
        Text(
          label,
          style: const TextStyle(
            color: Color(0xFF8A8A9A),
            fontSize: 11,
          ),
        ),
      ],
    );
  }
}

// Widget service
class _ServiceItem extends StatelessWidget {
  final String name;
  final String price;
  final bool isLast;

  const _ServiceItem({
    required this.name,
    required this.price,
    required this.isLast,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        border: !isLast
            ? const Border(
                bottom: BorderSide(
                  color: Color(0xFFF0EDE8),
                  width: 1,
                ),
              )
            : null,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            name,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Color(0xFF1A1A2E),
            ),
          ),
          Text(
            price,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: Color(0xFFFF6B35),
            ),
          ),
        ],
      ),
    );
  }
}

// Widget avis
class _ReviewCard extends StatelessWidget {
  final String name;
  final int rating;
  final String comment;
  final String date;

  const _ReviewCard({
    required this.name,
    required this.rating,
    required this.comment,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                name,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF1A1A2E),
                ),
              ),
              Text(
                date,
                style: const TextStyle(
                  fontSize: 11,
                  color: Color(0xFF8A8A9A),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Row(
            children: List.generate(
              5,
              (index) => Icon(
                index < rating ? Icons.star : Icons.star_border,
                color: const Color(0xFFFFD23F),
                size: 16,
              ),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            comment,
            style: const TextStyle(
              fontSize: 13,
              color: Color(0xFF8A8A9A),
            ),
          ),
        ],
      ),
    );
  }
}