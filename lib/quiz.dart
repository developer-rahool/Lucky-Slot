import 'package:flutter/material.dart';
import 'package:Lucky_Slot/main.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:lottie/lottie.dart';

class QuizPage extends StatefulWidget {
  final Function(int) onCoinsChange;

  QuizPage({Key? key, required this.onCoinsChange}) : super(key: key);
  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  int userCoins = 0;
  String selectedCategory = '';
  List<String> categories = ['Mythology', 'History', 'Science', 'Literature'];
  int currentQuestionIndex = 0;
  int totalQuestions = 15;
  String? selectedAnswer;

  Map<String, List<Map<String, dynamic>>> questions = {
    'Mythology': [
      {
        'question': 'Who is the Greek god of the sun?',
        'options': ['Apollo', 'Zeus', 'Helios', 'Hades'],
        'correctAnswer': 'Helios',
      },
      {
        'question': 'Who is the Roman counterpart of the Greek god Ares?',
        'options': ['Mars', 'Jupiter', 'Neptune', 'Pluto'],
        'correctAnswer': 'Mars',
      },
      {
        'question':
            'What animal is associated with Athena, the Greek goddess of wisdom?',
        'options': ['Owl', 'Snake', 'Lion', 'Eagle'],
        'correctAnswer': 'Owl',
      },
      {
        'question': 'Who is the Norse god of thunder?',
        'options': ['Odin', 'Thor', 'Loki', 'Freyr'],
        'correctAnswer': 'Thor',
      },
      {
        'question': 'What is the Greek name for the ruler of the underworld?',
        'options': ['Hades', 'Zeus', 'Poseidon', 'Ares'],
        'correctAnswer': 'Hades',
      },
      {
        'question': 'Who is the Egyptian god of the afterlife?',
        'options': ['Anubis', 'Osiris', 'Ra', 'Horus'],
        'correctAnswer': 'Osiris',
      },
      {
        'question': 'What creature did Medusa turn people into with her gaze?',
        'options': ['Stone', 'Gold', 'Sand', 'Dust'],
        'correctAnswer': 'Stone',
      },
      {
        'question': 'Who is the goddess of love and beauty in Greek mythology?',
        'options': ['Athena', 'Hera', 'Aphrodite', 'Artemis'],
        'correctAnswer': 'Aphrodite',
      },
      {
        'question': 'Who is the messenger of the gods in Greek mythology?',
        'options': ['Hermes', 'Ares', 'Dionysus', 'Apollo'],
        'correctAnswer': 'Hermes',
      },
      {
        'question':
            'What creature did Hercules defeat as one of his twelve labors?',
        'options': ['Cerberus', 'Minotaur', 'Hydra', 'Nemean Lion'],
        'correctAnswer': 'Nemean Lion',
      },
      {
        'question':
            'In what practice do the flower myths of Hyacinth and Adonis probably have their roots?',
        'options': [
          'Human sacrifice',
          'Homosexuality',
          'Adultery',
          'Cannibalism'
        ],
        'correctAnswer': 'Human sacrifice',
      },
      //
      {
        'question':
            'Without whose help would Jason not have gotten the Golden Fleece?',
        'options': ['Hercules', 'Perseus’s', 'Medea’s', 'Teiresias’s'],
        'correctAnswer': 'Medea’s',
      },
      {
        'question': 'What is the name of Daedalus’s son?',
        'options': ['Theseus', 'Minos', 'Perseus', 'Icarus'],
        'correctAnswer': 'Icarus',
      },
      {
        'question': 'For what is Perseus most famous?',
        'options': [
          'Killing the Minotaur',
          'Killing Medusa',
          'Killing the Sphinx',
          'Killing the Hydra'
        ],
        'correctAnswer': 'Killing Medusa',
      },
      {
        'question': 'Whose heart does Aeneas break?',
        'options': ['Lavinia', 'Psyche', 'Dido', 'Medea'],
        'correctAnswer': 'Dido',
      },
    ],
    'History': [
      {
        'question': 'Who was the first president of the United States?',
        'options': [
          'Thomas Jefferson',
          'John Adams',
          'George Washington',
          'James Madison'
        ],
        'correctAnswer': 'George Washington',
      },
      {
        'question':
            'In which year did the Berlin Wall fall, marking the end of the Cold War?',
        'options': ['1985', '1989', '1991', '1995'],
        'correctAnswer': '1989',
      },
      {
        'question': 'Which ancient civilization built the Great Wall of China?',
        'options': ['Mongols', 'Chinese', 'Persians', 'Romans'],
        'correctAnswer': 'Chinese',
      },
      {
        'question': 'Who was the first emperor of Rome?',
        'options': ['Julius Caesar', 'Augustus', 'Nero', 'Caligula'],
        'correctAnswer': 'Augustus',
      },
      {
        'question':
            'Which famous scientist formulated the theory of general relativity?',
        'options': [
          'Isaac Newton',
          'Albert Einstein',
          'Galileo Galilei',
          'Stephen Hawking'
        ],
        'correctAnswer': 'Albert Einstein',
      },
      {
        'question':
            'In which city was the Declaration of Independence signed in 1776?',
        'options': [
          'Philadelphia',
          'Boston',
          'New York City',
          'Washington D.C.'
        ],
        'correctAnswer': 'Philadelphia',
      },
      {
        'question': 'Who was the longest-serving British monarch?',
        'options': [
          'Queen Victoria',
          'Queen Elizabeth II',
          'King George III',
          'King Henry VIII'
        ],
        'correctAnswer': 'Queen Elizabeth II',
      },
      {
        'question': 'Which country was the first to put a human in space?',
        'options': ['United States', 'China', 'Russia', 'Germany'],
        'correctAnswer': 'Russia',
      },
      {
        'question':
            'Which war was fought between the North and South regions of the United States?',
        'options': ['World War I', 'Civil War', 'Vietnam War', 'Korean War'],
        'correctAnswer': 'Civil War',
      },
      {
        'question':
            'Who was the Prime Minister of Great Britain during World War II?',
        'options': [
          'Winston Churchill',
          'Neville Chamberlain',
          'Margaret Thatcher',
          'Tony Blair'
        ],
        'correctAnswer': 'Winston Churchill',
      },
      //
      {
        'question': 'Which civilisation is the oldest in the world?',
        'options': [
          'Egyptian Civilization',
          'Mesopotamian Civilization',
          'Chinese Civilization',
          'Indus Valley Civilization'
        ],
        'correctAnswer': 'Mesopotamian Civilization',
      },
      {
        'question': 'Egypt is also called what?',
        'options': [
          'Gift of Nile',
          'Gift of the World',
          'Gift of Sun',
          'Gift of Sphinx'
        ],
        'correctAnswer': 'Gift of Nile',
      },
      {
        'question': 'The first Olympic Games were held in?',
        'options': ['746 BC', '749 BC', '776 BC', '779 BC'],
        'correctAnswer': '776 BC',
      },
      {
        'question': 'Who is known as the father of History?',
        'options': ['Sophocles', 'Herodotus', 'Homer', 'Aristophanes'],
        'correctAnswer': 'Herodotus',
      },
      {
        'question': 'When did the Reformation movement start?',
        'options': ['1516', '1518', '1519', '1517'],
        'correctAnswer': '1517',
      },
    ],
    'Science': [
      {
        'question': 'What is the chemical symbol for water?',
        'options': ['W', 'H2O', 'HO', 'H'],
        'correctAnswer': 'H2O',
      },
      {
        'question': 'What is the largest planet in our solar system?',
        'options': ['Earth', 'Mars', 'Jupiter', 'Saturn'],
        'correctAnswer': 'Jupiter',
      },
      {
        'question': 'What is the smallest bone in the human body?',
        'options': ['Femur', 'Stapes', 'Tibia', 'Humerus'],
        'correctAnswer': 'Stapes',
      },
      {
        'question': 'What element does "Fe" represent on the periodic table?',
        'options': ['Iron', 'Gold', 'Silver', 'Lead'],
        'correctAnswer': 'Iron',
      },
      {
        'question': 'What gas do plants absorb from the atmosphere?',
        'options': ['Nitrogen', 'Oxygen', 'Carbon Dioxide', 'Hydrogen'],
        'correctAnswer': 'Carbon Dioxide',
      },
      {
        'question':
            'What process do plants use to convert sunlight into energy?',
        'options': [
          'Photosynthesis',
          'Respiration',
          'Fermentation',
          'Transpiration'
        ],
        'correctAnswer': 'Photosynthesis',
      },
      {
        'question': 'Which planet is known as the "Red Planet"?',
        'options': ['Venus', 'Mars', 'Jupiter', 'Saturn'],
        'correctAnswer': 'Mars',
      },
      {
        'question': 'What is the hardest natural substance on Earth?',
        'options': ['Iron', 'Diamond', 'Quartz', 'Gold'],
        'correctAnswer': 'Diamond',
      },
      {
        'question':
            'Which scientist proposed the theory of evolution by natural selection?',
        'options': [
          'Charles Darwin',
          'Isaac Newton',
          'Albert Einstein',
          'Gregor Mendel'
        ],
        'correctAnswer': 'Charles Darwin',
      },
      {
        'question': 'What is the study of earthquakes called?',
        'options': ['Seismology', 'Volcanology', 'Meteorology', 'Astronomy'],
        'correctAnswer': 'Seismology',
      },
      //
      {
        'question': 'Which among following is not a Fish?',
        'options': ['Cuttle Fish', 'Gold Fish', 'Dog Fish', 'Zebra Fish'],
        'correctAnswer': 'Cuttle Fish',
      },
      {
        'question':
            'Which among the following disease is caused by deficiency of Nicotinic acid?',
        'options': ['Anemia', 'Pellagra', 'Dermatitis', 'Goiter'],
        'correctAnswer': 'Pellagra',
      },
      {
        'question': 'What is the S.I. unit for Luminous Intensity?',
        'options': ['mole', 'ampere', 'weber', 'candela'],
        'correctAnswer': 'candela',
      },
      {
        'question': 'Kepler’s second law is also known as?',
        'options': [
          'Law of periods',
          'Law of orbits',
          'Law of areas',
          'Law of Planets'
        ],
        'correctAnswer': 'Law of areas',
      },
      {
        'question':
            'Which of the following is formed when an acid reacts with an alcohol?',
        'options': ['Ketones', 'Esters', 'Aldehydes', 'Alkynes'],
        'correctAnswer': 'Esters',
      },
    ],
    'Literature': [
      {
        'question': 'Who wrote "To Kill a Mockingbird"?',
        'options': [
          'Harper Lee',
          'J.K. Rowling',
          'George Orwell',
          'Mark Twain'
        ],
        'correctAnswer': 'Harper Lee',
      },
      {
        'question':
            'In which play by Shakespeare does the character Hamlet appear?',
        'options': ['Romeo and Juliet', 'Macbeth', 'Hamlet', 'Othello'],
        'correctAnswer': 'Hamlet',
      },
      {
        'question': 'Who wrote the novel "Pride and Prejudice"?',
        'options': [
          'Jane Austen',
          'Emily Brontë',
          'Charlotte Brontë',
          'Mary Shelley'
        ],
        'correctAnswer': 'Jane Austen',
      },
      {
        'question': 'Which novel begins with the line "Call me Ishmael"?',
        'options': ['Moby-Dick', 'The Great Gatsby', '1984', 'Brave New World'],
        'correctAnswer': 'Moby-Dick',
      },
      {
        'question': 'Who is the author of "The Catcher in the Rye"?',
        'options': [
          'J.D. Salinger',
          'F. Scott Fitzgerald',
          'Ernest Hemingway',
          'Sylvia Plath'
        ],
        'correctAnswer': 'J.D. Salinger',
      },
      {
        'question': 'Which literary character lives at 221B Baker Street?',
        'options': [
          'Sherlock Holmes',
          'Dr. Jekyll',
          'Phileas Fogg',
          'Ebenezer Scrooge'
        ],
        'correctAnswer': 'Sherlock Holmes',
      },
      {
        'question': 'Who wrote the novel "1984"?',
        'options': [
          'George Orwell',
          'Aldous Huxley',
          'Ray Bradbury',
          'Margaret Atwood'
        ],
        'correctAnswer': 'George Orwell',
      },
      {
        'question':
            'Which Shakespearean play features the characters Rosencrantz and Guildenstern?',
        'options': ['Hamlet', 'Macbeth', 'Romeo and Juliet', 'Othello'],
        'correctAnswer': 'Hamlet',
      },
      {
        'question': 'Who wrote the epic poem "Paradise Lost"?',
        'options': [
          'John Milton',
          'William Wordsworth',
          'John Keats',
          'Percy Bysshe Shelley'
        ],
        'correctAnswer': 'John Milton',
      },
      {
        'question':
            'Which novel by J.R.R. Tolkien features the character Frodo Baggins?',
        'options': [
          'The Hobbit',
          'The Silmarillion',
          'The Fellowship of the Ring',
          'The Two Towers'
        ],
        'correctAnswer': 'The Fellowship of the Ring',
      },
      //
      {
        'question':
            'T he technique of dramatic monologue is used by Victorian poet?',
        'options': ['T ennys on', 'Arnold', 'Browning', 'Elizabeth'],
        'correctAnswer': 'Browning',
      },
      {
        'question': 'Newman was  a central figure of?',
        'options': [
          'Aesthetic Movement',
          'Pre Raphaelite Movement',
          'Transition Movement',
          'Oxford Movement'
        ],
        'correctAnswer': 'Oxford Movement',
      },
      {
        'question': 'Who is known for his transcendentalist work, "Walden"?',
        'options': [
          'Nathaniel Hawthorne',
          ' Henry James',
          ' Herman Melville',
          'Ralph Waldo Emerson'
        ],
        'correctAnswer': 'Ralph Waldo Emerson',
      },
      {
        'question': 'Which American poet wrote "The Road Not Taken"?',
        'options': [
          'Walt Whitman',
          'Emily Dickinson',
          'Robert Frost',
          'Langston Hughes'
        ],
        'correctAnswer': 'Robert Frost',
      },
      {
        'question': 'What is the title of Sylvia Plath only novel?',
        'options': ['The Bell Jar', 'Lady Lazarus', 'Ariel', 'Daddy'],
        'correctAnswer': 'The Bell Jar',
      },
    ],
  };

