
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

// MODEL DATA
class Workout {
  final String title, day;
  final int duration;
  final double calories;
  final bool completed;
  const Workout({required this.title, required this.day, required this.duration, required this.calories, required this.completed});
}

// MY APP
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: const Color(0xFFF2F7FF),
        appBarTheme: const AppBarTheme(backgroundColor: Color(0xFF356AC3), foregroundColor: Colors.white),
      ),
      home: const LayarUtama(),
    );
  }
}

// HALAMAN UTAMA
class LayarUtama extends StatefulWidget {
  const LayarUtama({super.key});
  @override
  State<LayarUtama> createState() => _LayarUtamaState();
}

class _LayarUtamaState extends State<LayarUtama> {
  final List<Workout> daftarLatihan = [
    const Workout(title: 'Jalan Cepat Pagi', day: 'Senin, 06.30', duration: 30, calories: 150.0, completed: false),
    const Workout(title: 'Yoga Ringan', day: 'Rabu, 17.00', duration: 25, calories: 100.0, completed: false),
    const Workout(title: 'Latihan Kekuatan', day: 'Jumat, 16.30', duration: 40, calories: 200.0, completed: false),
    const Workout(title: 'Bersepeda Santai', day: 'Minggu, 07.00', duration: 45, calories: 220.0, completed: false),
  ];

  void tandaiSelesai(int index) {
    setState(() {
      final latihan = daftarLatihan[index];
      daftarLatihan[index] = Workout(
        title: latihan.title, day: latihan.day, duration: latihan.duration,
        calories: latihan.calories, completed: !latihan.completed,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final selesai = daftarLatihan.where((latihan) => latihan.completed).length;
    final durasi = daftarLatihan.where((latihan) => latihan.completed).fold(0, (total, latihan) => total + latihan.duration);
    final progres = selesai / daftarLatihan.length;

    return Scaffold(
      appBar: AppBar(title: const Text('FitDiet')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 500),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text('Jadwal latihan untuk mendukung perjalanan diet sehatmu.',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF173567))),
                const SizedBox(height: 8),
                const Text('Mulai dari langkah kecil dan lakukan secara konsisten!'),
                const SizedBox(height: 20),
                Card(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      const Row(children: [
                        Icon(Icons.bar_chart, color: Color(0xFF3984F5), size: 30),
                        SizedBox(width: 10),
                        Expanded(child: Text('Progres Latihan Mingguan', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16))),
                      ]),
                      const SizedBox(height: 12),
                      Text('$selesai dari ${daftarLatihan.length} latihan selesai'),
                      const SizedBox(height: 10),
                      LinearProgressIndicator(value: progres, minHeight: 8, backgroundColor: Color(0xFFE1EBFA), color: Color(0xFF3984F5)),
                      const SizedBox(height: 12),
                      Wrap(spacing: 20, runSpacing: 8, children: [
                        Text('Durasi selesai: $durasi menit'),
                        Text('Penyelesaian: ${(progres * 100).round()}%'),
                      ]),
                    ]),
                  ),
                ),
                const SizedBox(height: 20),
                const Text('Jadwal Olahraga', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF173567))),
                const SizedBox(height: 10),
                ...daftarLatihan.asMap().entries.map((entry) => KartuLatihan(
                  workout: entry.value,
                  onPressed: () => tandaiSelesai(entry.key),
                )),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(color: const Color(0xFFE1EDFF), borderRadius: BorderRadius.circular(16)),
                  child: const Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Icon(Icons.lightbulb_outline, color: Color(0xFF356AC3), size: 28),
                    SizedBox(width: 12),
                    Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Text('Tips Diet Sehat', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                      SizedBox(height: 6),
                      Text('Kombinasikan olahraga teratur, pola makan seimbang, dan istirahat yang cukup untuk mendukung kesehatan tubuh.'),
                    ])),
                  ]),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// CUSTOM WIDGET KARTU LATIHAN
class KartuLatihan extends StatelessWidget {
  final Workout workout;
  final VoidCallback onPressed;
  const KartuLatihan({super.key, required this.workout, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(children: [
            Container(
              width: 44, height: 44,
              decoration: BoxDecoration(color: const Color(0xFFE5EEFF), borderRadius: BorderRadius.circular(12)),
              child: Icon(workout.completed ? Icons.check_circle : Icons.fitness_center, color: const Color(0xFF3984F5)),
            ),
            const SizedBox(width: 12),
            Expanded(child: Text(workout.title, style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Color(0xFF173567)))),
          ]),
          const SizedBox(height: 10),
          Text('Hari dan waktu: ${workout.day}'),
          Text('Durasi: ${workout.duration} menit'),
          Text('Estimasi kalori: ${workout.calories.toStringAsFixed(0)} kkal'),
          const SizedBox(height: 10),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF3984F5), foregroundColor: Colors.white),
            onPressed: onPressed,
            child: Text(workout.completed ? 'Batalkan' : 'Selesai'),
          ),
          if (workout.completed) const Text('Latihan selesai!', style: TextStyle(color: Color(0xFF356AC3), fontWeight: FontWeight.bold)),
        ]),
      ),
    );
  }
}