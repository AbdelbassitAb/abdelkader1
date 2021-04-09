
import 'package:abdelkader1/models/models.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TransactionsController extends GetxController {
  var description = ''.obs;
  var somme = '0'.obs;
  var currentMoney = 0.obs;
  var loading = false.obs;

  var checkBoxValue = false.obs;
  var selectedWorker = Workerr(name: 'unselected');
  TextEditingController descriptionTextfield = TextEditingController();
  TextEditingController sommeTextfield = TextEditingController();
}
