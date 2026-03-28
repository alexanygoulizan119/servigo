import 'package:flutter/material.dart';
import 'home_screen.dart';

class RatingScreen extends StatefulWidget {
  final Map<String, dynamic> provider;
  final double prixFinal;

  const RatingScreen({
    super.key,
    required this.provider,
    required this.prixFinal,
  });

  @override
  State<RatingScreen> createState() => _RatingScreenState();
}

class _RatingScreenState extends State<RatingScreen> {
  int _note = 0;
  final _commentaireController = TextEditingController();
  bool _avisEnvoye = false;

  final List<String> _suggestions = [
    '👍 Très professionnel',
    '⚡ Très rapide',
    '💰 Bon rapport qualité-prix',
    '🤝 Très ponctuel',
    '🔧 Travail soigné',
    '😊 Très sympa',
  ];

  final List<String> _suggestionsSelectionnees = [];

  @override
  Widget build(BuildContext context) {
    final p = widget.provider;
    return Scaffold(
      backgroundColor: const Color(0xFFF8F4EF),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A1A2E),
        elevation: 0,
        automaticallyImplyLeading: false,
        title: const Text(
          'Noter le prestataire',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w800,
            fontSize: 18,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: _avisEnvoye
            ? _buildMerci(context)
            : _buildFormulaire(p, context),
      ),
    );
  }

  // Formulaire de notation
  Widget _buildFormulaire(Map<String, dynamic> p, BuildContext context) {
    return Column(
      children: [
        // Résumé mission
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFF2EC4B6).withOpacity(0.1),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: const Color(0xFF2EC4B6).withOpacity(0.3),
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: const Color(0xFFFF6B35).withOpacity(0.15),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Center(
                  child: Text(
                    p['avatar'],
                    style: const TextStyle(fontSize: 30),
                  ),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      p['name'],
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF1A1A2E),
                      ),
                    ),
                    Text(
                      p['service'],
                      style: const TextStyle(
                        fontSize: 13,
                        color: Color(0xFF8A8A9A),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '✅ Mission terminée — ${widget.prixFinal.toStringAsFixed(0)} FCFA',
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF2EC4B6),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 28),

        // Note étoiles
        const Text(
          'Quelle note donnez-vous ?',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w900,
            color: Color(0xFF1A1A2E),
          ),
        ),
        const SizedBox(height: 16),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(5, (index) {
            return GestureDetector(
              onTap: () => setState(() => _note = index + 1),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Icon(
                  index < _note ? Icons.star : Icons.star_border,
                  color: const Color(0xFFFFD23F),
                  size: 48,
                ),
              ),
            );
          }),
        ),

        const SizedBox(height: 8),

        // Label de la note
        if (_note > 0)
          Text(
            _getLabelNote(_note),
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Color(0xFFFF6B35),
            ),
          ),

        const SizedBox(height: 24),

        // Suggestions rapides
        const Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Points positifs (optionnel)',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w800,
              color: Color(0xFF1A1A2E),
            ),
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: _suggestions.map((s) {
            final selected = _suggestionsSelectionnees.contains(s);
            return GestureDetector(
              onTap: () {
                setState(() {
                  if (selected) {
                    _suggestionsSelectionnees.remove(s);
                  } else {
                    _suggestionsSelectionnees.add(s);
                  }
                });
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: selected
                      ? const Color(0xFFFF6B35)
                      : Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: selected
                        ? const Color(0xFFFF6B35)
                        : const Color(0xFFE8E4DF),
                  ),
                ),
                child: Text(
                  s,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: selected
                        ? Colors.white
                        : const Color(0xFF1A1A2E),
                  ),
                ),
              ),
            );
          }).toList(),
        ),

        const SizedBox(height: 24),

        // Commentaire
        const Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Votre commentaire (optionnel)',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w800,
              color: Color(0xFF1A1A2E),
            ),
          ),
        ),
        const SizedBox(height: 12),
        TextField(
          controller: _commentaireController,
          maxLines: 3,
          decoration: InputDecoration(
            hintText:
                'Décrivez votre expérience...\nEx: Très professionnel, travail rapide et soigné.',
            hintStyle: const TextStyle(
              color: Color(0xFF8A8A9A),
              fontSize: 13,
            ),
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: const BorderSide(
                color: Color(0xFFFF6B35),
                width: 2,
              ),
            ),
          ),
        ),

        const SizedBox(height: 32),

        // Bouton envoyer
        SizedBox(
          width: double.infinity,
          height: 54,
          child: ElevatedButton(
            onPressed: _note == 0
                ? null
                : () {
                    setState(() => _avisEnvoye = true);
                  },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFFF6B35),
              disabledBackgroundColor: const Color(0xFFE8E4DF),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
            child: Text(
              _note == 0
                  ? 'Sélectionnez une note d\'abord'
                  : '⭐ Envoyer mon avis',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ),

        const SizedBox(height: 12),

        // Passer
        TextButton(
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => const HomeScreen(),
              ),
              (route) => false,
            );
          },
          child: const Text(
            'Passer — noter plus tard',
            style: TextStyle(
              color: Color(0xFF8A8A9A),
              fontSize: 14,
            ),
          ),
        ),

        const SizedBox(height: 40),
      ],
    );
  }

  // Écran merci après notation
  Widget _buildMerci(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 40),
        const Text('🎉', style: TextStyle(fontSize: 80)),
        const SizedBox(height: 20),
        const Text(
          'Merci pour votre avis !',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w900,
            color: Color(0xFF1A1A2E),
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 12),
        const Text(
          'Votre avis aide la communauté\nServiGo à s\'améliorer.',
          style: TextStyle(
            fontSize: 15,
            color: Color(0xFF8A8A9A),
          ),
          textAlign: TextAlign.center,
        ),

        const SizedBox(height: 30),

        // Récap avis
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            children: [
              // Étoiles
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(5, (index) {
                  return Icon(
                    index < _note ? Icons.star : Icons.star_border,
                    color: const Color(0xFFFFD23F),
                    size: 32,
                  );
                }),
              ),
              const SizedBox(height: 12),
              Text(
                _getLabelNote(_note),
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFFFF6B35),
                ),
              ),
              if (_suggestionsSelectionnees.isNotEmpty) ...[
                const SizedBox(height: 12),
                Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  alignment: WrapAlignment.center,
                  children: _suggestionsSelectionnees.map((s) {
                    return Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFF6B35).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        s,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Color(0xFFFF6B35),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
              if (_commentaireController.text.isNotEmpty) ...[
                const SizedBox(height: 12),
                Text(
                  '"${_commentaireController.text}"',
                  style: const TextStyle(
                    fontSize: 13,
                    color: Color(0xFF8A8A9A),
                    fontStyle: FontStyle.italic,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ],
          ),
        ),

        const SizedBox(height: 30),

        // Bouton retour accueil
        SizedBox(
          width: double.infinity,
          height: 54,
          child: ElevatedButton(
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => const HomeScreen(),
                ),
                (route) => false,
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFFF6B35),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
            child: const Text(
              '🏠 Retour à l\'accueil',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ),

        const SizedBox(height: 40),
      ],
    );
  }

  String _getLabelNote(int note) {
    switch (note) {
      case 1:
        return '😞 Très mauvais';
      case 2:
        return '😕 Mauvais';
      case 3:
        return '😐 Correct';
      case 4:
        return '😊 Bien';
      case 5:
        return '🤩 Excellent !';
      default:
        return '';
    }
  }
}