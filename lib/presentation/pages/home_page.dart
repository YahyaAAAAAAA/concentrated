import 'package:flutter/material.dart';
import 'package:tweleve_ace/core/extensions/build_context_extenstions.dart';
import 'package:tweleve_ace/core/extensions/int_extenstions.dart';
import 'package:tweleve_ace/core/extensions/text_extensions.dart';
import 'package:tweleve_ace/core/utils/constants.dart';
import 'package:tweleve_ace/core/utils/global_colors.dart';
import 'package:tweleve_ace/core/widgets/app_app_bar.dart';
import 'package:tweleve_ace/core/widgets/row_button.dart';
import 'package:tweleve_ace/core/widgets/trinary_button.dart';
import 'package:tweleve_ace/presentation/pages/question_list_page.dart';
import 'package:tweleve_ace/presentation/widgets/admin_card.dart';
import 'package:tweleve_ace/presentation/widgets/home_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppAppBar(
        isOwner: true,
        onOwnerButtonTap: () => context.push(QuestionListPage()),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: kListViewWidth),
          child: ListView(
            padding: EdgeInsets.all(12),
            children: [
              Text('Start Studying...').primary(),
              5.height,
              HomeCard(
                onPressed: () {},
                url: 'https://i.ibb.co/HDRFVt4j/undraw-exams-d2tf-1.png',
                backgroundColor: GColors.fern,
                buttonColor: GColors.white,
                isFlipped: false,
              ),
              20.height,
              HomeCard(
                onPressed: () => context.showSnackBar('Coming Soon'),
                url: 'https://i.ibb.co/qLRXzjPH/undraw-learning-qt7d.png',
                backgroundColor: GColors.fern.withValues(alpha: 0.3),
                buttonColor: GColors.fern,
                isFlipped: true,
              ),
              20.height,
              Text('Pick a School Grade').secondary(),
              5.height,
              SizedBox(
                  height: 80,
                  width: 80,
                  child: ListView.separated(
                    reverse: true,
                    itemCount: 12,
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.all(4),
                    separatorBuilder: (context, index) => SizedBox(width: 10),
                    itemBuilder: (context, index) {
                      final reversedIndex = 11 - index;
                      return TrinaryButton(
                        onPressed: () {},
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                        child: Column(
                          children: [
                            Text('${reversedIndex + 1}${reversedIndex == 0 ? 'st' : reversedIndex == 1 ? 'nd' : 'th'}')
                                .secondary(),
                            Text('Grade').trinary(),
                          ],
                        ),
                      );
                    },
                  )),
              20.height,
              Text('Tawjihi Streams').secondary(),
              5.height,
              RowButton(
                onPressed: () {},
                text: 'Literary Subjects',
                icon: Icons.history_edu_rounded,
              ),
              20.height,
              RowButton(
                onPressed: () {},
                text: 'Scientific Subjects',
                icon: Icons.science_outlined,
              ),
              20.height,
              Text('See Community Work').secondary(),
              5.height,
              Wrap(
                spacing: 10,
                children: [
                  AdminCard(
                    count: '10',
                    text: 'Public Exams',
                    icon: Icons.public_rounded,
                    onPressed: () {},
                  ),
                  AdminCard(
                    count: '10',
                    text: 'Create Exams',
                    icon: Icons.create_rounded,
                    onPressed: () {},
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      //todo
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Divider(),
          NavigationBar(
              backgroundColor: GColors.white,
              selectedIndex: 0,
              animationDuration: const Duration(milliseconds: 300),
              indicatorColor: GColors.fern.withValues(alpha: 0),
              indicatorShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(kOuterRadius)),
              labelTextStyle: WidgetStatePropertyAll(TextStyle(
                color: GColors.black,
                fontFamily: 'Abel',
              )),
              destinations: [
                NavigationDestination(
                  selectedIcon: Icon(
                    Icons.home_rounded,
                    color: GColors.fern,
                    size: kNormalIconSize + 5,
                  ),
                  icon: const Icon(
                    Icons.home_rounded,
                    size: kNormalIconSize + 5,
                  ),
                  label: 'Home',
                ),
                NavigationDestination(
                  selectedIcon: Icon(
                    Icons.chat_bubble_rounded,
                    color: GColors.fern,
                    size: kNormalIconSize,
                  ),
                  icon: const Icon(
                    Icons.chat_bubble_rounded,
                    size: kNormalIconSize,
                  ),
                  label: 'Messages',
                ),
                NavigationDestination(
                  selectedIcon: Icon(
                    Icons.person_rounded,
                    color: GColors.fern,
                    size: kNormalIconSize + 5,
                  ),
                  icon: const Icon(
                    Icons.person_rounded,
                    size: kNormalIconSize + 5,
                  ),
                  label: 'Account',
                ),
              ]),
        ],
      ),
    );
  }
}
