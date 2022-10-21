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
enum EvaluationPrice { tresHaut, moyen, tropBas }

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

class ComplaintPrice {
  var evaluation;

  ComplaintPrice(this.evaluation) {
    evaluation = getValue();
  }
  ComplaintPrice.withoutEnumVal(this.evaluation);
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      // 'comment': comment,
      'evaluation': evaluation,
    };
  }

  String getValue() {
    switch (evaluation) {
      case EvaluationPrice.tresHaut:
        return 'Prix des produits très élévé';
        break;
      case EvaluationPrice.moyen:
        return 'Prix des produits moyen';

        break;
      case EvaluationPrice.tropBas:
        return 'Prix des produits trop bas';

        break;

      default:
        return null;
    }
  }
}
