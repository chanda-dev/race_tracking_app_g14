import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:provider/provider.dart';
import 'package:race_tracking_app_g14/UI/providers/participant_provider.dart';
import 'package:race_tracking_app_g14/models/participant/participant_model.dart';
import 'package:race_tracking_app_g14/UI/screens/manager/widget/result_table.dart';
import 'package:race_tracking_app_g14/UI/theme/theme.dart';

class Results extends StatelessWidget {
  const Results({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.backGroundColor,
      child: Column(
        children: [
          Expanded(child: const ResultTable()),
          Row(
            //crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FloatingActionButton(
                onPressed: () async {
                  await _exportToPdf(context); // Call the PDF export method
                },
                backgroundColor: AppColors.primary,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'PDF',
                    style: TextStyle(color: AppColors.white),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Future<void> _exportToPdf(BuildContext context) async {
    final participantProvider =
        Provider.of<ParticipantProvider>(context, listen: false);
    final participants = participantProvider.participantState?.data ?? [];

    // Create a PDF document
    final pdf = pw.Document();

    // Add a page to the PDF
    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(
                'Race Results',
                style:
                    pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold),
              ),
              pw.SizedBox(height: 16),
              pw.Table(
                border: pw.TableBorder.all(),
                columnWidths: {
                  0: const pw.FlexColumnWidth(1),
                  1: const pw.FlexColumnWidth(1),
                  2: const pw.FlexColumnWidth(2),
                  3: const pw.FlexColumnWidth(2),
                },
                children: [
                  // Table Header
                  pw.TableRow(
                    children: [
                      pw.Text('Rank',
                          style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                      pw.Text('Bib',
                          style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                      pw.Text('Name',
                          style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                      pw.Text('Overall Time',
                          style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                    ],
                  ),
                  // Table Rows
                  ...participants.map((participant) {
                    final overallTime = _formatDuration(
                      participant.runningTime +
                          participant.swimmingTime +
                          participant.cyclingTime,
                    );
                    return pw.TableRow(
                      children: [
                        pw.Text(participant.rank),
                        pw.Text(participant.bibNumber),
                        pw.Text(
                            '${participant.firstName} ${participant.lastName}'),
                        pw.Text(overallTime),
                      ],
                    );
                  }).toList(),
                ],
              ),
            ],
          );
        },
      ),
    );

    // Save or share the PDF
    await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => pdf.save(),
    );
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$hours:$minutes:$seconds';
  }
}
