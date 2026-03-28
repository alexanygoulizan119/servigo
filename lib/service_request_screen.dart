import 'package:flutter/material.dart';
import 'chat_screen.dart';

class ServiceRequestScreen extends StatefulWidget {
  final Map<String, dynamic> provider;

  const ServiceRequestScreen({
    super.key,
    required this.provider,
  });

  @override
  State<ServiceRequestScreen> createState() => _ServiceRequestScreenState();
}

class _ServiceRequestScreenState extends State<ServiceRequestScreen> {
  final _descriptionController = TextEditingController();
  final _locationController = TextEditingController();
  String _urgency = 'normal';
  String _problemType = '';
  int _currentStep = 0;

  final List<String> _problemTypes = [
    '🔧 Réparation',
    '🏗️ Installation',
    '🔍 Diagnostic',
    '🧹 Entretien',
    '🆘 Urgence',
    '💡 Autre',
  ];

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
        title: const Text(
          'Demande de service',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w800,
            fontSize: 18,
          ),
        ),
      ),
      body: Column(
        children: [
          // Barre de progression
          Container(
            color: const Color(0xFF1A1A2E),
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: Row(
              children: List.generate(3, (index) {
                return Expanded(
                  child: Container(
                    margin: EdgeInsets.only(right: index < 2 ? 8 : 0),
                    height: 4,
                    decoration: BoxDecoration(
                      color: index <= _currentStep
                          ? const Color(0xFFFF6B35)
                          : Colors.white24,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                );
              }),
            ),
          ),

          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Prestataire sélectionné
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: const Color(0xFFFF6B35).withOpacity(0.3),
                      ),
                    ),
                    child: Row(
                      children: [
                        Text(
                          widget.provider['avatar'],
                          style: const TextStyle(fontSize: 32),
                        ),
                        const SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.provider['name'],
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w800,
                                color: Color(0xFF1A1A2E),
                              ),
                            ),
                            Text(
                              widget.provider['service'],
                              style: const TextStyle(
                                fontSize: 13,
                                color: Color(0xFF8A8A9A),
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        Text(
                          widget.provider['price'],
                          style: const TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFFFF6B35),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  // ÉTAPE 1 — Type de problème
                  _StepTitle(
                    number: '1',
                    title: 'Type de problème',
                    done: _problemType.isNotEmpty,
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: _problemTypes.map((type) {
                      final selected = _problemType == type;
                      return GestureDetector(
                        onTap: () => setState(() {
                          _problemType = type;
                          if (_currentStep < 1) _currentStep = 1;
                        }),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                            color: selected
                                ? const Color(0xFFFF6B35)
                                : Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: selected
                                  ? const Color(0xFFFF6B35)
                                  : const Color(0xFFE8E4DF),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.04),
                                blurRadius: 6,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Text(
                            type,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
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

                  // ÉTAPE 2 — Description
                  _StepTitle(
                    number: '2',
                    title: 'Description du problème',
                    done: _descriptionController.text.isNotEmpty,
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: _descriptionController,
                    maxLines: 4,
                    onChanged: (val) {
                      setState(() {
                        if (_currentStep < 2) _currentStep = 2;
                      });
                    },
                    decoration: InputDecoration(
                      hintText:
                          'Décrivez votre problème en détail...\nEx: Mon robinet fuit depuis 2 jours.',
                      hintStyle: const TextStyle(
                        color: Color(0xFF8A8A9A),
                        fontSize: 14,
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

                  const SizedBox(height: 24),

                  // ÉTAPE 2b — Ajout de photos
                  const Text(
                    'Ajouter des photos / vidéos',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF1A1A2E),
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Aidez le prestataire à mieux comprendre le problème',
                    style: TextStyle(
                      fontSize: 13,
                      color: Color(0xFF8A8A9A),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      _MediaButton(
                        icon: Icons.camera_alt_outlined,
                        label: 'Photo',
                        onTap: () => ScaffoldMessenger.of(context)
                            .showSnackBar(
                          const SnackBar(
                            content: Text(
                                'Caméra disponible après connexion Firebase !'),
                            backgroundColor: Color(0xFFFF6B35),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      _MediaButton(
                        icon: Icons.videocam_outlined,
                        label: 'Vidéo courte',
                        onTap: () => ScaffoldMessenger.of(context)
                            .showSnackBar(
                          const SnackBar(
                            content: Text(
                                'Vidéo disponible après connexion Firebase !'),
                            backgroundColor: Color(0xFFFF6B35),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      _MediaButton(
                        icon: Icons.photo_library_outlined,
                        label: 'Galerie',
                        onTap: () => ScaffoldMessenger.of(context)
                            .showSnackBar(
                          const SnackBar(
                            content: Text(
                                'Galerie disponible après connexion Firebase !'),
                            backgroundColor: Color(0xFFFF6B35),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  // ÉTAPE 3 — Localisation
                  _StepTitle(
                    number: '3',
                    title: 'Votre localisation',
                    done: _locationController.text.isNotEmpty,
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: _locationController,
                    onChanged: (val) => setState(() {}),
                    decoration: InputDecoration(
                      hintText: 'Ex: Cocody Angré, près du carrefour...',
                      hintStyle: const TextStyle(
                        color: Color(0xFF8A8A9A),
                        fontSize: 14,
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
                      prefixIcon: const Icon(
                        Icons.location_on_outlined,
                        color: Color(0xFFFF6B35),
                      ),
                      suffixIcon: TextButton(
                        onPressed: () {
                          setState(() {
                            _locationController.text =
                                'Cocody Angré, Abidjan';
                          });
                        },
                        child: const Text(
                          'Ma position',
                          style: TextStyle(
                            color: Color(0xFFFF6B35),
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Urgence
                  const Text(
                    '⚡ Niveau d\'urgence',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF1A1A2E),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      _UrgencyButton(
                        label: 'Normal',
                        icon: '🟢',
                        selected: _urgency == 'normal',
                        onTap: () =>
                            setState(() => _urgency = 'normal'),
                      ),
                      const SizedBox(width: 8),
                      _UrgencyButton(
                        label: 'Urgent',
                        icon: '🟡',
                        selected: _urgency == 'urgent',
                        onTap: () =>
                            setState(() => _urgency = 'urgent'),
                      ),
                      const SizedBox(width: 8),
                      _UrgencyButton(
                        label: 'Très urgent',
                        icon: '🔴',
                        selected: _urgency == 'tres_urgent',
                        onTap: () =>
                            setState(() => _urgency = 'tres_urgent'),
                      ),
                    ],
                  ),

                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),
        ],
      ),

      // Bouton Envoyer → vers Chat
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
            onPressed: _problemType.isEmpty ||
                    _descriptionController.text.isEmpty ||
                    _locationController.text.isEmpty
                ? null
                : () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                            '✅ Demande envoyée ! En attente du devis...'),
                        backgroundColor: Color(0xFF2EC4B6),
                        duration: Duration(seconds: 2),
                      ),
                    );
                    Future.delayed(const Duration(seconds: 2), () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ChatScreen(
                            provider: widget.provider,
                          ),
                        ),
                      );
                    });
                  },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFFF6B35),
              disabledBackgroundColor: const Color(0xFFE8E4DF),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
            child: Text(
              _problemType.isEmpty ||
                      _descriptionController.text.isEmpty ||
                      _locationController.text.isEmpty
                  ? 'Remplissez tous les champs'
                  : '📤 Envoyer la demande',
              style: const TextStyle(
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

// Titre d'étape
class _StepTitle extends StatelessWidget {
  final String number;
  final String title;
  final bool done;

  const _StepTitle({
    required this.number,
    required this.title,
    required this.done,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 28,
          height: 28,
          decoration: BoxDecoration(
            color: done
                ? const Color(0xFF2EC4B6)
                : const Color(0xFFFF6B35),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: Text(
              done ? '✓' : number,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 13,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w800,
            color: Color(0xFF1A1A2E),
          ),
        ),
      ],
    );
  }
}

// Bouton media
class _MediaButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _MediaButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: const Color(0xFFE8E4DF),
            ),
          ),
          child: Column(
            children: [
              Icon(icon, color: const Color(0xFFFF6B35), size: 28),
              const SizedBox(height: 6),
              Text(
                label,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF1A1A2E),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Bouton urgence
class _UrgencyButton extends StatelessWidget {
  final String label;
  final String icon;
  final bool selected;
  final VoidCallback onTap;

  const _UrgencyButton({
    required this.label,
    required this.icon,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: selected
                ? const Color(0xFFFF6B35)
                : Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: selected
                  ? const Color(0xFFFF6B35)
                  : const Color(0xFFE8E4DF),
            ),
          ),
          child: Column(
            children: [
              Text(icon, style: const TextStyle(fontSize: 20)),
              const SizedBox(height: 4),
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: selected
                      ? Colors.white
                      : const Color(0xFF1A1A2E),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}