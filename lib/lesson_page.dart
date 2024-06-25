import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:speak_accounting/level_card.dart';
import 'package:speak_accounting/quiz_page.dart';

import 'level.dart';
import 'lesson.dart';
import 'lesson_section.dart';
import 'quiz_question.dart';

class LessonPage extends StatefulWidget {
  const LessonPage({super.key});
  static List<Lesson> getLessons() {
    // Flatten the _levels list to get all Lessons
    return _LessonPageState()._levels.expand((level) => level.lessons).toList();
  }

  @override
  _LessonPageState createState() => _LessonPageState();
}

class _LessonPageState extends State<LessonPage> {
  final User? user = FirebaseAuth.instance.currentUser;
  final CollectionReference progressCollection =
  FirebaseFirestore.instance.collection('progress');

  // Data for the lessons (Now with Levels)
  final List<Level> _levels = [
  Level(
  title: 'Level 0: The Accounting Spark (Absolute Beginner)',
  lessons: [
  Lesson(
  title: '0.1: Why Do We Need Numbers?',
  sections: [
  LessonSection(
  title: 'Relating Numbers to Life',
  content:
  'Make accounting relatable by showing how numbers impact everyday life (personal budgets, grocery shopping, making change).',
  progress: 0.0,
  imageUrl: null,
  videoUrl: null,
  quizQuestions: [
  // Multiple Choice Question
  QuizQuestion(
  type: QuizType.multipleChoice,
  text:
  'What is the most important reason for using numbers in accounting?',
  options: [
  'To make financial statements look impressive.',
  'To track and manage money effectively.',
  'To confuse people with complex calculations.'
  ], // Use options instead of answers
  correctAnswer:
  'To track and manage money effectively.', // Replaced 'A' with the answer
  ),
  // True/False Question
  QuizQuestion(
  type: QuizType.trueFalse,
  text: 'Personal budgeting is not related to accounting principles.',
  options: ['True', 'False'],
  correctAnswer: 'False',
  ),
  ],
  ),
  LessonSection(
  title: 'Budget Your Day Activity',
  content:
  'Interactive Element: "Budget Your Day" activity where users allocate a hypothetical budget for a day\'s expenses.',
  progress: 0.0,
  imageUrl: null,
  videoUrl: null,
  quizQuestions: [
  // Fill-in-the-Blank Question
  QuizQuestion(
  type: QuizType.fillInTheBlank,
  text: 'A ___ is a plan for how you will spend your money.',
  options: ['Budget'],
  correctAnswer: 'Budget',
  ),
  ],
  ),
  ],
  ),
  // ... (Add more lessons for Level 0)
  ],
  ),
  Level(
  title: 'Level 1: Foundations of Accounting (Beginner)',
  lessons: [
  Lesson(
  title:
  '1.1: Assets, Liabilities, and Equity: Building Blocks of Accounting',
  sections: [
  LessonSection(
  title: 'Understanding the Terms',
  content:
  'Explain each term in detail, using tangible examples (a car is an asset, a loan is a liability, the owner\'s investment is equity).',
  progress: 0.0,
  imageUrl: null,
  videoUrl: null,
  quizQuestions: [
  // Multiple Choice Question
  QuizQuestion(
  type: QuizType.multipleChoice,
  text: 'What is an asset?',
  options: [
  'Something you owe to others.',
  'Something you own that has value.',
  'The difference between your assets and liabilities.'
  ], // Use options instead of answers
  correctAnswer:
  'Something you own that has value.', // Replaced 'B' with the answer
  ),
  // True/False Question
  QuizQuestion(
  type: QuizType.trueFalse,
  text: 'A loan you have taken out is considered an asset.',
  options: ['True', 'False'],
  correctAnswer: 'False',
  ),
  // Fill-in-the-Blank Question
  QuizQuestion(
  type: QuizType.fillInTheBlank,
  text: '__ represents the owner\'s investment in the business.',
  options: ['Equity'],
  correctAnswer: 'Equity',
  ),
  ],
  ),
  LessonSection(
  title: 'Sort the Accounts Game',
  content:
  'Interactive Element: "Sort the Accounts" game where users classify various items into assets, liabilities, or equity.',
  progress: 0.0,
  imageUrl: null,
  videoUrl: null,
  quizQuestions: [
  // Multiple Choice Question
  QuizQuestion(
  type: QuizType.multipleChoice,
  text: 'Which of the following is NOT an asset?',
  options: [
  'Cash',
  'Inventory',
  'Loan Payable'
  ], // Use options instead of answers
  correctAnswer: 'Loan Payable', // Replaced 'C' with the answer
  ),
  // True/False Question
  QuizQuestion(
  type: QuizType.trueFalse,
  text: 'A salary payable is an example of a liability.',
  options: ['True', 'False'],
  correctAnswer: 'True',
  ),
  // Fill-in-the-Blank Question
  QuizQuestion(
  type: QuizType.fillInTheBlank,
  text: 'The ___ Equation is the foundation of accounting.',
  options: ['Accounting'],
  correctAnswer: 'Accounting',
  ),
  ],
  ),
  ],
  ),
  Lesson(
  title: '1.2: The Accounting Equation: The Foundation of Balance',
  sections: [
  LessonSection(
  title: 'Introduction to the Equation',
  content:
  'Explain the fundamental accounting equation (Assets = Liabilities + Equity).',
  progress: 0.0,
  imageUrl: null,
  videoUrl: null,
  quizQuestions: [
  // Multiple Choice Question
  QuizQuestion(
  type: QuizType.multipleChoice,
  text: 'What is the fundamental accounting equation?',
  options: [
  'Assets = Liabilities + Equity',
  'Revenue = Expenses + Net Income',
  'Cash Flow = Inflows - Outflows'
  ], // Use options instead of answers
  correctAnswer:
  'Assets = Liabilities + Equity', // Replaced 'A' with the answer
  ),
  // True/False Question
  QuizQuestion(
  type: QuizType.trueFalse,
  text:
  'The accounting equation ensures that the total value of assets always equals the total value of liabilities and equity.',
  options: ['True', 'False'],
  correctAnswer: 'True',
  ),
  // Fill-in-the-Blank Question
  QuizQuestion(
  type: QuizType.fillInTheBlank,
  text: 'The accounting equation is based on the principle of ___ balance.',
  options: ['Double-entry'],
  correctAnswer: 'Double-entry',
  ),
  ],
  ),
  LessonSection(
  title: 'Interactive Example',
  content:
  'Interactive Element: Use a simple scenario (buying a car with a loan) to demonstrate how the accounting equation balances.',
  progress: 0.0,
  imageUrl: null,
  videoUrl: null,
  quizQuestions: [
  // Multiple Choice Question
  QuizQuestion(
  type: QuizType.multipleChoice,
  text:
  'If a business buys a car for \$20,000 and pays \$5,000 in cash and takes out a loan for the rest, how does this affect the accounting equation?',
  options: [
  'Assets increase by \$20,000, Liabilities increase by \$15,000',
  'Assets increase by \$20,000, Equity increases by \$15,000',
  'Assets increase by \$5,000, Liabilities increase by \$15,000'
  ], // Use options instead of answers
  correctAnswer:
  'Assets increase by \$20,000, Liabilities increase by \$15,000', // Replaced 'A' with the answer
  ),
  // True/False Question
  QuizQuestion(
  type: QuizType.trueFalse,
  text:
  'Every transaction must affect at least two accounts in order to keep the accounting equation balanced.',
  options: ['True', 'False'],
  correctAnswer: 'True',
  ),
  // Fill-in-the-Blank Question
  QuizQuestion(
  type: QuizType.fillInTheBlank,
  text:
  'The accounting equation helps to ensure that the financial records of a business are ___ and ',
  options: ['Accurate', 'Consistent'],
  correctAnswer: 'Accurate, Consistent',
  ),
  ],
  ),
  ],
  ),
  Lesson(
  title: '1.3: Transactions and the Accounting Cycle: Keeping Track',
  sections: [
  LessonSection(
  title: 'Understanding Transactions',
  content:
  'Explain how business transactions affect the accounting equation.',
  progress: 0.0,
  imageUrl: null,
  videoUrl: null,
  quizQuestions: [
  // Multiple Choice Question
  QuizQuestion(
  type: QuizType.multipleChoice,
  text: 'Which of the following is NOT a business transaction?',
  options: [
  'Selling goods to a customer',
  'Paying salaries to employees',
  'Having a meeting with a potential client'
  ], // Use options instead of answers
  correctAnswer:
  'Having a meeting with a potential client', // Replaced 'C' with the answer
  ),
  // True/False Question
  QuizQuestion(
  type: QuizType.trueFalse,
  text: 'Every transaction must be recorded in the accounting system.',
  options: ['True', 'False'],
  correctAnswer: 'True',
  ),
  // Fill-in-the-Blank Question
  QuizQuestion(
  type: QuizType.fillInTheBlank,
  text:
  'A business transaction is any event that has a ___ impact on the financial position of a company.',
  options: ['Measurable'],
  correctAnswer: 'Measurable',
  ),
  ],
  ),
  LessonSection(
  title: 'The Accounting Cycle: A Step-by-Step Guide',
  content:
  'Provide an overview of the accounting cycle (identifying, recording, summarizing, and reporting transactions).',
  progress: 0.0,
  imageUrl: null,
  videoUrl: null,
  quizQuestions: [
  // Multiple Choice Question
  QuizQuestion(
  type: QuizType.multipleChoice,
  text: 'What is the first step in the accounting cycle?',
  options: [
  'Recording transactions in a journal',
  'Preparing financial statements',
  'Identifying and analyzing transactions'
  ], // Use options instead of answers
  correctAnswer:
  'Identifying and analyzing transactions', // Replaced 'C' with the answer
  ),
  // True/False Question
  QuizQuestion(
  type: QuizType.trueFalse,
  text:
  'The accounting cycle is a continuous process that repeats with each new business transaction.',
  options: ['True', 'False'],
  correctAnswer: 'True',
  ),
  // Fill-in-the-Blank Question
  QuizQuestion(
  type: QuizType.fillInTheBlank,
  text:
  'The accounting cycle ensures that all transactions are ___ and ___ in a timely and accurate manner.',
  options: ['Recorded', 'Summarized'],
  correctAnswer: 'Recorded, Summarized',
  ),
  ],
  ),
  ],
  ),
  Lesson(
  title: '1.4: Financial Statements: Telling the Story',
  sections: [
  LessonSection(
  title: 'Introduction to Financial Statements',
  content:
  'Explain the purpose of financial statements (balance sheet, income statement, statement of cash flows).',
  progress: 0.0,
  imageUrl: null,
  videoUrl: null,
  quizQuestions: [
  // Multiple Choice Question
  QuizQuestion(
  type: QuizType.multipleChoice,
  text: 'What is the primary purpose of financial statements?',
  options: [
  'To show how much money a business has made',
  'To provide a snapshot of a business\'s financial position',
  'To help investors and creditors make informed decisions'
  ], // Use options instead of answers
  correctAnswer:
  'To help investors and creditors make informed decisions', // Replaced 'C' with the answer
  ),
  // True/False Question
  QuizQuestion(
  type: QuizType.trueFalse,
  text:
  'Financial statements are only useful for external stakeholders, such as investors.',
  options: ['True', 'False'],
  correctAnswer: 'False',
  ),
  // Fill-in-the-Blank Question
  QuizQuestion(
  type: QuizType.fillInTheBlank,
  text:
  'The ___ ___ shows a company\'s assets, liabilities, and equity at a specific point in time.',
  options: ['Balance', 'Sheet'],
  correctAnswer: 'Balance, Sheet',
  ),
  ],
  ),
  LessonSection(
  title: 'Understanding Each Statement',
  content:
  'Provide a brief overview of each financial statement and what information it presents.',
  progress: 0.0,
  imageUrl: null,
  videoUrl: null,
  quizQuestions: [
  // Multiple Choice Question
  QuizQuestion(
  type: QuizType.multipleChoice,
  text:
  'Which financial statement shows a company\'s revenues and expenses over a period of time?',
  options: [
  'Balance Sheet',
  'Income Statement',
  'Statement of Cash Flows'
  ], // Use options instead of answers
  correctAnswer: 'Income Statement', // Replaced 'B' with the answer
  ),
  // True/False Question
  QuizQuestion(
  type: QuizType.trueFalse,
  text:
  'The statement of cash flows shows how much cash a business has earned from its operations.',
  options: ['True', 'False'],
  correctAnswer: 'False',
  ),
  // Fill-in-the-Blank Question
  QuizQuestion(
  type: QuizType.fillInTheBlank,
  text:
  'The ___ ___ reports a company\'s cash inflows and outflows from its operating, investing, and financing activities.',
  options: ['Statement', 'of Cash Flows'],
  correctAnswer: 'Statement, of Cash Flows',
  ),
  ],
  ),
  ],
  ),
  // ... (Add more lessons for Level 1)
  ],
  ),
  Level(
  title: 'Level 2: Intermediate Accounting',
  lessons: [
  Lesson(
  title: '2.1: Inventory Accounting: Managing Goods',
  sections: [
  LessonSection(
  title: 'Inventory Costing Methods',
  content:
  'Explain different inventory costing methods (FIFO, LIFO, weighted-average).',
  progress: 0.0,
  imageUrl: null,
  videoUrl: null,
  quizQuestions: [
  // Multiple Choice Question
  QuizQuestion(
  type: QuizType.multipleChoice,
  text: 'What does FIFO stand for?',
  options: [
  'First In, First Out',
  'First In, Last Out',
  'Fixed Inventory, First Out'
  ], // Use options instead of answers
  correctAnswer:
  'First In, First Out', // Replaced 'A' with the answer
  ),
  // True/False Question
  QuizQuestion(
  type: QuizType.trueFalse,
  text: 'LIFO assumes that the oldest inventory items are sold first.',
  options: ['True', 'False'],
  correctAnswer: 'False',
  ),
  // Fill-in-the-Blank Question
  QuizQuestion(
  type: QuizType.fillInTheBlank,
  text: 'The - method calculates the cost of goods sold based on the average cost of all inventory items.',
  options: ['Weighted', 'Average'],
  correctAnswer: 'Weighted, Average',
  ),
  ],
  ),
  LessonSection(
  title: 'Inventory Valuation and Write-Downs',
  content:
  'Discuss inventory valuation and the need for write-downs when inventory value declines.',
  progress: 0.0,
  imageUrl: null,
  videoUrl: null,
  quizQuestions: [
  // Multiple Choice Question
  QuizQuestion(
  type: QuizType.multipleChoice,
  text: 'What is the primary reason for an inventory write-down?',
  options: [
  'To increase the value of inventory on the balance sheet',
  'To reflect the decline in the market value of inventory',
  'To reduce the cost of goods sold'
  ], // Use options instead of answers
  correctAnswer:
  'To reflect the decline in the market value of inventory', // Replaced 'B' with the answer
  ),
  // True/False Question
  QuizQuestion(
  type: QuizType.trueFalse,
  text: 'Inventory write-downs can result in a loss on the income statement.',
  options: ['True', 'False'],
  correctAnswer: 'True',
  ),
  // Fill-in-the-Blank Question
  QuizQuestion(
  type: QuizType.fillInTheBlank,
  text:
  'Inventory is typically valued at the ___ ___ ___ or ___ ___ ___ , whichever is lower.',
  options: [
  'Lower',
  'of Cost',
  'Market',
  'Net',
  'Realizable',
  'Value'
  ],
  correctAnswer:
  'Lower, of Cost, Market, Net, Realizable, Value',
  ),
  ],
  ),
  ],
  ),
  Lesson(
  title: '2.2: Long-Term Assets: The Foundation of Operations',
  sections: [
  LessonSection(
  title: 'Fixed Assets and Depreciation',
  content:
  'Explain fixed assets (property, plant, and equipment) and how to account for depreciation.',
  progress: 0.0,
  imageUrl: null,
  videoUrl: null,
  quizQuestions: [
  // Multiple Choice Question
  QuizQuestion(
  type: QuizType.multipleChoice,
  text: 'Which of the following is NOT a fixed asset?',
  options: [
  'Buildings',
  'Land',
  'Inventory'
  ], // Use options instead of answers
  correctAnswer: 'Inventory', // Replaced 'C' with the answer
  ),
  // True/False Question
  QuizQuestion(
  type: QuizType.trueFalse,
  text:
  'Depreciation is the process of allocating the cost of a fixed asset over its useful life.',
  options: ['True', 'False'],
  correctAnswer: 'True',
  ),
  // Fill-in-the-Blank Question
  QuizQuestion(
  type: QuizType.fillInTheBlank,
  text:
  'Depreciation expense is recorded on the ___ ___ to reflect the decline in the value of fixed assets.',
  options: ['Income', 'Statement'],
  correctAnswer: 'Income, Statement',
  ),
  ],
  ),
  LessonSection(
  title: 'Intangible Assets and Amortization',
  content:
  'Discuss intangible assets (patents, trademarks) and how to account for amortization.',
  progress: 0.0,
  imageUrl: null,
  videoUrl: null,
  quizQuestions: [
  // Multiple Choice Question
  QuizQuestion(
  type: QuizType.multipleChoice,
  text: 'Which of the following is an intangible asset?',
  options: [
  'Computer Equipment',
  'Patents',
  'Raw Materials'
  ], // Use options instead of answers
  correctAnswer: 'Patents', // Replaced 'B' with the answer
  ),
  // True/False Question
  QuizQuestion(
  type: QuizType.trueFalse,
  text:
  'Amortization is the process of spreading the cost of an intangible asset over its useful life.',
  options: ['True', 'False'],
  correctAnswer: 'True',
  ),
  // Fill-in-the-Blank Question
  QuizQuestion(
  type: QuizType.fillInTheBlank,
  text:
  'Intangible assets are ___ that have value but do not have physical substance.',
  options: ['Assets'],
  correctAnswer: 'Assets',
  ),
  ],
  ),
  ],
  ),
  Lesson(
  title: '2.3: Liabilities and Equity: Financing the Business',
  sections: [
  LessonSection(
  title: 'Types of Liabilities',
  content: 'Explain various types of liabilities (current and long-term).',
  progress: 0.0,
  imageUrl: null,
  videoUrl: null,
  quizQuestions: [
  // Multiple Choice Question
  QuizQuestion(
  type: QuizType.multipleChoice,
  text: 'What is a current liability?',
  options: [
  'A debt that is due within one year',
  'A debt that is due in more than one year',
  'An investment in a business'
  ], // Use options instead of answers
  correctAnswer:
  'A debt that is due within one year', // Replaced 'A' with the answer
  ),
  // True/False Question
  QuizQuestion(
  type: QuizType.trueFalse,
  text: 'A mortgage payable is an example of a current liability.',
  options: ['True', 'False'],
  correctAnswer: 'False',
  ),
  // Fill-in-the-Blank Question
  QuizQuestion(
  type: QuizType.fillInTheBlank,
  text: 'Liabilities represent ___ that a business owes to others.',
  options: ['Obligations'],
  correctAnswer: 'Obligations',
  ),
  ],
  ),
  LessonSection(
  title: 'Equity Structure',
  content:
  'Discuss the different components of equity (common stock, retained earnings).',
  progress: 0.0,
  imageUrl: null,
  videoUrl: null,
  quizQuestions: [
  // Multiple Choice Question
  QuizQuestion(
  type: QuizType.multipleChoice,
  text: 'What is common stock?',
  options: [
  'Shares of ownership in a company',
  'Money that a company has saved',
  'Profits that have been reinvested in the business'
  ], // Use options instead of answers
  correctAnswer:
  'Shares of ownership in a company', // Replaced 'A' with the answer
  ),
  // True/False Question
  QuizQuestion(
  type: QuizType.trueFalse,
  text:
  'Retained earnings represent the amount of profits that a company has paid out to its shareholders as dividends.',
  options: ['True', 'False'],
  correctAnswer: 'False',
  ),
  // Fill-in-the-Blank Question
  QuizQuestion(
  type: QuizType.fillInTheBlank,
  text: 'Equity represents the ___ of the owners in a business.',
  options: ['Ownership'],
  correctAnswer: 'Ownership',
  ),
  ],
  ),
  ],
  ),
  Lesson(
  title: '2.4: Financial Statement Analysis: Interpreting the Numbers',
  sections: [
  LessonSection(
  title: 'Common Financial Ratios',
  content:
  'Explain various financial ratios and their significance in analyzing financial statements.',
  progress: 0.0,
  imageUrl: null,
  videoUrl: null,
  quizQuestions: [
  // Multiple Choice Question
  QuizQuestion(
  type: QuizType.multipleChoice,
  text: 'What does a current ratio measure?',
  options: [
  'A company\'s ability to pay its short-term debts',
  'A company\'s profitability',
  'A company\'s ability to generate cash from operations'
  ], // Use options instead of answers
  correctAnswer:
  'A company\'s ability to pay its short-term debts', // Replaced 'A' with the answer
  ),
  // True/False Question
  QuizQuestion(
  type: QuizType.trueFalse,
  text:
  'A high debt-to-equity ratio indicates that a company has a lot of debt relative to its equity.',
  options: ['True', 'False'],
  correctAnswer: 'True',
  ),
  // Fill-in-the-Blank Question
  QuizQuestion(
  type: QuizType.fillInTheBlank,
  text:
  'Financial ratios can be used to ___ the performance of a company over time and compare it to other companies in the same industry.',
  options: ['Analyze'],
  correctAnswer: 'Analyze',
  ),
  ],
  ),
  LessonSection(
  title: 'Horizontal and Vertical Analysis',
  content:
  'Discuss techniques for comparing financial data over time (horizontal analysis) and within a single period (vertical analysis).',
  progress: 0.0,
  imageUrl: null,
  videoUrl: null,
  quizQuestions: [
  // Multiple Choice Question
  QuizQuestion(
  type: QuizType.multipleChoice,
  text:
  'What type of analysis involves comparing financial data from different periods?',
  options: [
  'Horizontal Analysis',
  'Vertical Analysis',
  'Trend Analysis'
  ], // Use options instead of answers
  correctAnswer: 'Horizontal Analysis', // Replaced 'A' with the answer
  ),
  // True/False Question
  QuizQuestion(
  type: QuizType.trueFalse,
  text:
  'Vertical analysis expresses each line item on a financial statement as a percentage of a base item.',
  options: ['True', 'False'],
  correctAnswer: 'True',
  ),
  // Fill-in-the-Blank Question
  QuizQuestion(
  type: QuizType.fillInTheBlank,
  text: ' analysis can help to identify trends and changes in a company\'s financial performance over time.',
  options: ['Horizontal'],
  correctAnswer: 'Horizontal',
  ),
  ],
  ),
  ],
  ),
  // ... (Add more lessons for Level 2)
  ],
  ),
  Level(
  title: 'Level 3: Advanced Accounting',
  lessons: [
  Lesson(
  title:
  '3.1: Financial Reporting Standards: The Rules of the Game',
  sections: [
  LessonSection(
  title: 'GAAP (Generally Accepted Accounting Principles)',
  content:
  'Explain GAAP and its importance in ensuring consistent and transparent financial reporting.',
  progress: 0.0,
  imageUrl: null,
  videoUrl: null,
  quizQuestions: [
  // Multiple Choice Question
  QuizQuestion(
  type: QuizType.multipleChoice,
  text: 'What is the primary purpose of GAAP?',
  options: [
  'To make accounting easier for businesses',
  'To ensure that financial statements are comparable across companies',
  'To reduce the amount of accounting information required'
  ], // Use options instead of answers
  correctAnswer:
  'To ensure that financial statements are comparable across companies', // Replaced 'B' with the answer
  ),
  // True/False Question
  QuizQuestion(
  type: QuizType.trueFalse,
  text:
  'GAAP is a set of accounting rules that are used only in the United States.',
  options: ['True', 'False'],
  correctAnswer: 'False',
  ),
  // Fill-in-the-Blank Question
  QuizQuestion(
  type: QuizType.fillInTheBlank,
  text: 'GAAP stands for ___ ___ ___ ___',
  options: [
  'Generally',
  'Accepted',
  'Accounting',
  'Principles'
  ],
  correctAnswer:
  'Generally, Accepted, Accounting, Principles',
  ),
  ],
  ),
  LessonSection(
  title: 'IFRS (International Financial Reporting Standards)',
  content:
  'Discuss IFRS and its growing influence on global financial reporting.',
  progress: 0.0,
  imageUrl: null,
  videoUrl: null,
  quizQuestions: [
  // Multiple Choice Question
  QuizQuestion(
  type: QuizType.multipleChoice,
  text: 'What is the main difference between GAAP and IFRS?',
  options: [
  'IFRS is used only in Europe, while GAAP is used only in the United States',
  'IFRS is a more detailed set of accounting standards than GAAP',
  'IFRS is designed to be a global set of accounting standards, while GAAP is primarily US-centric'
  ], // Use options instead of answers
  correctAnswer:
  'IFRS is designed to be a global set of accounting standards, while GAAP is primarily US-centric', // Replaced 'C' with the answer
  ),
  // True/False Question
  QuizQuestion(
  type: QuizType.trueFalse,
  text: 'IFRS is becoming increasingly important as more countries adopt it.',
  options: ['True', 'False'],
  correctAnswer: 'True',
  ),
  // Fill-in-the-Blank Question
  QuizQuestion(
  type: QuizType.fillInTheBlank,
  text: 'IFRS stands for ___ ___ ___ ',
  options: [
  'International',
  'Financial',
  'Reporting',
  'Standards'
  ],
  correctAnswer:
  'International, Financial, Reporting, Standards',
  ),
  ],
  ),
  ],
  ),
  Lesson(
  title: '3.2: Consolidations and Mergers: Combining Businesses',
  sections: [
  LessonSection(
  title: 'Accounting for Business Combinations',
  content:
  'Explain the accounting principles involved in combining businesses through mergers or acquisitions.',
  progress: 0.0,
  imageUrl: null,
  videoUrl: null,
  quizQuestions: [
  // Multiple Choice Question
  QuizQuestion(
  type: QuizType.multipleChoice,
  text: 'What is the primary goal of consolidation accounting?',
  options: [
  'To combine the financial statements of two or more companies',
  'To simplify the accounting process for merged businesses',
  'To reduce the amount of information reported in financial statements'
  ], // Use options instead of answers
  correctAnswer:
  'To combine the financial statements of two or more companies', // Replaced 'A' with the answer
  ),
  // True/False Question
  QuizQuestion(
  type: QuizType.trueFalse,
  text:
  'Consolidation accounting is typically used when one company acquires a controlling interest in another company.',
  options: ['True', 'False'],
  correctAnswer: 'True',
  ),
  // Fill-in-the-Blank Question
  QuizQuestion(
  type: QuizType.fillInTheBlank,
  text: 'A ___ occurs when two or more companies combine to form a single entity.',
  options: ['Merger'],
  correctAnswer: 'Merger',
  ),
  ],
  ),
  LessonSection(
  title: 'Consolidation Techniques',
  content:
  'Discuss the specific techniques used to consolidate financial statements of multiple entities.',
  progress: 0.0,
  imageUrl: null,
  videoUrl: null,
  quizQuestions: [
  // Multiple Choice Question
  QuizQuestion(
  type: QuizType.multipleChoice,
  text: 'What is the primary method used to consolidate financial statements?',
  options: [
  'The equity method',
  'The consolidation method',
  'The proportional method'
  ], // Use options instead of answers
  correctAnswer: 'The consolidation method', // Replaced 'B' with the answer
  ),
  // True/False Question
  QuizQuestion(
  type: QuizType.trueFalse,
  text:
  'Consolidation adjustments are made to eliminate intercompany transactions and balances.',
  options: ['True', 'False'],
  correctAnswer: 'True',
  ),
  // Fill-in-the-Blank Question
  QuizQuestion(
  type: QuizType.fillInTheBlank,
  text:
  'Consolidation accounting involves the ___ of the financial statements of the parent and subsidiary companies.',
  options: ['Combination'],
  correctAnswer: 'Combination',
  ),
  ],
  ),
  ],
  ),
  Lesson(
  title: '3.3: Advanced Valuation Methods: Determining Worth',
  sections: [
  LessonSection(
  title: 'Discounted Cash Flow Analysis',
  content:
  'Explain the discounted cash flow (DCF) method and its application in valuing businesses and investments.',
  progress: 0.0,
  imageUrl: null,
  videoUrl: null,
  quizQuestions: [
  // Multiple Choice Question
  QuizQuestion(
  type: QuizType.multipleChoice,
  text: 'What is the main principle behind discounted cash flow analysis?',
  options: [
  'The time value of money',
  'The accounting equation',
  'The accrual basis of accounting'
  ], // Use options instead of answers
  correctAnswer:
  'The time value of money', // Replaced 'A' with the answer
  ),
  // True/False Question
  QuizQuestion(
  type: QuizType.trueFalse,
  text:
  'DCF analysis involves forecasting future cash flows and discounting them back to their present value.',
  options: ['True', 'False'],
  correctAnswer: 'True',
  ),
  // Fill-in-the-Blank Question
  QuizQuestion(
  type: QuizType.fillInTheBlank,
  text:
  'DCF analysis is often used to determine the ___ value of a business or investment.',
  options: ['Intrinsic'],
  correctAnswer: 'Intrinsic',
  ),
  ],
  ),
  LessonSection(
  title:
  'Precedent Transactions and Comparable Company Analysis',
  content:
  'Discuss other valuation methods, such as precedent transactions and comparable company analysis.',
  progress: 0.0,
  imageUrl: null,
  videoUrl: null,
  quizQuestions: [
  // Multiple Choice Question
  QuizQuestion(
  type: QuizType.multipleChoice,
  text: 'What is precedent transaction analysis?',
  options: [
  'Analyzing the financial statements of similar companies',
  'Examining the prices paid in recent acquisitions',
  'Using discounted cash flow analysis to determine value'
  ], // Use options instead of answers
  correctAnswer:
  'Examining the prices paid in recent acquisitions', // Replaced 'B' with the answer
  ),
  // True/False Question
  QuizQuestion(
  type: QuizType.trueFalse,
  text:
  'Comparable company analysis is a subjective valuation method that relies on comparing a company to its peers.',
    options: ['True', 'False'],
    correctAnswer: 'True',
  ),
    // Fill-in-the-Blank Question
    QuizQuestion(
      type: QuizType.fillInTheBlank,
      text:
      ' ___ analysis compares a company to similar companies that have recently been acquired or taken public.',
      options: ['Precedent', 'Transaction'],
      correctAnswer: 'Precedent, Transaction',
    ),
  ],
  ),
  ],
  ),
    Lesson(
      title: '3.4: Auditing and Assurance: Ensuring Accuracy',
      sections: [
        LessonSection(
          title: 'Auditing Principles and Standards',
          content:
          'Explain the principles and standards that govern auditing practices.',
          progress: 0.0,
          imageUrl: null,
          videoUrl: null,
          quizQuestions: [
            // Multiple Choice Question
            QuizQuestion(
              type: QuizType.multipleChoice,
              text: 'What is the primary purpose of an audit?',
              options: [
                'To ensure that a company\'s financial statements are accurate and reliable',
                'To help a company improve its financial performance',
                'To reduce the risk of fraud'
              ], // Use options instead of answers
              correctAnswer:
              'To ensure that a company\'s financial statements are accurate and reliable', // Replaced 'A' with the answer
            ),
            // True/False Question
            QuizQuestion(
              type: QuizType.trueFalse,
              text: 'Auditors are required to be independent of the companies they audit.',
              options: ['True', 'False'],
              correctAnswer: 'True',
            ),
            // Fill-in-the-Blank Question
            QuizQuestion(
              type: QuizType.fillInTheBlank,
              text:
              'Auditing standards are established by the ___ ___ ___ ___ ___',
              options: [
                'Public',
                'Company',
                'Accounting',
                'Oversight',
                'Board'
              ],
              correctAnswer:
              'Public, Company, Accounting, Oversight, Board',
            ),
          ],
        ),
        LessonSection(
          title: 'Types of Audits',
          content:
          'Discuss different types of audits (financial statement, operational, compliance).',
          progress: 0.0,
          imageUrl: null,
          videoUrl: null,
          quizQuestions: [
            // Multiple Choice Question
            QuizQuestion(
              type: QuizType.multipleChoice,
              text:
              'What type of audit focuses on a company\'s financial statements?',
              options: [
                'Financial Statement Audit',
                'Operational Audit',
                'Compliance Audit'
              ], // Use options instead of answers
              correctAnswer: 'Financial Statement Audit', // Replaced 'A' with the answer
            ),
            // True/False Question
            QuizQuestion(
              type: QuizType.trueFalse,
              text:
              'Operational audits are designed to assess the efficiency and effectiveness of a company\'s operations.',
              options: ['True', 'False'],
              correctAnswer: 'True',
            ),
            // Fill-in-the-Blank Question
            QuizQuestion(
              type: QuizType.fillInTheBlank,
              text:
              'A ___ audit is conducted to determine whether a company is complying with applicable laws and regulations.',
              options: ['Compliance'],
              correctAnswer: 'Compliance',
            ),
          ],
        ),
      ],
    ),
    // ... (Add more lessons for Level 3)
  ],
  ),
    Level(
      title: 'Level 4: Professional Accounting',
      lessons: [
        Lesson(
          title: '4.1: Management Accounting: Guiding Decisions',
          sections: [
            LessonSection(
              title: 'Cost Accounting',
              content:
              'Explain cost accounting principles and techniques used to track and analyze costs.',
              progress: 0.0,
              imageUrl: null,
              videoUrl: null,
              quizQuestions: [
                // Multiple Choice Question
                QuizQuestion(
                  type: QuizType.multipleChoice,
                  text: 'What is the main goal of cost accounting?',
                  options: [
                    'To prepare financial statements for external users',
                    'To provide information to managers for decision-making',
                    'To ensure that a company is complying with tax laws'
                  ], // Use options instead of answers
                  correctAnswer:
                  'To provide information to managers for decision-making', // Replaced 'B' with the answer
                ),
                // True/False Question
                QuizQuestion(
                  type: QuizType.trueFalse,
                  text: 'Cost accounting is only used by manufacturing companies.',
                  options: ['True', 'False'],
                  correctAnswer: 'False',
                ),
                // Fill-in-the-Blank Question
                QuizQuestion(
                  type: QuizType.fillInTheBlank,
                  text:
                  'Cost accounting focuses on the ___ and ___ of costs.',
                  options: ['Identification', 'Allocation'],
                  correctAnswer: 'Identification, Allocation',
                ),
              ],
            ),
            LessonSection(
              title: 'Budgeting',
              content:
              'Discuss budgeting processes and how to create and manage budgets effectively.',
              progress: 0.0,
              imageUrl: null,
              videoUrl: null,
              quizQuestions: [
                // Multiple Choice Question
                QuizQuestion(
                  type: QuizType.multipleChoice,
                  text: 'What is a budget?',
                  options: [
                    'A plan for how a company will spend its money',
                    'A record of a company\'s past financial performance',
                    'A forecast of a company\'s future financial performance'
                  ], // Use options instead of answers
                  correctAnswer:
                  'A plan for how a company will spend its money', // Replaced 'A' with the answer
                ),
                // True/False Question
                QuizQuestion(
                  type: QuizType.trueFalse,
                  text: 'Budgets are only used by large corporations.',
                  options: ['True', 'False'],
                  correctAnswer: 'False',
                ),
                // Fill-in-the-Blank Question
                QuizQuestion(
                  type: QuizType.fillInTheBlank,
                  text: 'Budgets are used to ___ and ___ resources.',
                  options: ['Plan', 'Control'],
                  correctAnswer: 'Plan, Control',
                ),
              ],
            ),
          ],
        ),
        Lesson(
          title: '4.2: Forensic Accounting: Investigating Financial Crimes',
          sections: [
            LessonSection(
              title: 'Fraud Detection and Investigation',
              content:
              'Explain the role of forensic accounting in detecting and investigating financial fraud.',
              progress: 0.0,
              imageUrl: null,
              videoUrl: null,
              quizQuestions: [
                // Multiple Choice Question
                QuizQuestion(
                  type: QuizType.multipleChoice,
                  text: 'What is forensic accounting?',
                  options: [
                    'A specialized area of accounting that focuses on financial crimes',
                    'The process of preparing financial statements for external users',
                    'The use of accounting information for management decision-making'
                  ], // Use options instead of answers
                  correctAnswer:
                  'A specialized area of accounting that focuses on financial crimes', // Replaced 'A' with the answer
                ),
                // True/False Question
                QuizQuestion(
                  type: QuizType.trueFalse,
                  text:
                  'Forensic accountants may be involved in investigations of fraud, embezzlement, and money laundering.',
                  options: ['True', 'False'],
                  correctAnswer: 'True',
                ),
                // Fill-in-the-Blank Question
                QuizQuestion(
                  type: QuizType.fillInTheBlank,
                  text:
                  'Forensic accountants use their expertise in accounting and ___ to identify and investigate financial crimes.',
                  options: ['Investigation'],
                  correctAnswer: 'Investigation',
                ),
              ],
            ),
            LessonSection(
              title: 'Financial Statement Fraud',
              content:
              'Discuss common types of financial statement fraud and how to identify them.',
              progress: 0.0,
              imageUrl: null,
              videoUrl: null,
              quizQuestions: [
                // Multiple Choice Question
                QuizQuestion(
                  type: QuizType.multipleChoice,
                  text: 'Which of the following is a common type of financial statement fraud?',
                  options: [
                    'Overstating revenue',
                    'Understating expenses',
                    'Both A and B'
                  ], // Use options instead of answers
                  correctAnswer: 'Both A and B', // Replaced 'C' with the answer
                ),
                // True/False Question
                QuizQuestion(
                  type: QuizType.trueFalse,
                  text: 'Financial statement fraud is always easy to detect.',
                  options: ['True', 'False'],
                  correctAnswer: 'False',
                ),
                // Fill-in-the-Blank Question
                QuizQuestion(
                  type: QuizType.fillInTheBlank,
                  text:
                  'Financial statement fraud can have a significant impact on a company\'s ___ and ___',
                  options: ['Reputation', 'Value'],
                  correctAnswer: 'Reputation, Value',
                ),
              ],
            ),
          ],
        ),
        Lesson(
          title: '4.3: Taxation: Understanding and Minimizing Taxes',
          sections: [
            LessonSection(
              title: 'Corporate Tax Planning',
              content:
              'Explain the principles of corporate taxation and how to plan for tax efficiency.',
              progress: 0.0,
              imageUrl: null,
              videoUrl: null,
              quizQuestions: [
                // Multiple Choice Question
                QuizQuestion(
                  type: QuizType.multipleChoice,
                  text: 'What is the primary goal of corporate tax planning?',
                  options: [
                    'To minimize a company\'s tax liability',
                    'To maximize a company\'s profits',
                    'To ensure that a company is complying with tax laws'
                  ], // Use options instead of answers
                  correctAnswer:
                  'To minimize a company\'s tax liability', // Replaced 'A' with the answer
                ),
                // True/False Question
                QuizQuestion(
                  type: QuizType.trueFalse,
                  text: 'Tax planning can be done by both large and small businesses.',
                  options: ['True', 'False'],
                  correctAnswer: 'True',
                ),
                // Fill-in-the-Blank Question
                QuizQuestion(
                  type: QuizType.fillInTheBlank,
                  text:
                  'Tax planning involves ___ the tax implications of business decisions.',
                  options: ['Analyzing'],
                  correctAnswer: 'Analyzing',
                ),
              ],
            ),
            LessonSection(
              title: 'Individual Income Tax',
              content:
              'Discuss individual income tax concepts and how to manage personal taxes effectively.',
              progress: 0.0,
              imageUrl: null,
              videoUrl: null,
              quizQuestions: [
                // Multiple Choice Question
                QuizQuestion(
                  type: QuizType.multipleChoice,
                  text: 'What is a tax deduction?',
                  options: [
                    'A direct reduction in the amount of tax you owe',
                    'An expense that you can deduct from your income to reduce your taxable income',
                    'A payment that you make to the government for your taxes'
                  ], // Use options instead of answers
                  correctAnswer:
                  'An expense that you can deduct from your income to reduce your taxable income', // Replaced 'B' with the answer
                ),
                // True/False Question
                QuizQuestion(
                  type: QuizType.trueFalse,
                  text:
                  'Tax credits are more valuable than tax deductions because they reduce your tax liability dollar for dollar.',
                  options: ['True', 'False'],
                  correctAnswer: 'True',
                ),
                // Fill-in-the-Blank Question
                QuizQuestion(
                  type: QuizType.fillInTheBlank,
                  text:
                  'Effective tax planning can help individuals to ___ their tax liability.',
                  options: ['Minimize'],
                  correctAnswer: 'Minimize',
                ),
              ],
            ),
          ],
        ),
        // ... (Add more lessons for Level 4)
      ],
    ),
  ];

