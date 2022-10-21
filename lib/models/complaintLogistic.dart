import 'dart:convert';

import 'package:flutter/foundation.dart';

// class Price {
//   final int usd;
//   final int fc ;
//
//   Price(this.usd, this.fc);
//
//   Price.fronJson(Map<String, dynamic> parsedJson):
//   usd = parsedJson['usd'],
//   fc = parsedJson['fc'];
//
// }
enum EvaluationLogistic { delay, badtransporterstate }

class ComplaintLogistic {
  var evaluation;

  ComplaintLogistic(this.evaluation) {
    evaluation = getValue();
  }
  ComplaintLogistic.withoutEnumVal(this.evaluation);

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      // 'comment': comment,
      'evaluation': evaluation,
    };
  }

  String getValue() {
    switch (evaluation) {
      case EvaluationLogistic.delay:
        return 'Retard de livraison';
        break;

      case EvaluationLogistic.badtransporterstate:
        return 'Mauvais etat du camnion';
        break;

      default:
        return 'nothing';
    }
  }
}
