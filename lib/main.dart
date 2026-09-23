import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Consum Auto',
      theme: ThemeData(
        useMaterial3: true,
        primaryColor: const Color(0xFF3454D1),
        scaffoldBackgroundColor: const Color(0xFFF0F4FF),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF3454D1),
        ),
      ),
      home: const ConsumPage(),
    );
  }
}

class ConsumPage extends StatefulWidget {
  const ConsumPage({super.key});

  @override
  State<ConsumPage> createState() => _ConsumPageState();
}

class _ConsumPageState extends State<ConsumPage> {
  final TextEditingController kmController = TextEditingController();
  final TextEditingController litriController = TextEditingController();

  double? consum;
  String mesajEroare = '';

  void calculeaza() {
    double? km = double.tryParse(
      kmController.text.replaceAll(',', '.'),
    );

    double? litri = double.tryParse(
      litriController.text.replaceAll(',', '.'),
    );

    if (km == null || litri == null || km <= 0 || litri <= 0) {
      setState(() {
        mesajEroare = 'Introdu valori valide, mai mari decat zero!';
        consum = null;
      });
      return;
    }

    setState(() {
      consum = litri * 100 / km;
      mesajEroare = '';
    });

    FocusScope.of(context).unfocus();
  }

  void resetare() {
    kmController.clear();
    litriController.clear();

    setState(() {
      consum = null;
      mesajEroare = '';
    });
  }

  @override
  void dispose() {
    kmController.dispose();
    litriController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const albastru = Color(0xFF3454D1);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Consum Auto',
          style: TextStyle(
            fontSize: 21,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        backgroundColor: albastru,
        foregroundColor: Colors.white,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [

            const SizedBox(height: 15),

            // Partea de sus a paginii
            Container(
              padding: const EdgeInsets.all(25),
              decoration: BoxDecoration(
                color: const Color(0xFFDDE6FF),
                borderRadius: BorderRadius.circular(18),
              ),

              child: const Column(
                children: [
                  Icon(
                    Icons.directions_car,
                    size: 55,
                    color: albastru,
                  ),

                  SizedBox(height: 12),

                  Text(
                    'Calculator de combustibil',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF243B80),
                    ),
                  ),

                  SizedBox(height: 8),

                  Text(
                    'Calculeaza rapid consumul masinii tale',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF667085),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            // Formularul pentru introducerea datelor
            Container(
              padding: const EdgeInsets.all(22),

              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  const Text(
                    'Datele calatoriei',
                    style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 22),

                  const Text(
                    'Distanta parcursa',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                    ),
                  ),

                  const SizedBox(height: 8),

                  TextField(
                    controller: kmController,

                    keyboardType:
                    const TextInputType.numberWithOptions(
                      decimal: true,
                    ),

                    decoration: InputDecoration(
                      hintText: 'Introdu distanta',
                      suffixText: 'km',
                      prefixIcon: const Icon(
                        Icons.route,
                        color: albastru,
                      ),

                      filled: true,
                      fillColor: const Color(0xFFF5F7FF),

                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  const Text(
                    'Combustibil utilizat',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                    ),
                  ),

                  const SizedBox(height: 8),

                  TextField(
                    controller: litriController,

                    keyboardType:
                    const TextInputType.numberWithOptions(
                      decimal: true,
                    ),

                    decoration: InputDecoration(
                      hintText: 'Introdu cantitatea',
                      suffixText: 'litri',
                      prefixIcon: const Icon(
                        Icons.local_gas_station_outlined,
                        color: albastru,
                      ),

                      filled: true,
                      fillColor: const Color(0xFFF5F7FF),

                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),

                  const SizedBox(height: 28),

                  // Buton pentru calcul
                  SizedBox(
                    width: double.infinity,
                    height: 52,

                    child: ElevatedButton(
                      onPressed: calculeaza,

                      style: ElevatedButton.styleFrom(
                        backgroundColor: albastru,
                        foregroundColor: Colors.white,

                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),

                      child: const Text(
                        'Calculeaza consumul',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),

                  // Buton pentru stergerea datelor
                  Center(
                    child: TextButton.icon(
                      onPressed: resetare,
                      icon: const Icon(Icons.refresh),
                      label: const Text('Reseteaza datele'),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Afisarea mesajului de eroare
            if (mesajEroare.isNotEmpty)
              Container(
                padding: const EdgeInsets.all(15),

                decoration: BoxDecoration(
                  color: const Color(0xFFFFE5E5),
                  borderRadius: BorderRadius.circular(12),
                ),

                child: Text(
                  mesajEroare,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),

            // Afisarea rezultatului
            if (consum != null)
              Container(
                padding: const EdgeInsets.all(25),

                decoration: BoxDecoration(
                  color: const Color(0xFFE0F2FE),
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(
                    color: const Color(0xFF93C5FD),
                  ),
                ),

                child: Column(
                  children: [

                    const Icon(
                      Icons.speed,
                      color: albastru,
                      size: 40,
                    ),

                    const SizedBox(height: 12),

                    const Text(
                      'Consumul mediu calculat',
                      style: TextStyle(
                        fontSize: 16,
                        color: Color(0xFF475569),
                      ),
                    ),

                    const SizedBox(height: 10),

                    Text(
                      '${consum!.toStringAsFixed(2)} L/100 km',
                      textAlign: TextAlign.center,

                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: albastru,
                      ),
                    ),

                    const SizedBox(height: 8),

                    const Text(
                      'Rezultatul pentru calatoria introdusa',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFF64748B),
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),

            const SizedBox(height: 30),

            const Text(
              'Formula: Consum = (Litri / Kilometri) × 100',
              textAlign: TextAlign.center,

              style: TextStyle(
                color: Color(0xFF64748B),
                fontSize: 12,
              ),
            ),

            const SizedBox(height: 15),
          ],
        ),
      ),
    );
  }
}