// import 'package:flutter/material.dart';
// //import 'package:flutter_local_notifications.dart';

// void main() {
//   runApp(const MedicalChatbotApp());
// }

// class MedicalChatbotApp extends StatelessWidget {
//   const MedicalChatbotApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Medical Chatbot',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: const ChatScreen(),
//     );
//   }
// }

// class ChatScreen extends StatefulWidget {
//   const ChatScreen({super.key});

//   @override
//   State<ChatScreen> createState() => _ChatScreenState();
// }

// class _ChatScreenState extends State<ChatScreen> {
//   final List<ChatMessage> _messages = [];
//   final TextEditingController _textController = TextEditingController();
  
//   String _name = "";
//   int _age = 0;
//   String _medications = "";

//   void _handleSubmitted(String text) {
//     _textController.clear();
//     _addMessage(ChatMessage(text: text, isUser: true));

//     // Process user input and generate bot responses
//     String botResponse = _generateBotResponse(text);
//     _addMessage(ChatMessage(text: botResponse, isUser: false));
//   }

//   String _generateBotResponse(String userMessage) {
//     userMessage = userMessage.toLowerCase();

//     if (_name.isEmpty) {
//       _name = userMessage; 
//       return "Hello, $_name! What is your age?";
//     } else if (_age == 0) {
//       try {
//         _age = int.parse(userMessage); 
//         return "Okay, $_age years old. Please list your medications (separated by commas):";
//       } catch (e) {
//         return "Invalid age. Please enter a number.";
//       }
//     } else if (_medications.isEmpty) {
//       _medications = userMessage;
//       return "Thank you. Here are some general recommendations: \n"
//           "Medications: $_medications \n"
//           "Schedule: Take medications as prescribed. Set reminders! \n"
//           "Log: Keep track of your medication intake and any side effects.";
//     } else if (userMessage.contains("reminder")) {
//       return "Reminder set!"; 
//     } else if (userMessage.contains("log")) {
//       return "Log created!"; 
//     } else if (_getMedicineRecommendation(userMessage).isNotEmpty) {
//       return _getMedicineRecommendation(userMessage);
//     } else {
//       return "I can provide information about medications, remedies, and more. Ask me!";
//     }
//   }

//   // New function to provide medicine recommendations
//   String _getMedicineRecommendation(String disease) {
//     if (disease.contains("fever")) {
//       return "For fever, you can take Paracetamol or Ibuprofen. Drink plenty of fluids and rest.";
//     } else if (disease.contains("cold")) {
//       return "For a common cold, try using saline nasal spray, warm fluids, and rest.";
//     } else if (disease.contains("headache")) {
//       return "For headaches, consider using Paracetamol or Ibuprofen. Stay hydrated and avoid stress.";
//     } else if (disease.contains("stomach pain")) {
//       return "For stomach pain, you may try Antacids or Pepto-Bismol. Stay hydrated and avoid spicy food.";
//     } else if (disease.contains("cough")) {
//       return "For a cough, you can use Cough Syrup, Honey & Lemon, or warm salt water gargles.";
//     } else {
//       return "I am not sure about that disease. Could you provide more details?";
//     }
//   }

//   void _addMessage(ChatMessage message) {
//     setState(() {
//       _messages.insert(0, message);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Medical Chatbot'),
//       ),
//       body: Column(
//         children: <Widget>[
//           Expanded(
//             child: ListView.builder(
//               reverse: true,
//               padding: const EdgeInsets.all(8.0),
//               itemCount: _messages.length,
//               itemBuilder: (_, int index) => _messages[index],
//             ),
//           ),
//           _buildTextComposer(),
//         ],
//       ),
//     );
//   }

//   Widget _buildTextComposer() {
//     return Container(
//       margin: const EdgeInsets.symmetric(horizontal: 8.0),
//       child: Row(
//         children: <Widget>[
//           Flexible(
//             child: TextField(
//               controller: _textController,
//               onSubmitted: _handleSubmitted,
//               decoration: InputDecoration(
//                 hintText: 'Ask about diseases or send a message...',
//               ),
//             ),
//           ),
//           IconButton(
//             onPressed: () => _handleSubmitted(_textController.text),
//             icon: const Icon(Icons.send),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class ChatMessage extends StatelessWidget {
//   const ChatMessage({super.key, required this.text, required this.isUser});