  // Function to update progress
  void _updateProgress(String lessonId, String sectionId, double progress) {
    progressCollection
        .doc(user?.uid)
        .set({
      lessonId: {
        sectionId: progress
      }
    }, SetOptions(merge: true));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Accounting Lessons',style: TextStyle(color: Colors.white),),
        backgroundColor: const Color(0xFF7F3B8B),
        centerTitle: true,
        elevation: 0,
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('progress')
            .doc(user?.uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final data = snapshot.data!.data();
            return SingleChildScrollView(
              child: Column(
                children: [
                  // Duolingo-style Learn Path (Now with Levels)
                  for (var level in _levels)
                    LevelCard(
                      level: level,
                      updateProgress: _updateProgress,
                      progress: data,
                    ),
                  // Add a Quiz button at the end of the learn path
                  ElevatedButton(
                    onPressed: () {
                      // Flatten the _levels list to get all lessons
                      final allLessons = _levels
                          .expand((level) => level.lessons)
                          .toList();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => QuizPage(
                            lessons: allLessons, // Pass the lessons list
                          ),
                        ),
                      );
                    },
                    child: const Text('Take Quiz'),
                  ),
                ],
              ),
            );
          } else if (snapshot.hasError) {
            return Text("Error: ${snapshot.error}");
          } else {
            // Show the levels and lessons even if there's no data
            return SingleChildScrollView(
              child: Column(
                children: [
                  // Duolingo-style Learn Path (Now with Levels)
                  for (var level in _levels)
                    LevelCard(
                      level: level,
                      updateProgress: _updateProgress,
                      progress: null, // Pass null for progress here
                    ),
                  // Add a Quiz button at the end of the learn path
                  ElevatedButton(
                    onPressed: () {
                      // Flatten the _levels list to get all lessons
                      final allLessons = _levels
                          .expand((level) => level.lessons)
                          .toList();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => QuizPage(
                            lessons: allLessons, // Pass the lessons list
                          ),
                        ),
                      );
                    },
                    child: const Text('Take Quiz'),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
