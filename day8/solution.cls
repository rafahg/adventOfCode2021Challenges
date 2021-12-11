
/**
 * Created by rafaelhernandez on 08/12/2021.
 */

public with sharing class AdventOfCode2021Day8 {

    // Solution Part 1
    public static Integer processedStrings(String inputs, String splitChar, String splitChar1) {
        List<String> numberCodes = codeProcessorA(inputs, splitChar, splitChar1);
        System.debug(numberCodes);
        Map<Integer, Integer> ComplexNumberTracker = new Map<Integer,Integer>();
        List<String> simpleNumberTracker = New List<String>();
        for(String str : numberCodes) {
            List<String> separatedNumbers = str.split(' ');
            for(String str1 : separatedNumbers) {
                if(str1.length() == 2) {
                    simpleNumberTracker.add(str1);
                } else if (str1.length() == 3) {
                    simpleNumberTracker.add(str1);
                } else if (str1.length() == 4) {
                    simpleNumberTracker.add(str1);
                } else if (str1.length() == 7) {
                    simpleNumberTracker.add(str1);
                }
            }
        }
        system.debug(simpleNumberTracker.size());
        return simpleNumberTracker.size();
    }

    // Solution Part 2
    public static Integer processedStringsPart2(String inputs, String splitChar, String splitChar1) {
        List<String> numberCodes = codeProcessorB(inputs, splitChar, splitChar1);
        //System.debug(numberCodes);
        Map<Integer, String> complexNumberTracker = new Map<Integer,String>();
        List<String> numbersToTrack5char = New List<String>();
        List<String> numbersToTrack6char = New List<String>();
        for(String str : numberCodes) {
            List<String> separatedNumbers = str.split(' ');
            for(String str1 : separatedNumbers) {
                if(str1.length() == 2) {
                    complexNumberTracker.put(1, str1);
                } else if (str1.length() == 3) {
                    complexNumberTracker.put(7, str1);
                } else if (str1.length() == 4) {
                    complexNumberTracker.put(4, str1);
                } else if (str1.length() == 7) {
                    complexNumberTracker.put(8,str1);
                }else if (str1.length() == 5) {
                    numbersToTrack5char.add(str1);
                } else if (str1.length() == 6) {
                    numbersToTrack6char.add(str1);
                }
            }
        }
        // Getting 3
        for(String str : numbersToTrack5char) {
            if(str.contains(complexNumberTracker.get(1).split('')[0]) &&  str.contains(complexNumberTracker.get(1).split('')[1])){
                complexNumberTracker.put(3,str);
            }
        }
        // Getting 6
        for(String str : numbersToTrack6char) {
            if(str.contains(complexNumberTracker.get(1).split('')[0]) &&  str.contains(complexNumberTracker.get(1).split('')[1])){

            } else {
                complexNumberTracker.put(6,str);
            }
        }
        // Getting 0 and 9
        List<String> ZeroAndNine = new List<String>();
        for(String str : numbersToTrack6char) {
            if(str != complexNumberTracker.get(6)){
                ZeroAndNine.add(str);
            }
        }
        List<String> four = complexNumberTracker.get(4).split('');
          if(ZeroAndNine[0].contains(four[0]) &&
                ZeroAndNine[0].contains(four[1]) &&
                ZeroAndNine[0].contains(four[2]) &&
                ZeroAndNine[0].contains(four[3])) {
              complexNumberTracker.put(9,ZeroAndNine[0]);
              complexNumberTracker.put(0,ZeroAndNine[1]);
          } else {
              complexNumberTracker.put(9,ZeroAndNine[1]);
              complexNumberTracker.put(0,ZeroAndNine[0]);
          }
        // Getting 2 and 5
        List<String> twoAndFive = new List<String>();
        for(String str : numbersToTrack5char) {
            if(str != complexNumberTracker.get(3)) {
                twoAndFive.add(str);
            }
        }
        List<String> twoOrFive = twoAndFive[0].split('');
        String counter = '';
        for(String str : twoOrFive) {
            if(complexNumberTracker.get(6).contains(str) == false) {
                counter +=str;
            }
        }
        if(counter.length() > 0) {
            complexNumberTracker.put(2, twoAndFive[1]);
        }
            complexNumberTracker.put(2, twoAndFive[1]);
            complexNumberTracker.put(5, twoAndFive[0]);
        List<String> numbersToCheck = codeProcessorA(inputs, splitChar, ('| '));
        List<String> separatedNumbers = numbersToCheck[0].split(' ');
        System.debug(separatedNumbers);
        String num = '';
        for(String str : numbersToCheck) {
            String str1 = str;
          for(Integer key : complexNumberTracker.keySet()) {
              List<String> String1 = complexNumberTracker.get(key).split('');
              String1.sort();

              System.debug(str1);


          }
        }
        System.debug(num);
        return null;
    }


    // Helpers

    //It will return a list of Strings.
    public static List<String> getInput(String day, String splitParameter) {
        StaticResource  input = [Select Id, body from StaticResource where Name=:day];
        String inputContent = input.body.toString();
        // '//n' to split in a new line
        List<String> finalInput = inputContent.split(splitParameter);
        return finalInput;
    }

    public static List<String> codeProcessorA(String code, String splitParameter1, String splitParameter2) {
        List<String> processedCodes = getInput(code, splitParameter1);
        List<String> codedNumbers = new List<String>();
        for(String str : processedCodes) {
            // ('| ') or (' |')
            String str1 = str.substringAfter('| ');
            codedNumbers.add(str1);
        }
        return codedNumbers;
    }

    public static List<String> codeProcessorB(String code, String splitParameter1, String splitParameter2) {
        List<String> processedCodes = getInput(code, splitParameter1);
        List<String> codedNumbers = new List<String>();
        for(String str : processedCodes) {
            // ('| ') or (' |')
            String str1 = str.substringBefore(' |');
            codedNumbers.add(str1);
        }
        return codedNumbers;
    }
}