  @override
  void initState() {
    super.initState();
    _loadCoins();
  }

  void _loadCoins() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userCoins = prefs.getInt('userCoins') ?? 0;
    });
  }

  void _updateCoins(int amount) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userCoins += amount;
      prefs.setInt('userCoins', userCoins);
    });
    widget.onCoinsChange(amount);
  }

  void _showCorrectAnswerDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          elevation: 0,
          backgroundColor: Colors.transparent,
          child: Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                    color: Colors.purple.withOpacity(0.3),
                    spreadRadius: 5,
                    blurRadius: 7)
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Lottie.asset('assets/animations/correct_answer.json', width: 200, height: 200),
                Text(
                  'Correct!',
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.green),
                ),
                SizedBox(height: 10),
                Text(
                  '+10 Coins',
                  style: TextStyle(fontSize: 18, color: Colors.amber),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                  ),
                  child: Text(
                    'Continue',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildCategorySelection() {
    return Column(
      children: [
        Text(
          'Select a Category',
          style: TextStyle(
              fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        SizedBox(height: 20),
        ...categories
            .map((category) => Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        selectedCategory = category;
                        currentQuestionIndex = 0;
                        selectedAnswer = null;
                      });
                    },
                    child: Text(category,
                        style: TextStyle(fontSize: 18, color: Colors.white)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      padding:
                          EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                    ),
                  ),
                ))
            .toList(),
      ],
    );
  }

  Widget _buildQuestionScreen() {
    var currentQuestion = questions[selectedCategory]![currentQuestionIndex];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          selectedCategory,
          style: TextStyle(
              fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        SizedBox(height: 20),
        LinearProgressIndicator(
          value: (currentQuestionIndex + 1) / totalQuestions,
          backgroundColor: Colors.grey[300],
          valueColor: AlwaysStoppedAnimation<Color>(Colors.amber),
        ),
        SizedBox(height: 10),
        Text(
          'Question ${currentQuestionIndex + 1} of $totalQuestions',
          style: TextStyle(fontSize: 16, color: Colors.white70),
        ),
        SizedBox(height: 20),
        Card(
          elevation: 5,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                Text(
                  currentQuestion['question'],
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                ...currentQuestion['options']
                    .map((option) => Padding(
                          padding: EdgeInsets.symmetric(vertical: 5),
                          child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                selectedAnswer = option;
                              });
                            },
                            child: Text(
                              option,
                              style: TextStyle(color: Colors.white),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: selectedAnswer == option
                                  ? Colors.amber
                                  : Colors.deepPurple,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30)),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 30, vertical: 15),
                            ),
                          ),
                        ))
                    .toList(),
              ],
            ),
          ),
        ),
        SizedBox(height: 20),
        Center(
          child: ElevatedButton(
            onPressed: selectedAnswer != null
                ? () {
                    if (selectedAnswer == currentQuestion['correctAnswer']) {
                      _updateCoins(10);
                      _showCorrectAnswerDialog();
                    }
                    setState(() {
                      if (currentQuestionIndex < totalQuestions - 1) {
                        currentQuestionIndex++;
                        selectedAnswer = null;
                      } else {
                        // Quiz finished, handle end of quiz
                        selectedCategory = '';
                        currentQuestionIndex = 0;
                      }
                    });
                  }
                : null,
            child: Text('Next', style: TextStyle(fontSize: 18)),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),
              padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.amber,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Quiz Challenge',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.amber,
            shadows: [
              Shadow(color: Colors.purpleAccent, blurRadius: 15),
            ],
          ),
        ),
      ),
      body: CustomBackground(
        // decoration: BoxDecoration(
        //   gradient: LinearGradient(
        //     begin: Alignment.topLeft,
        //     end: Alignment.bottomRight,
        //     colors: [Colors.deepPurple, Colors.purple],
        //   ),
        // ),
        child: Padding(
          padding: EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).padding.top - 20,
                ),
                // Row(
                //   children: [
                //     InkWell(
                //       onTap: () {
                //         Navigator.pop(context);
                //       },
                //       child: Icon(Icons.arrow_back, color: Colors.amber),
                //     ),
                //     Expanded(
                //       child: Row(
                //         mainAxisAlignment: MainAxisAlignment.center,
                //         children: [
                //           Text(
                //             'Quiz Challenge',
                //             style: TextStyle(
                //               fontSize: 24,
                //               fontWeight: FontWeight.bold,
                //               color: Colors.amber,
                //               shadows: [
                //                 Shadow(
                //                     color: Colors.purpleAccent, blurRadius: 15),
                //               ],
                //             ),
                //           ),
                //         ],
                //       ),
                //     ),
                //   ],
                // ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.6),
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(color: Colors.amber, width: 2),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.purpleAccent.withOpacity(0.5),
                        blurRadius: 20,
                        spreadRadius: 5,
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Your Current Coins',
                          style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                          decoration: BoxDecoration(
                            color: Colors.deepPurple,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            '$userCoins',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                selectedCategory.isEmpty
                    ? Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.6),
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(color: Colors.amber, width: 2),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.purpleAccent.withOpacity(0.5),
                              blurRadius: 20,
                              spreadRadius: 5,
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: _buildCategorySelection(),
                        ))
                    : Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.6),
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(color: Colors.amber, width: 2),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.purpleAccent.withOpacity(0.5),
                              blurRadius: 20,
                              spreadRadius: 5,
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: SingleChildScrollView(
                              child: _buildQuestionScreen()),
                        )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
