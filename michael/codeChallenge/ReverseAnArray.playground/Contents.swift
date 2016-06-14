//: Playground - noun: a place where people can play

import UIKit

var myArray = ["Earth", "Fire", "Water", "Air", "Spirit"]
var secondArray = ["Baseball", "Football", "Hockey", "Badminton", "Ultimate Frisbee", "Water Polo", "Basketball"]

func printTwoIndexes(input: [String])-> [String]{
   
    var newArray = input
    var startIndex = 0
    var endIndex = newArray.count-1
    var temp = ""
    var maxIterationCount = newArray.count/2
    
    for _ in newArray {
        while maxIterationCount > 0{
            temp = newArray[startIndex]
            newArray[startIndex] = newArray[endIndex]
            newArray[endIndex] = temp
            startIndex++
            endIndex--
            maxIterationCount--
        }
    }
    
return(newArray)
}

printTwoIndexes(myArray)
printTwoIndexes(secondArray)


