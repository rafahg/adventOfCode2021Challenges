/**
 * Created by rafaelhernandez on 10/12/2021.
 */


// For this day I implemented a helper class to emulate the Stack library in Java
// which provide us with useful methods like pop and push, deeply missed in Apex.
// When I say implemented I mean that I found it somewhere and I copy pasted it, just to
// be clear about it.
// You can find the methods and what is going on there in the Stack.cls file in the day
// folder solution.

public with sharing class AdventOfCode2021Day10 {

    public static List<Long> scores;
    public static Map<String, String> openToCloseMap;
    public static Map<String, String> closeToOpenMap;
    public static Map<String, Integer> incorrectCloserValues;
    public static Map<String, Integer> pointValues;

    public static void solutionPart1and2(String dayInput) {
        List<String> input = getInput(dayInput);

        // declaring correct sequence of open to close symbols in a map.
        openToCloseMap = new Map<String,String>();
        openToCloseMap.put('(', ')');
        openToCloseMap.put('[', ']');
        openToCloseMap.put('{', '}');
        openToCloseMap.put('<', '>');

        //declaring correct sequence of close to open symbols in a map.
        closeToOpenMap = new Map<String, String>();
        closeToOpenMap.put(')', '(');
        closeToOpenMap.put(']', '[');
        closeToOpenMap.put('}', '{');
        closeToOpenMap.put('>', '<');

        // declaring the values of syntax error points for each symbol
        incorrectCloserValues = new Map<String, Integer>();
        incorrectCloserValues.put(')', 3);
        incorrectCloserValues.put(']', 57);
        incorrectCloserValues.put('}', 1197);
        incorrectCloserValues.put('>', 25137);

        // declaring the value of a symbol in a completed string.

        // maps a symbol found in the 'completion string' to it's value
        pointValues = new Map<String, Integer>();
        pointValues.put(')', 1);
        pointValues.put(']', 2);
        pointValues.put('}', 3);
        pointValues.put('>', 4);
        List<Long> scores = new List<Long>();
        Integer syntaxErrorTotalValue = 0;
        for(String str : input) {
            String completedString = getCompletedString(str);
            if(completedString.contains('not correct symbol ')) {
                // right method in apex will get us the end characters in a string
                // accepting an Integer as a parameter so, 1 means last char, 2, means last 2 chars.
                String invalidString = completedString.right(1);
                syntaxErrorTotalValue += incorrectCloserValues.get(invalidString);
            } else {
                // generate points for part2 of the challenge.
                scores.add(getFinalScore(completedString));
            }
        }
        scores.sort();
        System.debug('Solution Part 1 is: ' + syntaxErrorTotalValue);
        System.debug('Solution Part 2 is: ' + scores.get(scores.size() / 2));
    }

    // Helpers
    public static Long getFinalScore(String closeSymbols) {
        Long sum = 0;
        for(Integer i=0; i < closeSymbols.length(); i++) {
            sum *=5;
            sum += pointValues.get(closeSymbols.substring(i,i+1));
        }
        return sum;
    }

    public static String getCompletedString(String str) {
        //Container for the string it will be formed at the end.
        String temp = '';
        // Stack class object to track open symbols
        Stack openingSymbols = new Stack();

        for(Integer i=0; i<str.length(); i++) {
            // Substring with start and end index to get 1 particular character in a string
            String symbol = str.substring(i,i+1);
            if(symbol == '(' || symbol == '[' || symbol == '{' || symbol == '<') {
                openingSymbols.add(symbol);
            } else if (!(openingSymbols.pop() == closeToOpenMap.get(symbol))) {
                return 'not correct symbol ' + symbol;
            }
        }
        while(openingSymbols.size() > 0) {
            // Because the stack class deals with Objects in general it is needed
            // to convert object to String in this case to get the correct
            // value in the map.
            temp += openToCloseMap.get(String.valueOf(openingSymbols.pop()));
        }

        return temp;

    }

    public static List<String> reverseString(List<String> stringList) {
        List<String> reversed = new List<String>();
        for(Integer i = stringList.size() - 1; i >= 0; i--){
            reversed.add(stringList[i]);
        }
        return reversed;
    }
    public static List<String> getInput(String day) {
        StaticResource  input = [Select Id, body from StaticResource where Name=:day];
        String inputContent = input.body.toString();
        List<String> finalInput = inputContent.split('\\n');
        return finalInput;
    }
}


