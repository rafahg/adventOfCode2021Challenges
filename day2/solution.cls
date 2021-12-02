public with sharing class AdventOfCode2021Day2 {


    public static Integer  horizontalPosition = 0;
    public static Integer  depthPosition = 0;
    public static Integer  aim = 0;
    public static Integer finalPosition = horizontalPosition * depthPosition;

    // Solution A
    public static Integer coordinatesInterpreterA(List<String> inputs) {
        List<List<String>> organisedInstructions = directionsAndDistance(inputs);
        for(List<String> instructions : organisedInstructions) {
            if(instructions[0] == 'forward') {
                horizontalPosition += Integer.valueOf(instructions[1]);
            } else if (instructions[0] == 'down') {
                depthPosition += Integer.valueOf(instructions[1]);
            } else {
                depthPosition -= Integer.valueOf(instructions[1]);
            }
        }

        return finalPosition;
    }
    
    //Solution B
    public static Integer coordinatesInterpreterB(List<String> inputs) {
        List<List<String>> organisedInstructions = directionsAndDistance(inputs);
        for(List<String> instructions : organisedInstructions) {
            if(instructions[0] == 'forward') {
                horizontalPosition += Integer.valueOf(instructions[1]);
                depthPosition += (aim * Integer.valueOf(instructions[1]));
            } else if (instructions[0] == 'down') {
                aim += Integer.valueOf(instructions[1]);
            } else {
                aim -= Integer.valueOf(instructions[1]);
            }
        }
        return finalPosition;
    }

    // Helpers
              
    public static List<String> getInput(String day) {
        StaticResource  input = [Select Id, body from StaticResource where Name=:day];
        String inputContent = input.body.toString();
        List<String> finalInput = inputContent.split('\\n');
        return finalInput;
    }

    public static List<List<String>> directionsAndDistance(List<String> inputs) {
        List<List<String>> organisedInstructions = new List<List<String>>();
        for (String input : inputs) {
            organisedInstructions.add(input.split(' '));
        }
        return organisedInstructions;
    }


}
