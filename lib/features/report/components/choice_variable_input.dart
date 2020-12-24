import 'package:app/models/choice_response.dart';
import 'package:app/models/choice_type.dart';
import 'package:flutter/material.dart';

class ChoiceVariableInput extends StatelessWidget {
  final ChoiceType choiceType;
  final ChoiceResponse choiceResponse;
  final ValueChanged<ChoiceResponse> onChoiceToggle;

  const ChoiceVariableInput({
    Key key,
    this.choiceType,
    this.choiceResponse,
    this.onChoiceToggle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: choiceType.choices
          .map(
            (choice) => ChoiceChip(
              label: Text(choice.value),
              selected: choiceResponse?.response == choice.id,
              onSelected: (s) => onChoiceToggle(
                ChoiceResponse(choiceType.variable, choice.id),
              ),
            ),
          )
          .toList(),
    );
  }
}