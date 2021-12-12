
/**
 * Created by rafaelhernandez on 11/12/2021.
 */

public with sharing class AdventOfCode2021Day11 {

  public static Integer numberOfFlashes = 0;

  // Tried to mix both solutions in the same method but is reaching the CPU limit
  // So solution 2 can be run alone in next method.
   public static void solutions() {
     // Part1
     List<List<Integer>> matrix = getInput('InputDay11');
     for(Integer iteration = 1; iteration <=100; iteration++) {
       updateMatrix(matrix);
     }
     System.debug(numberOfFlashes);
     // Part2
     List<List<Integer>> matrix2 = getInput('InputDay11');
     Integer step = 0;
     // look for how many steps are needed until the matrix is all zeroes
     while(!allElementsAreZero(matrix2)) {
       updateMatrix(matrix);
       step += 1;
     }

     // Print both solutions :

     System.debug('Total flashes after 100 steps are: ' + numberOfFlashes );
     System.debug('First step in which all octopuses flahs is: ' + step);
   }


  public static void solution2() {
    List<List<Integer>> matrix = getInput('InputDay11');
    Integer step = 0;
    // look for how many steps are needed until the matrix is all zeroes
    while(!allElementsAreZero(matrix)) {
      updateMatrix(matrix);
      step += 1;
    }

    System.debug('First step in which all octopuses flahs is: ' + step);
  }


  // Helpers

  public static void updateMatrix(List<List<Integer>> matrix) {
    for(Integer row=0; row<matrix.size(); row++) {
      for(Integer column = 0; column < matrix[0].size(); column++) {
        matrix[row][column]++;
      }
    }
    lookForTens(matrix);
  }

  public static void incrementNeighbours(List<List<Integer>> matrix, Integer row, Integer column) {
    List<Integer> increment = new List<Integer>{-1,0,1};
    for(Integer i=0; i< increment.size(); i++) {
      for(Integer j = 0; j < increment.size(); j++) {
        if( i==1 && j==1) {
          continue;
        }
        if(canBeIncremented(matrix, row + increment[i], column + increment[j])) {
          matrix[row + increment[i]][column + increment[j]]++;
        }
      }
    }
  }

  public static void lookForTens(List<List<Integer>> matrix) {
    boolean willItFlash = false;
    for(Integer row = 0; row < matrix.size(); row++) {
      for(Integer column=0; column < matrix[0].size(); column++) {
        if( matrix[row][column] >= 10) {
          matrix[row][column] = 0;
          numberOfFlashes +=1;
          willItFlash = true;
          incrementNeighbours(matrix, row, column);
        }
      }
    }
    if(willItFlash == true) {
      lookForTens(matrix);
    }
  }

  public static Boolean canBeIncremented(List<List<Integer>> matrix, Integer row, Integer column) {
    return (row >=0 && column >=0 && row < matrix.size() && column < matrix[0].size() && matrix[row][column] != 0);
  }

  public static Boolean allElementsAreZero(List<List<Integer>> matrix) {
    for (Integer row=0; row < matrix.size(); row++) {
      for(Integer column=0; column < matrix[0].size(); column++){
        if(matrix[row][column] !=0) {
          return false;
        }
      }
    }
    return true;
  }

  public static List<List<Integer>> getInput(String day) {
    List<List<Integer>> matrixPositions = new List<List<Integer>>();
    StaticResource  input = [Select Id, body from StaticResource where Name=:day];
    String inputContent = input.body.toString();
    List<String> finalInput = inputContent.split('\\n');
    for(String str : finalInput) {
      List<Integer> temp = listToIntegers(str.split(''));
      matrixPositions.add(temp);
    }
    system.debug(matrixPositions);
    return matrixPositions;
  }

  public static List<Integer> listToIntegers(List<String> strings) {
    List<Integer> result = new List<Integer>();
    for(String str : strings) {
      Integer num = Integer.valueOf(str);
      result.add(num);
    }
    return result;
  }

}
