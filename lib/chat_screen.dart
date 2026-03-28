import 'package:flutter/material.dart';
import 'providers_list_screen.dart';
import 'rating_screen.dart';

class ChatScreen extends StatefulWidget {
  final Map<String, dynamic> provider;

  const ChatScreen({
    super.key,
    required this.provider,
  });

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _devisController = TextEditingController();
  final _propositionController = TextEditingController();

  String _statut = 'attente_devis';
  double? _prixFinal;
  double? _dernierMontantPrestataire;
  double? _dernierMontantClient;
  int _nombreNegociations = 0;

  @override
  Widget build(BuildContext context) {
    final p = widget.provider;
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
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: const Color(0xFFFF6B35).withOpacity(0.2),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(
                  p['avatar'],
                  style: const TextStyle(fontSize: 20),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  p['name'],
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                Text(
                  p['service'],
                  style: const TextStyle(
                    color: Color(0xFF8A8A9A),
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Info sécurité
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: const Color(0xFF1A1A2E).withOpacity(0.06),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Row(
                children: [
                  Icon(Icons.lock, color: Color(0xFF8A8A9A), size: 18),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      '🔒 Espace sécurisé ServiGo\nLes coordonnées sont protégées jusqu\'à l\'accord.',
                      style: TextStyle(
                        fontSize: 12,
                        color: Color(0xFF8A8A9A),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Fourchette de prix indicative
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
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Fourchette de prix indicative',
                        style: TextStyle(
                          fontSize: 12,
                          color: Color(0xFF8A8A9A),
                        ),
                      ),
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
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Compteur négociations
            if (_nombreNegociations > 0)
              Container(
                padding: const EdgeInsets.all(12),
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFD23F).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: const Color(0xFFFFD23F).withOpacity(0.3),
                  ),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.history,
                      color: Color(0xFFFFD23F),
                      size: 18,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '🔄 Négociation — Tour $_nombreNegociations',
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF1A1A2E),
                      ),
                    ),
                  ],
                ),
              ),

            // ═══════════════════════════════════
            // ÉTAPE 1 — Attente du devis
            // ═══════════════════════════════════
            if (_statut == 'attente_devis') ...[
              _StatusCard(
                icon: '⏳',
                title: 'En attente du devis',
                message:
                    'Le prestataire va vous envoyer son devis\npour votre demande de service.',
                color: const Color(0xFF8A8A9A),
              ),
              const SizedBox(height: 20),
              const Text(
                '👇 Simuler la réception d\'un devis',
                style: TextStyle(
                  fontSize: 13,
                  color: Color(0xFF8A8A9A),
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _devisController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'Montant du devis en FCFA',
                  hintStyle: const TextStyle(color: Color(0xFF8A8A9A)),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  prefixIcon: const Icon(
                    Icons.receipt_outlined,
                    color: Color(0xFFFF6B35),
                  ),
                  suffixText: 'FCFA',
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (_devisController.text.isEmpty) return;
                    setState(() {
                      _dernierMontantPrestataire =
                          double.tryParse(_devisController.text) ?? 0;
                      _statut = 'devis_recu';
                      _devisController.clear();
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1A1A2E),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  child: const Text(
                    '📋 Recevoir le devis',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ),
            ],

            // ═══════════════════════════════════
            // ÉTAPE 2 — Devis du prestataire reçu
            // ═══════════════════════════════════
            if (_statut == 'devis_recu') ...[
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFFFF6B35).withOpacity(0.08),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: const Color(0xFFFF6B35).withOpacity(0.3),
                  ),
                ),
                child: Column(
                  children: [
                    Text(
                      _nombreNegociations == 0
                          ? '📋 Devis initial du prestataire'
                          : '📋 Contre-offre #$_nombreNegociations du prestataire',
                      style: const TextStyle(
                        fontSize: 14,
                        color: Color(0xFF8A8A9A),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '${_dernierMontantPrestataire?.toStringAsFixed(0)} FCFA',
                      style: const TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.w900,
                        color: Color(0xFFFF6B35),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              const Text(
                'Que souhaitez-vous faire ?',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF1A1A2E),
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 16),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _prixFinal = _dernierMontantPrestataire;
                      _statut = 'accord_trouve';
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2EC4B6),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  child: Text(
                    '✅ Accepter — ${_dernierMontantPrestataire?.toStringAsFixed(0)} FCFA',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                      fontSize: 15,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 10),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => _showPropositionClientDialog(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFFD23F),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  child: const Text(
                    '💰 Proposer un autre prix',
                    style: TextStyle(
                      color: Color(0xFF1A1A2E),
                      fontWeight: FontWeight.w800,
                      fontSize: 15,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 10),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => _showRefusDialog(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: const BorderSide(
                        color: Color(0xFFFF4444),
                        width: 2,
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  child: const Text(
                    '❌ Refuser le devis',
                    style: TextStyle(
                      color: Color(0xFFFF4444),
                      fontWeight: FontWeight.w800,
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
            ],

            // ═══════════════════════════════════
            // ÉTAPE 3 — Proposition client envoyée
            // ═══════════════════════════════════
            if (_statut == 'proposition_envoyee') ...[
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFD23F).withOpacity(0.08),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: const Color(0xFFFFD23F).withOpacity(0.3),
                  ),
                ),
                child: Column(
                  children: [
                    const Text(
                      '💰 Votre proposition',
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xFF8A8A9A),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '${_dernierMontantClient?.toStringAsFixed(0)} FCFA',
                      style: const TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.w900,
                        color: Color(0xFFFFD23F),
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'En attente de la réponse du prestataire...',
                      style: TextStyle(
                        fontSize: 12,
                        color: Color(0xFF8A8A9A),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              const Text(
                '👇 Simuler la réponse du prestataire',
                style: TextStyle(
                  fontSize: 13,
                  color: Color(0xFF8A8A9A),
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),

              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _prixFinal = _dernierMontantClient;
                          _statut = 'accord_trouve';
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF2EC4B6),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      child: Text(
                        '✅ Accepte\n${_dernierMontantClient?.toStringAsFixed(0)} FCFA',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () =>
                          _showContreOffrePrestataire(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFF6B35),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      child: const Text(
                        '📋 Contre-offre',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],

            // ═══════════════════════════════════
            // ÉTAPE 4 — Accord trouvé
            // ═══════════════════════════════════
            if (_statut == 'accord_trouve') ...[
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFF2EC4B6).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: const Color(0xFF2EC4B6).withOpacity(0.4),
                  ),
                ),
                child: Column(
                  children: [
                    const Text(
                      '🎉 Accord trouvé !',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w900,
                        color: Color(0xFF2EC4B6),
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Prix final validé :',
                      style: TextStyle(
                        fontSize: 13,
                        color: Color(0xFF8A8A9A),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${_prixFinal?.toStringAsFixed(0)} FCFA',
                      style: const TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.w900,
                        color: Color(0xFF1A1A2E),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '👤 Ce que vous voyez maintenant',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF1A1A2E),
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Row(
                      children: [
                        Icon(Icons.map, color: Color(0xFF2EC4B6), size: 20),
                        SizedBox(width: 8),
                        Text(
                          '📍 Position du prestataire activée',
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(0xFF2EC4B6),
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    const Row(
                      children: [
                        Icon(Icons.lock, color: Color(0xFF8A8A9A), size: 20),
                        SizedBox(width: 8),
                        Text(
                          '🔒 Numéro du prestataire protégé',
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(0xFF8A8A9A),
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 12),

              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFF1A1A2E).withOpacity(0.04),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: const Color(0xFF1A1A2E).withOpacity(0.1),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '🔧 Ce que le prestataire reçoit',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF1A1A2E),
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Row(
                      children: [
                        Icon(Icons.map, color: Color(0xFF2EC4B6), size: 20),
                        SizedBox(width: 8),
                        Text(
                          '📍 Votre position en temps réel',
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(0xFF2EC4B6),
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    const Row(
                      children: [
                        Icon(Icons.phone, color: Color(0xFFFF6B35), size: 20),
                        SizedBox(width: 8),
                        Text(
                          '📞 Votre numéro déverrouillé',
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(0xFFFF6B35),
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => _showMissionTermineeDialog(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2EC4B6),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  child: const Text(
                    '✅ Mission terminée',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
            ],

            // ═══════════════════════════════════
            // ÉTAPE 5 — Devis refusé
            // ═══════════════════════════════════
            if (_statut == 'refuse') ...[
              _StatusCard(
                icon: '❌',
                title: 'Devis refusé',
                message:
                    'Vous avez refusé le devis.\n🔔 Le prestataire a été notifié.\nRetournez voir d\'autres prestataires.',
                color: const Color(0xFFFF4444),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: const Color(0xFFFF4444).withOpacity(0.06),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: const Color(0xFFFF4444).withOpacity(0.2),
                  ),
                ),
                child: const Row(
                  children: [
                    Icon(
                      Icons.notifications_active,
                      color: Color(0xFFFF4444),
                      size: 20,
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        '🔔 Notification envoyée :\n"Le client a refusé votre devis."',
                        style: TextStyle(
                          fontSize: 13,
                          color: Color(0xFFFF4444),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProvidersListScreen(
                          category: widget.provider['service'],
                        ),
                      ),
                      (route) => route.isFirst,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1A1A2E),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  child: const Text(
                    '🔍 Voir d\'autres prestataires proches',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  void _showPropositionClientDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          left: 20,
          right: 20,
          top: 20,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '💰 Proposer un prix',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w900,
                color: Color(0xFF1A1A2E),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Devis prestataire : ${_dernierMontantPrestataire?.toStringAsFixed(0)} FCFA',
              style: const TextStyle(fontSize: 13, color: Color(0xFF8A8A9A)),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _propositionController,
              keyboardType: TextInputType.number,
              autofocus: true,
              decoration: InputDecoration(
                hintText: 'Votre prix en FCFA',
                hintStyle: const TextStyle(color: Color(0xFF8A8A9A)),
                filled: true,
                fillColor: const Color(0xFFF8F4EF),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                prefixIcon: const Icon(
                  Icons.payments_outlined,
                  color: Color(0xFFFFD23F),
                ),
                suffixText: 'FCFA',
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (_propositionController.text.isEmpty) return;
                  setState(() {
                    _dernierMontantClient =
                        double.tryParse(_propositionController.text) ?? 0;
                    _statut = 'proposition_envoyee';
                    _propositionController.clear();
                  });
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFFD23F),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                child: const Text(
                  'Envoyer ma proposition',
                  style: TextStyle(
                    color: Color(0xFF1A1A2E),
                    fontWeight: FontWeight.w800,
                    fontSize: 15,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  void _showContreOffrePrestataire(BuildContext context) {
    final controller = TextEditingController();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          left: 20,
          right: 20,
          top: 20,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '📋 Contre-offre du prestataire',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w900,
                color: Color(0xFF1A1A2E),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Proposition client : ${_dernierMontantClient?.toStringAsFixed(0)} FCFA',
              style: const TextStyle(fontSize: 13, color: Color(0xFF8A8A9A)),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: controller,
              keyboardType: TextInputType.number,
              autofocus: true,
              decoration: InputDecoration(
                hintText: 'Nouveau montant en FCFA',
                hintStyle: const TextStyle(color: Color(0xFF8A8A9A)),
                filled: true,
                fillColor: const Color(0xFFF8F4EF),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                prefixIcon: const Icon(
                  Icons.receipt_outlined,
                  color: Color(0xFFFF6B35),
                ),
                suffixText: 'FCFA',
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (controller.text.isEmpty) return;
                  setState(() {
                    _dernierMontantPrestataire =
                        double.tryParse(controller.text) ?? 0;
                    _nombreNegociations++;
                    _statut = 'devis_recu';
                  });
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFF6B35),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                child: const Text(
                  'Envoyer la contre-offre',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                    fontSize: 15,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  void _showRefusDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text(
          '❌ Refuser le devis ?',
          style: TextStyle(
              fontWeight: FontWeight.w900, color: Color(0xFF1A1A2E)),
        ),
        content: const Text(
          'Vous allez refuser ce devis.\nLe prestataire sera notifié et vous serez redirigé vers d\'autres prestataires.',
          style: TextStyle(color: Color(0xFF8A8A9A)),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Annuler',
                style: TextStyle(color: Color(0xFF8A8A9A))),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() => _statut = 'refuse');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFFF4444),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
            ),
            child: const Text('Confirmer le refus',
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.w800)),
          ),
        ],
      ),
    );
  }

  // ✅ CORRECTION — accolade fermante ajoutée
  void _showMissionTermineeDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text(
          '✅ Mission terminée ?',
          style: TextStyle(
              fontWeight: FontWeight.w900, color: Color(0xFF1A1A2E)),
        ),
        content: Text(
          'Confirmez-vous que la mission est terminée ?\nMontant final : ${_prixFinal?.toStringAsFixed(0)} FCFA',
          style: const TextStyle(color: Color(0xFF8A8A9A)),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Non',
                style: TextStyle(color: Color(0xFF8A8A9A))),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => RatingScreen(
                    provider: widget.provider,
                    prixFinal: _prixFinal ?? 0,
                  ),
                ),
                (route) => false,
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF2EC4B6),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
            ),
            child: const Text(
              'Oui, confirmer',
              style: TextStyle(
                  color: Colors.white, fontWeight: FontWeight.w800),
            ),
          ),
        ],
      ),
    );
  }
}

// Widget statut
class _StatusCard extends StatelessWidget {
  final String icon;
  final String title;
  final String message;
  final Color color;

  const _StatusCard({
    required this.icon,
    required this.title,
    required this.message,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: color.withOpacity(0.08),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        children: [
          Text(icon, style: const TextStyle(fontSize: 40)),
          const SizedBox(height: 10),
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w900,
              color: color,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            message,
            textAlign: TextAlign.center,
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