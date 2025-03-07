import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:moneyboi/Blocs/HomeScreenBloc/homescreen_bloc.dart';
import 'package:moneyboi/Constants/colors.dart';
import 'package:moneyboi/Data%20Models/expense_category.dart';
import 'package:moneyboi/Data%20Models/expense_record.dart';
import 'package:moneyboi/Mock%20Data/mock_categories.dart';
import 'package:moneyboi/Widgets/big_bar_button.dart';
// import 'package:moneyboi/Widgets/text_field_widget.dart';

class NewExpenseCategoryScreen extends StatefulWidget {
  final ExpenseRecordItem? expenseItem;
  final bool isUpdate;
  const NewExpenseCategoryScreen({
    Key? key,
    required this.isUpdate,
    this.expenseItem,
  }) : super(key: key);

  @override
  State<NewExpenseCategoryScreen> createState() =>
      _NewExpenseCategoryScreenState();
}

class _NewExpenseCategoryScreenState extends State<NewExpenseCategoryScreen> {
  late DateTime _recordDate;
  late ExpenseCategory _selectedCategory;
  final TextEditingController _remarksCont = TextEditingController();
  final TextEditingController _amountCont = TextEditingController();

  @override
  void initState() {
    super.initState();
    _selectedCategory =
        widget.isUpdate ? widget.expenseItem!.category : catHome;
    _recordDate =
        widget.isUpdate ? widget.expenseItem!.createdDate : DateTime.now();
    if (widget.isUpdate) {
      _amountCont.text = widget.expenseItem!.expense.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        title: Text(
          widget.isUpdate ? 'EDIT EXPENSE RECORD' : 'ADD EXPENSES',
          style: GoogleFonts.inter(
            fontSize: 18.0,
            fontWeight: FontWeight.w700,
            color: moneyBoyPurple,
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 12.0),
            Container(
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.only(left: 28.0),
              child: Text(
                "Select Category",
                style: GoogleFonts.lato(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 14.0, right: 14.0),
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    childAspectRatio: 1.2,
                    crossAxisSpacing: 12.0,
                    mainAxisSpacing: 24.0,
                  ),
                  itemCount: listOfCategories.length,
                  itemBuilder: (context, index) {
                    final ExpenseCategory _ec = listOfCategories[index];
                    final bool _isSelected = _selectedCategory.name == _ec.name;
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedCategory = _ec;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6.0),
                          color: _isSelected
                              ? moneyBoyPurple.withOpacity(0.8)
                              : Colors.white,
                        ),
                        alignment: Alignment.center,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 41.0,
                              width: 41.0,
                              padding: const EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: _isSelected
                                    ? Colors.white
                                    : Colors.grey.withOpacity(0.3),
                              ),
                              child: Image.asset(_ec.categoryImage),
                            ),
                            Padding(
                              padding: _isSelected
                                  ? const EdgeInsets.only(top: 3.0)
                                  : const EdgeInsets.only(top: 8.0),
                              child: Text(
                                _ec.name,
                                style: GoogleFonts.inter(
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.w500,
                                  color: _isSelected
                                      ? Colors.white
                                      : Colors.black.withOpacity(0.7),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            Divider(
              color: Colors.grey.withOpacity(0.3),
              thickness: 2.0,
            ),
            const SizedBox(height: 32.0),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    DateFormat('yMMMd').format(_recordDate),
                    style: GoogleFonts.lato(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      DatePicker.showDatePicker(
                        context,
                        minTime: DateTime(2018, 3, 5),
                        maxTime: DateTime.now(),
                        onConfirm: (date) {
                          setState(() {
                            _recordDate = date;
                          });
                        },
                        currentTime: _recordDate,
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 24.0,
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 8.0),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: moneyBoyPurple,
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: Text(
                        "Change",
                        style: GoogleFonts.lato(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18.0),
                    border: Border.all(
                      color: moneyBoyPurpleLight,
                    )),
                padding: const EdgeInsets.only(left: 12.0),
                margin: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Theme(
                  data: ThemeData(
                    primaryColor: moneyBoyPurple,
                  ),
                  child: TextField(
                    controller: _amountCont,
                    keyboardType: TextInputType.number,
                    style: GoogleFonts.lato(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w600,
                      color: Colors.black.withOpacity(0.8),
                    ),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      hintText: "",
                      labelText: "Expense Amount *",
                      labelStyle: GoogleFonts.lato(
                        fontWeight: FontWeight.w600,
                        color: Colors.black.withOpacity(0.8),
                      ),
                      hintStyle: GoogleFonts.lato(
                        fontWeight: FontWeight.w400,
                        fontSize: 14.0,
                        color: Colors.black.withOpacity(0.5),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18.0),
                    border: Border.all(
                      color: moneyBoyPurpleLight,
                    )),
                padding: const EdgeInsets.only(left: 12.0),
                margin: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Theme(
                  data: ThemeData(
                    primaryColor: moneyBoyPurple,
                  ),
                  child: TextField(
                    controller: _remarksCont,
                    maxLines: 2,
                    keyboardType: TextInputType.name,
                    style: GoogleFonts.lato(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w600,
                      color: Colors.black.withOpacity(0.8),
                    ),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      hintText: "Enter some notes (optional)",
                      labelText: "Remarks",
                      labelStyle: GoogleFonts.lato(
                        fontWeight: FontWeight.w600,
                        color: Colors.black.withOpacity(0.8),
                      ),
                      hintStyle: GoogleFonts.lato(
                        fontWeight: FontWeight.w400,
                        fontSize: 14.0,
                        color: Colors.black.withOpacity(0.5),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            BlocBuilder<HomeScreenBloc, HomeScreenState>(
              builder: (context, state) {
                if (state is HomeScreenLoaded) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                    child: GestureDetector(
                      onTap: () {
                        if (widget.isUpdate) {
                          if (_amountCont.text != '') {
                            BlocProvider.of<HomeScreenBloc>(context).add(
                              UpdateExpenseRecordEvent(
                                  id: widget.expenseItem!.id,
                                  recordDate: _recordDate.toUtc().toString(),
                                  category: _selectedCategory.name,
                                  remarks: _remarksCont.text,
                                  amount: int.parse(_amountCont.text),
                                  context: context),
                            );
                          }
                        } else {
                          if (_amountCont.text != '') {
                            BlocProvider.of<HomeScreenBloc>(context).add(
                              CreateExpenseRecordEvent(
                                  recordDate: _recordDate.toUtc().toString(),
                                  category: _selectedCategory.name,
                                  remarks: _remarksCont.text,
                                  amount: int.parse(_amountCont.text),
                                  context: context),
                            );
                          }
                        }
                      },
                      child: BigBarButtonBody(
                        horizontalPadding: 60.0,
                        borderRadius: 12.0,
                        child: Text(
                          "Submit",
                          style: GoogleFonts.lato(
                            fontSize: 20.0,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  );
                } else {
                  return const Padding(
                    padding: EdgeInsets.symmetric(vertical: 12.0),
                    child: BigBarButtonBody(
                        horizontalPadding: 60.0,
                        borderRadius: 12.0,
                        child: LinearProgressIndicator(
                          color: Colors.white,
                        )),
                  );
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
