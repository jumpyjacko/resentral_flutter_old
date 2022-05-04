import 'package:flutter/material.dart';

Color getColours(String subj) {
  switch (subj) {
    case "Mathematics":
    case "Maths":
      {
        return Colors.red.shade600;
      } // Red
    case "Sport":
      {
        return Colors.orange.shade600;
      } // Orange
    case "English":
      {
        return Colors.yellow.shade600;
      } // Yellow
    case "Japanese":
      {
        return Colors.green.shade600;
      } // Green
    case "Engineering":
    case "Industrial":
    case "Multimedia":
    case "Timber":
      {
        return Colors.blue.shade600;
      } // Blue
    case "Chemistry":
    case "Biology":
    case "Physics":
    case "Science":
      {
        return Colors.lightBlue.shade600;
      } // Light Blue
    case "HSIE":
    case "Visual":
      {
        return Colors.purple.shade600;
      } // Purple
    default:
      {
        return Colors.grey.shade600;
      }
  }
}
