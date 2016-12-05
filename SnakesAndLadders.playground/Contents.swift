//: Playground - noun: a place where people can play

import UIKit

class Graph {
    var V: Int
    var adj: [Graph] = []
    var level: Int?
    
    init(vertex: Int) {
        self.V = vertex
    }
    
    func createEdges(vertexes: [Int: Graph], board: [Int: Int]) {
        guard V < 100 else { return }
        for i in 1...min(100 - self.V, 6) {
            if let edge = board[V + i], let child = vertexes[edge] {
                addEdge(w: child)
            }
        }
    }
    
    func addEdge(w: Graph) {
        adj.append(w)
    }
    
    func setLevels(parent: Int = -1) {
        
        level = parent + 1

        for vertex in adj {
            if let vertexLevel = vertex.level, vertexLevel > level! + 1 {
                vertex.setLevels(parent: level!)
            } else if vertex.level == nil {
                vertex.setLevels(parent: level!)
            }
        }
    }
}

// Setup initial board
var board: [Int: Int] = [:]
for var i in 1...100 {
    board[i] = i
}

// Ladders
board[32] = 62
board[42] = 68
board[12] = 98

// Snakes
board[95] = 13
board[97] = 25
board[93] = 37
board[79] = 27
board[75] = 19
board[49] = 47
board[67] = 17

//board[3] = 54
//board[56] = 33
//board[37] = 100

var vertexes: [Int: Graph] = [:]
for (key, value) in board {
    vertexes[value] = Graph(vertex: value)
}

let rootElement: Graph = vertexes[1]!
rootElement.level = 0

let sortedKeys = Array(vertexes.keys).sorted { $0 < $1 }

for key in sortedKeys {
    vertexes[key]?.createEdges(vertexes: vertexes, board: board)
}

vertexes[1]?.setLevels()

print(vertexes[100]?.level ?? 0)

