import 'package:flutter/material.dart';

import '../widgets/car_loan_calculator.dart';
import '../widgets/car_loan_chart.dart';
import '../widgets/car_loan_input_card.dart';
import '../widgets/car_loan_result_card.dart';

class CarLoanScreen extends StatefulWidget {
  const CarLoanScreen({
    super.key,
  });

  @override
  State<CarLoanScreen> createState() =>
      _CarLoanScreenState();
}

class _CarLoanScreenState
    extends State<CarLoanScreen> {

  // ------------------------------------------------
  // INPUT VALUES
  // ------------------------------------------------

  double carPrice = 1200000;

  double downPayment = 200000;

  double interestRate = 9.0;

  double tenureYears = 5;

  // ------------------------------------------------
  // RESULT VALUES
  // ------------------------------------------------

  double loanAmount = 0;

  double emi = 0;

  double totalInterest = 0;

  double totalPayment = 0;

  @override
  void initState() {
    super.initState();

    _calculateLoan();
  }

  // ------------------------------------------------
  // CALCULATE
  // ------------------------------------------------

  void _calculateLoan() {

    final calculatedLoanAmount =
        CarLoanCalculator
            .calculateLoanAmount(
      carPrice: carPrice,
      downPayment: downPayment,
    );

    final calculatedEmi =
        CarLoanCalculator.calculateEmi(
      principal:
          calculatedLoanAmount,
      annualInterestRate:
          interestRate,
      tenureYears:
          tenureYears.round(),
    );

    final calculatedTotalPayment =
        CarLoanCalculator
            .calculateTotalPayment(
      emi: calculatedEmi,
      tenureYears:
          tenureYears.round(),
    );

    final calculatedInterest =
        CarLoanCalculator
            .calculateTotalInterest(
      totalPayment:
          calculatedTotalPayment,
      principal:
          calculatedLoanAmount,
    );

    setState(() {
      loanAmount =
          calculatedLoanAmount;

      emi = calculatedEmi;

      totalPayment =
          calculatedTotalPayment;

      totalInterest =
          calculatedInterest;
    });
  }

  // ------------------------------------------------
  // FORMAT CURRENCY
  // ------------------------------------------------

  String _formatCurrency(double value) {
    return '₹${value.round()}';
  }

  // ------------------------------------------------
  // BUILD
  // ------------------------------------------------

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor:
          const Color(0xFFF8F9FC),

      body: SafeArea(
        child: Column(
          children: [

            _buildHeader(),

            Expanded(
              child: SingleChildScrollView(
                padding:
                    const EdgeInsets.fromLTRB(
                  16,
                  8,
                  16,
                  100,
                ),
                child: Column(
                  children: [

                    _buildIntro(),

                    const SizedBox(height: 18),

                    // --------------------------------
                    // CAR PRICE
                    // --------------------------------

                    CarLoanInputCard(
                      title: 'Car Price',

                      value:
                          _formatCurrency(
                        carPrice,
                      ),

                      minLabel:
                          '₹2 Lakh',

                      maxLabel:
                          '₹50 Lakh',

                      icon:
                          Icons.directions_car_rounded,

                      iconColor:
                          const Color(
                        0xFF2196F3,
                      ),

                      sliderValue:
                          carPrice,

                      min: 200000,

                      max: 5000000,

                      divisions: 240,

                      onChanged: (value) {
                        setState(() {
                          carPrice = value;

                          // Down payment
                          // cannot exceed car price
                          if (downPayment >
                              carPrice) {
                            downPayment =
                                carPrice;
                          }
                        });
                      },
                    ),

                    const SizedBox(height: 14),

                    // --------------------------------
                    // DOWN PAYMENT
                    // --------------------------------

                    CarLoanInputCard(
                      title: 'Down Payment',

                      value:
                          _formatCurrency(
                        downPayment,
                      ),

                      minLabel:
                          '₹0',

                      maxLabel:
                          _formatCurrency(
                        carPrice,
                      ),

                      icon:
                          Icons.payments_rounded,

                      iconColor:
                          const Color(
                        0xFF19A86B,
                      ),

                      sliderValue:
                          downPayment,

                      min: 0,

                      max: carPrice,

                      divisions:
                          carPrice > 0
                              ? 100
                              : 1,

                      onChanged: (value) {
                        setState(() {
                          downPayment =
                              value;
                        });
                      },
                    ),

                    const SizedBox(height: 14),

                    // --------------------------------
                    // INTEREST RATE
                    // --------------------------------

                    CarLoanInputCard(
                      title:
                          'Interest Rate',

                      value:
                          '${interestRate.toStringAsFixed(1)}%',

                      minLabel:
                          '5%',

                      maxLabel:
                          '20%',

                      icon:
                          Icons.percent_rounded,

                      iconColor:
                          const Color(
                        0xFF8B5CF6,
                      ),

                      sliderValue:
                          interestRate,

                      min: 5,

                      max: 20,

                      divisions: 150,

                      onChanged: (value) {
                        setState(() {
                          interestRate =
                              value;
                        });
                      },
                    ),

                    const SizedBox(height: 14),

                    // --------------------------------
                    // TENURE
                    // --------------------------------

                    CarLoanInputCard(
                      title:
                          'Loan Tenure',

                      value:
                          '${tenureYears.round()} Years',

                      minLabel:
                          '1 Year',

                      maxLabel:
                          '7 Years',

                      icon:
                          Icons.calendar_month_rounded,

                      iconColor:
                          const Color(
                        0xFFFF9A3D,
                      ),

                      sliderValue:
                          tenureYears,

                      min: 1,

                      max: 7,

                      divisions: 6,

                      onChanged: (value) {
                        setState(() {
                          tenureYears =
                              value;
                        });
                      },
                    ),

                    const SizedBox(height: 20),

                    // --------------------------------
                    // CALCULATE BUTTON
                    // --------------------------------

                    _buildCalculateButton(),

                    const SizedBox(height: 20),

                    // --------------------------------
                    // RESULT
                    // --------------------------------

                    CarLoanResultCard(
                      emi:
                          _formatCurrency(
                        emi,
                      ),

                      loanAmount:
                          _formatCurrency(
                        loanAmount,
                      ),

                      totalInterest:
                          _formatCurrency(
                        totalInterest,
                      ),

                      totalPayment:
                          _formatCurrency(
                        totalPayment,
                      ),
                    ),

                    const SizedBox(height: 16),

                    // --------------------------------
                    // CHART
                    // --------------------------------

                    CarLoanChart(
                      principal:
                          loanAmount,

                      interest:
                          totalInterest,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),

      bottomNavigationBar:
          _buildBottomNavigation(),
    );
  }

  // ------------------------------------------------
  // HEADER
  // ------------------------------------------------

  Widget _buildHeader() {

    return SizedBox(
      height: 62,

      child: Row(
        children: [

          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },

            icon: const Icon(
              Icons.arrow_back,
            ),
          ),

          const Text(
            'Car Loan Calculator',

            style: TextStyle(
              fontSize: 20,
              fontWeight:
                  FontWeight.w700,
              color:
                  Color(0xFF17345C),
            ),
          ),
        ],
      ),
    );
  }

  // ------------------------------------------------
  // INTRO
  // ------------------------------------------------

  Widget _buildIntro() {

    return Row(
      children: [

        Container(
          width: 52,
          height: 52,

          decoration: BoxDecoration(
            color:
                const Color(0xFFEAF4FF),
            borderRadius:
                BorderRadius.circular(16),
          ),

          child: const Icon(
            Icons.directions_car_rounded,

            color:
                Color(0xFF2196F3),

            size: 28,
          ),
        ),

        const SizedBox(width: 14),

        const Expanded(
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [

              Text(
                'Car Loan EMI',

                style: TextStyle(
                  fontSize: 18,
                  fontWeight:
                      FontWeight.w700,
                  color:
                      Color(0xFF17345C),
                ),
              ),

              SizedBox(height: 4),

              Text(
                'Calculate your monthly car loan payment',

                style: TextStyle(
                  fontSize: 13,
                  color:
                      Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ------------------------------------------------
  // CALCULATE BUTTON
  // ------------------------------------------------

  Widget _buildCalculateButton() {

    return SizedBox(
      width: double.infinity,
      height: 54,

      child: ElevatedButton(
        onPressed: () {

          FocusScope.of(context)
              .unfocus();

          _calculateLoan();
        },

        style:
            ElevatedButton.styleFrom(
          backgroundColor:
              const Color(0xFFFD746C),

          foregroundColor:
              Colors.white,

          elevation: 0,

          shape:
              RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(16),
          ),
        ),

        child: const Text(
          'Calculate EMI',

          style: TextStyle(
            fontSize: 16,
            fontWeight:
                FontWeight.w700,
          ),
        ),
      ),
    );
  }

  // ------------------------------------------------
  // BOTTOM NAVIGATION
  // ------------------------------------------------

  Widget _buildBottomNavigation() {

    return Container(
      height: 70,

      decoration: BoxDecoration(
        color: Colors.white,

        boxShadow: [
          BoxShadow(
            color:
                Colors.black.withOpacity(
              0.08,
            ),

            blurRadius: 12,

            offset:
                const Offset(0, -3),
          ),
        ],
      ),

      child: const Center(
        child: Text(
          'AppBottomNavigation',
          style: TextStyle(
            color: Colors.grey,
          ),
        ),
      ),
    );
  }
}