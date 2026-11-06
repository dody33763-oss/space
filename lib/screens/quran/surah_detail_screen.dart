import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../data/islamic_data.dart';
import '../../models/models.dart';
import '../../theme/app_theme.dart';

class SurahDetailScreen extends StatefulWidget {
  final Surah surah;

  const SurahDetailScreen({super.key, required this.surah});

  @override
  State<SurahDetailScreen> createState() => _SurahDetailScreenState();
}

class _SurahDetailScreenState extends State<SurahDetailScreen> {
  double _fontSize = 24.0;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text("سورة ${widget.surah.name}"),
          actions: [
            // زر التكبير والتصغير
            IconButton(
              icon: const Icon(Icons.zoom_in, color: AppTheme.accentGold),
              tooltip: "تكبير الخط",
              onPressed: () {
                setState(() {
                  if (_fontSize < 38) _fontSize += 2;
                });
              },
            ),
            IconButton(
              icon: const Icon(Icons.zoom_out, color: AppTheme.accentGold),
              tooltip: "تصغير الخط",
              onPressed: () {
                setState(() {
                  if (_fontSize > 16) _fontSize -= 2;
                });
              },
            ),
          ],
        ),
        body: Column(
          children: [
            // ترويسة معلومات السورة
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    AppTheme.primaryGreen,
                    AppTheme.secondaryGreen,
                  ],
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.15),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Text(
                    "سورة ${widget.surah.name}",
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.accentGold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "${widget.surah.type} • عدد الآيات: ${widget.surah.versesCount} • الجزء ${widget.surah.juzNumber}",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white.withOpacity(0.9),
                    ),
                  ),
                  if (widget.surah.id != 1 && widget.surah.id != 9) ...[
                    const SizedBox(height: 12),
                    const Text(
                      IslamicData.bismillah,
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ],
              ),
            ),

            // الآيات
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.all(16),
                itemCount: widget.surah.verses.length,
                separatorBuilder: (context, index) => const Divider(
                  height: 24,
                  thickness: 0.8,
                  color: AppTheme.accentGold,
                ),
                itemBuilder: (context, index) {
                  final verse = widget.surah.verses[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // رقم الآية
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: AppTheme.primaryGreen.withOpacity(0.08),
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: AppTheme.accentGold,
                                  width: 1.5,
                                ),
                              ),
                              child: Text(
                                "${verse.number}",
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: AppTheme.primaryGreen,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),

                            // نص الآية
                            Expanded(
                              child: SelectableText(
                                verse.text,
                                textAlign: TextAlign.justify,
                                style: TextStyle(
                                  fontSize: _fontSize,
                                  height: 2.1,
                                  fontWeight: FontWeight.w500,
                                  color: AppTheme.textDark,
                                ),
                              ),
                            ),
                          ],
                        ),
                        // زر نسخ الآية
                        Align(
                          alignment: Alignment.centerLeft,
                          child: IconButton(
                            icon: const Icon(
                              Icons.copy_rounded,
                              size: 18,
                              color: AppTheme.primaryGreen,
                            ),
                            tooltip: "نسخ الآية",
                            onPressed: () {
                              Clipboard.setData(
                                ClipboardData(text: "${verse.text} [سورة ${widget.surah.name}: ${verse.number}]"),
                              );
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("تم نسخ الآية للحافظة"),
                                  duration: Duration(seconds: 2),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
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
