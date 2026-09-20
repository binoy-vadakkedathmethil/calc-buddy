import 'package:flutter/material.dart';

import '../widgets/home_loan_calculator.dart';
import '../widgets/home_loan_chart.dart';
import '../widgets/home_loan_input_card.dart';
import '../widgets/home_loan_result_card.dart';

class HomeLoanScreen extends StatefulWidget {
  const HomeLoanScreen({
    super.key,
  });

  @override
  State<HomeLoanScreen> createState() =>
      _HomeLoanScreenState();
}

class _HomeLoanScreenState
    extends State<HomeLoanScreen> {

  // ------------------------------------------------
  // INPUT VALUES
  // ------------------------------------------------

  double loanAmount = 5000000;

  double interestRate = 8.5;

  double tenureYears = 20;

  // ------------------------------------------------
  // RESULT VALUES
  // ------------------------------------------------

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

    final calculatedEmi =
        HomeLoanCalculator.calculateEmi(
      principal: loanAmount,
      annualInterestRate: interestRate,
      tenureYears: tenureYears.round(),
    );

    final calculatedTotalPayment =
        HomeLoanCalculator.calculateTotalPayment(
      emi: calculatedEmi,
      tenureYears: tenureYears.round(),
    );

    final calculatedInterest =
        HomeLoanCalculator.calculateTotalInterest(
      totalPayment:
          calculatedTotalPayment,
      principal: loanAmount,
    );

    setState(() {

      emi = calculatedEmi;

      totalPayment =
          calculatedTotalPayment;

      totalInterest =
          calculatedInterest;
    });
  }

  // ------------------------------------------------
  // CURRENCY
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

                    // Loan Amount
                    HomeLoanInputCard(
                      title: 'Loan Amount',

                      value:
                          _formatCurrency(
                        loanAmount,
                      ),

                      minLabel: '₹1 Lakh',

                      maxLabel: '₹2 Crore',

                      icon:
                          Icons.currency_rupee,

                      iconColor:
                          const Color(
                        0xFF19A86B,
                      ),

                      sliderValue:
                          loanAmount,

                      min: 100000,

                      max: 20000000,

                      divisions: 199,

                      onChanged: (value) {

                        setState(() {
                          loanAmount = value;
                        });

                      },
                    ),

                    const SizedBox(height: 14),

                    // Interest Rate
                    HomeLoanInputCard(
                      title: 'Interest Rate',

                      value:
                          '${interestRate.toStringAsFixed(1)}%',

                      minLabel: '5%',

                      maxLabel: '20%',

                      icon:
                          Icons.percent,

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
                          interestRate = value;
                        });

                      },
                    ),

                    const SizedBox(height: 14),

                    // Tenure
                    HomeLoanInputCard(
                      title: 'Loan Tenure',

                      value:
                          '${tenureYears.round()} Years',

                      minLabel: '1 Year',

                      maxLabel: '30 Years',

                      icon:
                          Icons.calendar_month,

                      iconColor:
                          const Color(
                        0xFF2196F3,
                      ),

                      sliderValue:
                          tenureYears,

                      min: 1,

                      max: 30,

                      divisions: 29,

                      onChanged: (value) {

                        setState(() {
                          tenureYears = value;
                        });

                      },
                    ),

                    const SizedBox(height: 20),

                    // Calculate button
                    _buildCalculateButton(),

                    const SizedBox(height: 20),

                    // Result
                    HomeLoanResultCard(
                      emi:
                          _formatCurrency(emi),

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

                    // Chart
                    HomeLoanChart(
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

      // Use your existing AppBottomNavigation here
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
            'Home Loan Calculator',

            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: Color(0xFF17345C),
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
                const Color(0xFFE9F8F1),

            borderRadius:
                BorderRadius.circular(16),
          ),

          child: const Icon(
            Icons.home_rounded,

            color:
                Color(0xFF19A86B),

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
                'Home Loan EMI',

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
                'Calculate your monthly home loan payment',

                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey,
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
        ),
      ),
    );
  }
}