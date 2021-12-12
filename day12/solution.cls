/**
 * Created by rafaelhernandez on 12/12/2021.
 */

// Stack Java library implemented in Apex style in Stack Class.
// You can find the methods and what is going on there in the Stack.cls file in the day
// folder solution.


public with sharing class AdventOfCode2021Day12 {

    public static Integer solutionPart1() {
        List<String> paths = pathManager(false);
        return paths.size();
    }

    public static void solutionPart2() {
        List<String> paths = pathManager(true);
        System.debug(paths.size());
    }

    @Future
    public static void executeSolutionPart2() {
        solutionPart2();
    }

    public static void displaySolutions() {
        Integer sol1 = solutionPart1();
       // Integer sol2 = solutionPart2();
        System.debug('The number of paths with only 1 visit to small caves are: ' + sol1);
       // System.debug('The number of paths with only 1 visit to small caves are: ' + sol2);
    }

    public static List<String> pathManager(boolean solution2) {
        List<String> cavesInput = getInput('inputDay12');
        List<String> finishedPaths = new List<String>();
        // Stack object is initialized as List<Object>, so in line 34 we are adding a string to a List.
        Stack pathsGoingOn = new Stack();
        pathsGoingOn.add('start');
        while(pathsGoingOn.size() > 0) {
            String path = String.valueOf(pathsGoingOn.pop());
            String currentCave = path.substring(path.lastIndexOf('-') + 1);
            String cavesToGo = '';
            for(String cave : cavesInput ) {
                if(cave.contains(currentCave)) {
                    cavesToGo += cave.replace('-','').replace(currentCave,'') + ' ';
                }
            }

            List<String> cavesPossible = cavesToGo.trim().split(' ');
            for(String cave : cavesPossible) {
                if(cave.equals('start')) {
                    continue;
                }else if(cave.equals('end')) {
                    finishedPaths.add(path + '-' + cave);
                }else if( cave.equals(cave.toLowerCase())) {
                    if(!path.contains(cave)) {
                        pathsGoingOn.add(path + '-' + cave);
                    } else if(solution2 && !path.contains('visited:')) {
                        pathsGoingOn.add('visited:' + path + '-' + cave);
                    }
                } else {
                    pathsGoingOn.add(path + '-' + cave);
                }
            }
        }
        return finishedPaths;
    }


    // Helpers
    public static List<String> getInput(String day) {
        StaticResource  input = [Select Id, body from StaticResource where Name=:day];
        String inputContent = input.body.toString();
        List<String> finalInput = inputContent.split('\\n');
        return finalInput;
    }

}
