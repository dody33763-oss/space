import 'package:flutter/material.dart';
import '../../data/islamic_data.dart';
import '../../models/models.dart';
import '../../theme/app_theme.dart';
import 'surah_detail_screen.dart';

class QuranHomeScreen extends StatefulWidget {
  const QuranHomeScreen({super.key});

  @override
  State<QuranHomeScreen> createState() => _QuranHomeScreenState();
}

class _QuranHomeScreenState extends State<QuranHomeScreen> {
  List<Surah> _filteredSurahs = [];

  @override
  void initState() {
    super.initState();
    _filteredSurahs = IslamicData.quranSurahs;
  }

  void _filterSurahs(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredSurahs = IslamicData.quranSurahs;
      } else {
        _filteredSurahs = IslamicData.quranSurahs.where((surah) {
          return surah.name.contains(query) ||
              surah.englishName.toLowerCase().contains(query.toLowerCase()) ||
              surah.id.toString() == query;
        }).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "القرآن الكريم",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          leading: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(Icons.menu_book_rounded, color: AppTheme.accentGold, size: 28),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.info_outline, color: AppTheme.accentGold),
              onPressed: () {
                showAboutDialog(
                  context: context,
                  applicationName: "تطبيق القرآن الكريم",
                  applicationVersion: "1.0.0",
                  applicationIcon: const Icon(
                    Icons.menu_book_rounded,
                    size: 40,
                    color: AppTheme.primaryGreen,
                  ),
                  children: [
                    const Text(
                      "تطبيق مخصص لقراءة وتصفح القرآن الكريم بالرسم العثماني الميسر والواضح.",
                      textAlign: TextAlign.right,
                    ),
                  ],
                );
              },
            ),
          ],
        ),
        body: Column(
          children: [
            // بطاقة الترويسة: آخر قراءة مخصصة
            Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [AppTheme.primaryGreen, AppTheme.secondaryGreen],
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                ),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: AppTheme.primaryGreen.withOpacity(0.3),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Row(
                          children: [
                            Icon(Icons.bookmark_rounded, color: AppTheme.accentGold, size: 20),
                            SizedBox(width: 6),
                            Text(
                              "آخر ما قرأت",
                              style: TextStyle(color: Colors.white70, fontSize: 13),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        const Text(
                          "سورة الفاتحة",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.accentGold,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          "الآية رقم 1 • الجزء الأول",
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.9),
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.accentGold,
                      foregroundColor: AppTheme.primaryGreen,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    ),
                    onPressed: () {
                      final firstSurah = IslamicData.quranSurahs.first;
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SurahDetailScreen(surah: firstSurah),
                        ),
                      );
                    },
                    child: const Text(
                      "متابعة القراءة",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),

            // شريط البحث
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: TextField(
                onChanged: _filterSurahs,
                decoration: InputDecoration(
                  hintText: "ابحث عن سورة (مثال: الفاتحة، يس، الإخلاص)...",
                  prefixIcon: const Icon(Icons.search, color: AppTheme.primaryGreen),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(color: AppTheme.accentGold.withOpacity(0.5)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(color: AppTheme.accentGold.withOpacity(0.5)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: const BorderSide(color: AppTheme.primaryGreen, width: 2),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 12),

            // رأس الفهرس
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "فهرس السور (${_filteredSurahs.length})",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.primaryGreen,
                    ),
                  ),
                  const Icon(Icons.format_list_bulleted_rounded, color: AppTheme.accentGold),
                ],
              ),
            ),

            // قائمة السور
            Expanded(
              child: _filteredSurahs.isEmpty
                  ? const Center(
                      child: Text(
                        "لم يتم العثور على نتائج للبحث",
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.all(12),
                      itemCount: _filteredSurahs.length,
                      itemBuilder: (context, index) {
                        final surah = _filteredSurahs[index];
                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
                          child: ListTile(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SurahDetailScreen(surah: surah),
                                ),
                              );
                            },
                            leading: Container(
                              width: 46,
                              height: 46,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppTheme.primaryGreen.withOpacity(0.1),
                                border: Border.all(color: AppTheme.accentGold, width: 1.5),
                              ),
                              child: Text(
                                "${surah.id}",
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: AppTheme.primaryGreen,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            title: Text(
                              "سورة ${surah.name}",
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: AppTheme.textDark,
                              ),
                            ),
                            subtitle: Text(
                              "${surah.type} • ${surah.versesCount} آيات • الجزء ${surah.juzNumber}",
                              style: TextStyle(
                                color: Colors.grey[700],
                                fontSize: 13,
                              ),
                            ),
                            trailing: const Icon(
                              Icons.arrow_forward_ios_rounded,
                              size: 18,
                              color: AppTheme.accentGold,
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
