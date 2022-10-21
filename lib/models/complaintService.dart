import 'dart:convert';

import 'package:flutter/foundation.dart';

// class Service{
//   final int usd;
//   final int fc ;
//
//   Service(this.usd, this.fc);
//
//   Service.fronJson(Map<String, dynamic> parsedJson):
//   usd = parsedJson['usd'],
//   fc = parsedJson['fc'];
//
// }
enum EvaluationService { bon, mauvais, excellent }

/*extension EvaluationExtension on Evaluation {
  String get status {
    switch (this) {
      case Evaluation.delay:
        return 'Retard';

        break;
      case Evaluation.badtransporterstate:
        return 'Mauvaise etat du camnionetard';

        break;
      default:
        return null;
    }
  }
}*/

class ComplaintService {
  var evaluation;

  ComplaintService(this.evaluation) {
    evaluation = getValue();
  }
  ComplaintService.withoutEnumVal(this.evaluation);
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      // 'comment': comment,
      'evaluation': evaluation,
    };
  }

  String getValue() {
    switch (evaluation) {
      case EvaluationService.excellent:
        return 'Votre service est excellent';
        break;
      case EvaluationService.bon:
        return 'Votre service est bon';

        break;
      case EvaluationService.mauvais:
        return 'Votre service est mauvais';

        break;

      default:
        return null;
    }
  }
}
