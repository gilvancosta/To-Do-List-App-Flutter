import 'package:flutter/material.dart';

import '../../../widgets/text/text_input_widget.dart';

class TitleTextInputWidget extends StatelessWidget {
  final TextEditingController titleTEC;
  final FocusNode titleFN;
  final FocusNode descriptionFN;
  const TitleTextInputWidget({
    required this.titleTEC,
    required this.titleFN,
    required this.descriptionFN,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextInputWidget(
      controller: titleTEC,
      focusNode: titleFN,
      label: 'Título',
      autofocus: true,
      textCapitalization: TextCapitalization.words,
      onFieldSubmitted: (_) => descriptionFN.requestFocus(),
      validator: (String? newTitle) {
        if (newTitle == null || newTitle.isEmpty) {
          return 'Você precisa adicionar um título';
        }
        return null;
      },
    );
  }
}