//   final String text;
//   final bool isUser;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.symmetric(vertical: 10.0),
//       child: Row(
//         mainAxisAlignment:
//             isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
//         children: <Widget>[
//           if (!isUser) // Bot message
//             const CircleAvatar(child: Text('Bot')), // Replace with bot avatar
//           Expanded(
//             child: Container(
//               padding: const EdgeInsets.all(10.0),
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(10.0),
//                 color: isUser ? Colors.blue[100] : Colors.grey[200],
//               ),
//               child: Text(text),
//             ),
//           ),
//           if (isUser) // User message
//             const CircleAvatar(child: Icon(Icons.person)),
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';

void main() {
  runApp(const MedicalChatbotApp());
}

class MedicalChatbotApp extends StatelessWidget {
  const MedicalChatbotApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Medical Chatbot',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ChatScreen(),
    );
  }
}

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final List<ChatMessage> _messages = [];
  final TextEditingController _textController = TextEditingController();

  void _handleSubmitted(String text) {
    if (text.isEmpty) return; // Prevent empty messages
    _textController.clear();
    _addMessage(ChatMessage(text: text, isUser:  true));

    // Generate bot response
    String botResponse = _generateBotResponse(text);
    _addMessage(ChatMessage(text: botResponse, isUser:  false));
  }

  String _generateBotResponse(String userMessage) {
    userMessage = userMessage.toLowerCase();

    if (userMessage.contains("fever")) {
      return "For fever, you can take Paracetamol or Ibuprofen. Drink plenty of fluids and rest.";
    } else if (userMessage.contains("cold")) {
      return "For a common cold, try using saline nasal spray, warm fluids, and rest.";
    } else if (userMessage.contains("headache")) {
      return "For headaches, consider using Paracetamol or Ibuprofen. Stay hydrated and avoid stress.";
    } else if (userMessage.contains("stomach pain")) {
      return "For stomach pain, you may try Antacids or Pepto-Bismol. Stay hydrated and avoid spicy food.";
    } else if (userMessage.contains("cough")) {
      return "For a cough, you can use Cough Syrup, Honey & Lemon, or warm salt water gargles.";
    } else if (userMessage.contains("reminder")) {
      return "Reminder set! Please specify what you want to be reminded about.";
    } else if (userMessage.contains("log")) {
      return "Log created! Please specify what you want to log.";
    } else {
      return "I can provide information about medications, remedies, and more. Ask me!";
    }
  }

  void _addMessage(ChatMessage message) {
    setState(() {
      _messages.insert(0, message);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Medical Chatbot'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              reverse: true,
              padding: const EdgeInsets.all(8.0),
              itemCount: _messages.length,
              itemBuilder: (_, int index) => _messages[index],
            ),
          ),
          _buildTextComposer(),
        ],
      ),
    );
  }

  Widget _buildTextComposer() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        children: <Widget>[
          Flexible(
            child: TextField(
              controller: _textController,
              onSubmitted: _handleSubmitted,
              decoration: const InputDecoration(
                hintText: 'Ask about diseases or send a message...',
              ),
            ),
          ),
          IconButton(
            onPressed: () => _handleSubmitted(_textController.text),
            icon: const Icon(Icons.send),
          ),
        ],
      ),
    );
  }
}

class ChatMessage extends StatelessWidget {
  const ChatMessage({super.key, required this.text, required this.isUser });

  final String text;
  final bool isUser ;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        mainAxisAlignment: isUser  ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: <Widget>[
          if (!isUser ) // Bot message
            const CircleAvatar(child: Text('Bot')), // Replace with bot avatar
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: isUser  ? Colors.blue[100] : Colors.grey[200],
              ),
              child: Text(text),
            ),
          ),
          if (isUser ) // User message
            const CircleAvatar(child: Icon(Icons.person)),
        ],
      ),
    );
  }
}