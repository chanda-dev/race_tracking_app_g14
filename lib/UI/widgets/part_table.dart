import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:race_tracking_app_g14/UI/providers/async_value.dart';
import 'package:race_tracking_app_g14/UI/providers/participant_provider.dart';
import 'package:race_tracking_app_g14/UI/theme/theme.dart';
import 'package:race_tracking_app_g14/UI/widgets/participate_cart.dart';
import 'package:race_tracking_app_g14/models/participant/participant_model.dart';

class PartTable extends StatefulWidget {
  const PartTable({super.key});

  @override
  State<PartTable> createState() => _PartTableState();
}

class _PartTableState extends State<PartTable> {
  void onDelete(Participant participant, BuildContext context) {
    final ParticipantProvider participantProvider = context.read();
    participantProvider.deleteParticipant(participant.id);
    final snackBar = SnackBar(
      content: Text('Data delete'),
      action: SnackBarAction(
        label: 'Undo',
        onPressed:
            () => {participantProvider.undoDeleteParticipant(participant)},
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  bool isClick = false;
  void onOpenParticipantForm() {}
  void onCartPress() {
    setState(() {
      isClick = !isClick;
    });
  }

  void onEdit(String id) {}
  @override
  Widget build(BuildContext context) {
    final participantProvider = Provider.of<ParticipantProvider>(context);
    Widget content = const Text('');
    if (participantProvider.isLoading) {
      content = const Center(child: CircularProgressIndicator());
    } else if (participantProvider.hasData) {
      List<Participant> fetchParticipant =
          participantProvider.participantState!.data!;

      if (fetchParticipant.isEmpty) {
        content = const Center(child: Text("Please Add participant"));
      } else {
        content = Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  const Text(
                    'List of Participants',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      '${participantProvider.participantState!.data!.length} P',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const Spacer(),
                  IconButton(icon: const Icon(Icons.search), onPressed: () {}),
                  IconButton(
                    icon: const Icon(Icons.person_add),
                    onPressed: onOpenParticipantForm,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(color: AppColors.primary),
                    padding: const EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 16,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('BIB', style: TextStyle(color: AppColors.white)),
                        Text('Name', style: TextStyle(color: AppColors.white)),
                        Text('Age', style: TextStyle(color: AppColors.white)),
                      ],
                    ),
                  ),

                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: fetchParticipant.length,
                    itemBuilder:
                        (context, index) => Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 8.0,
                            horizontal: 16,
                          ),
                          child: ParticipateCart(
                            bibNumber: fetchParticipant[index].bibNumber,
                            firstName: fetchParticipant[index].firstName,
                            lastName: fetchParticipant[index].lastName,
                            age: fetchParticipant[index].age.toString(),
                            isClick: isClick,
                            onCartPress: onCartPress,
                            onDelete:
                                () =>
                                    onDelete(fetchParticipant[index], context),
                            id: fetchParticipant[index].id,
                            onEdit: () => onEdit(fetchParticipant[index].id),
                          ),
                        ),
                  ),
                ],
              ),
            ),
          ],
        );
      }
    } else if (participantProvider.participantState?.state ==
        AsyncValueState.error) {
      content = Center(
        child: Text(
          'Error fetching data: ${participantProvider.participantState?.error}',
          style: const TextStyle(color: Colors.red),
        ),
      );
    }
    return Container(child: content);
  }
}
