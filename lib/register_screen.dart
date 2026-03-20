import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isPasswordVisible = false;
  String _userType = 'client';

  // Détection opérateur ivoirien
  String _getOperator() {
    String phone = _phoneController.text;
    if (phone.length < 2) return '';
    String prefix = phone.substring(0, 2);
    switch (prefix) {
      case '07':
        return '📶 Orange CI';
      case '05':
        return '📶 MTN CI';
      case '01':
        return '📶 Moov Africa';
      default:
        return '❓ Opérateur non reconnu';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F4EF),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 60),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Logo
            Container(
              width: 72,
              height: 72,
              decoration: BoxDecoration(
                color: const Color(0xFFFF6B35),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Icon(
                Icons.handyman,
                color: Colors.white,
                size: 40,
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              'Créer un compte',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.w900,
                color: Color(0xFF1A1A2E),
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              'Rejoignez ServiGo gratuitement',
              style: TextStyle(
                fontSize: 13,
                color: Color(0xFF8A8A9A),
              ),
            ),

            const SizedBox(height: 32),

            // Toggle Client / Prestataire
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Je suis un :',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF1A1A2E),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFFE8E4DF),
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.all(4),
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() => _userType = 'client'),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          color: _userType == 'client'
                              ? const Color(0xFFFF6B35)
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            '👤 Client',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 14,
                              color: _userType == 'client'
                                  ? Colors.white
                                  : const Color(0xFF8A8A9A),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() => _userType = 'prestataire'),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          color: _userType == 'prestataire'
                              ? const Color(0xFFFF6B35)
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            '🔧 Prestataire',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 14,
                              color: _userType == 'prestataire'
                                  ? Colors.white
                                  : const Color(0xFF8A8A9A),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Nom complet
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Nom complet',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF1A1A2E),
                ),
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                hintText: 'Kouassi Jean',
                hintStyle: const TextStyle(color: Color(0xFF8A8A9A)),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                prefixIcon: const Icon(
                  Icons.person_outlined,
                  color: Color(0xFF8A8A9A),
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Téléphone
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Numéro de téléphone',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF1A1A2E),
                ),
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              maxLength: 10,
              onChanged: (value) {
                setState(() {});
              },
              decoration: InputDecoration(
                hintText: '0712345678',
                hintStyle: const TextStyle(color: Color(0xFF8A8A9A)),
                filled: true,
                fillColor: Colors.white,
                counterText: '',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                prefixIcon: const Icon(
                  Icons.phone_outlined,
                  color: Color(0xFF8A8A9A),
                ),
                prefixText: '+225 ',
                prefixStyle: const TextStyle(
                  color: Color(0xFF1A1A2E),
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                ),
                suffix: _phoneController.text.length == 10
                    ? const Icon(Icons.check_circle,
                        color: Color(0xFF2EC4B6), size: 20)
                    : null,
                helperText: _getOperator(),
                helperStyle: const TextStyle(
                  color: Color(0xFFFF6B35),
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Email
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Email',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF1A1A2E),
                ),
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                hintText: 'votre@email.com',
                hintStyle: const TextStyle(color: Color(0xFF8A8A9A)),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                prefixIcon: const Icon(
                  Icons.email_outlined,
                  color: Color(0xFF8A8A9A),
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Mot de passe
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Mot de passe',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF1A1A2E),
                ),
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _passwordController,
              obscureText: !_isPasswordVisible,
              decoration: InputDecoration(
                hintText: '••••••••',
                hintStyle: const TextStyle(color: Color(0xFF8A8A9A)),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                prefixIcon: const Icon(
                  Icons.lock_outlined,
                  color: Color(0xFF8A8A9A),
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                    _isPasswordVisible
                        ? Icons.visibility_off
                        : Icons.visibility,
                    color: const Color(0xFF8A8A9A),
                  ),
                  onPressed: () {
                    setState(() {
                      _isPasswordVisible = !_isPasswordVisible;
                    });
                  },
                ),
              ),
            ),

            // Champs supplémentaires si Prestataire
            if (_userType == 'prestataire') ...[
              const SizedBox(height: 16),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Nom de votre boutique (facultatif)',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1A1A2E),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                decoration: InputDecoration(
                  hintText: 'Ex: KJ Plomberie Pro',
                  hintStyle: const TextStyle(color: Color(0xFF8A8A9A)),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  prefixIcon: const Icon(
                    Icons.store_outlined,
                    color: Color(0xFF8A8A9A),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Type de service proposé',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1A1A2E),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                decoration: InputDecoration(
                  hintText: 'Ex: Plombier, Électricien...',
                  hintStyle: const TextStyle(color: Color(0xFF8A8A9A)),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  prefixIcon: const Icon(
                    Icons.build_outlined,
                    color: Color(0xFF8A8A9A),
                  ),
                ),
              ),
            ],

            const SizedBox(height: 32),

            // Bouton S'inscrire
            SizedBox(
              width: double.infinity,
              height: 54,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFF6B35),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: const Text(
                  "S'inscrire",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Déjà un compte
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: RichText(
                text: const TextSpan(
                  text: "Déjà un compte ? ",
                  style: TextStyle(
                    color: Color(0xFF8A8A9A),
                    fontSize: 14,
                  ),
                  children: [
                    TextSpan(
                      text: "Se connecter",
                      style: TextStyle(
                        color: Color(0xFFFF6B35),
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}