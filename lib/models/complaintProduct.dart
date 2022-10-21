import 'dart:convert';

import 'package:flutter/foundation.dart';

// class Product {
//   final int usd;
//   final int fc ;
//
//   Product(this.usd, this.fc);
//
//   Product.fronJson(Map<String, dynamic> parsedJson):
//   usd = parsedJson['usd'],
//   fc = parsedJson['fc'];
//
// }
enum EvaluationProductQuality {
  priselente,
  prisetroprapide,
  paseconomique,
  resistancefaible
}

enum EvaluationProduct { endommage, durcis, incomplete, quality }

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

class ComplaintProduct {
  var evaluation;
  int qty = 0;

  ComplaintProduct(this.evaluation,this.qty );
  ComplaintProduct.endommage(this.evaluation, this.qty) {
    evaluation = getEvaluationValue();
  }

  ComplaintProduct.durcis(this.evaluation, this.qty) {
    evaluation = getEvaluationValue();
  }

  ComplaintProduct.incomplete(this.evaluation, this.qty) {
    evaluation = getEvaluationValue(); 
  }

  ComplaintProduct.quality(quality) {
    evaluation = getEvaluationQualityValue(quality);
  }

  String getValue() {
    return evaluation.toString();
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      // 'comment': comment,
      'evaluation': evaluation,
      'qty': qty
    };
  }

  String getEvaluationQualityValue(quality) {
    switch (quality) {
      case EvaluationProductQuality.paseconomique:
        return 'Produit peu économique';
        break;

      case EvaluationProductQuality.priselente:
        return 'Produit avec prise lente';
        break;

      case EvaluationProductQuality.prisetroprapide:
        return 'Produit avec prise trop rapide';
        break;

      case EvaluationProductQuality.resistancefaible:
        return 'Produit avec résistance faible';
        break;

      default:
        return null;
    }
  }

  String getEvaluationValue() {
    switch (evaluation) {
      case EvaluationProduct.durcis:
        return 'Produit Durcis';
        break;

      case EvaluationProduct.endommage:
        return 'Produit Endommagé';
        break;

      case EvaluationProduct.incomplete:
        return 'Produit Incomplet';
        break;

      // case EvaluationProduct.quality:
      //   return 'Incomplet';
      //   break;

      default:
        return null;
    }
  }
}
