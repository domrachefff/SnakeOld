import SwiftUI

struct GameBoardView: View {
    var snakePosition: [(Int, Int)]
    var foodPosition: (Int, Int)
    var gridSize: Int
    
    var body: some View {
        GeometryReader { geometry in
            let squareSize = geometry.size.width / CGFloat(gridSize)
            ZStack {
                // Сетка игрового поля
                ForEach(0..<gridSize, id: \.self) { row in
                    ForEach(0..<gridSize, id: \.self) { column in
                        Rectangle()
                            .stroke(Color.gray, lineWidth: 0.5)
                            .frame(width: squareSize, height: squareSize)
                            .position(x: squareSize * CGFloat(column) + squareSize / 2,
                                      y: squareSize * CGFloat(row) + squareSize / 2)
                    }
                }
                
                // Змейка
                ForEach(snakePosition.indices, id: \.self) { index in
                    let position = snakePosition[index]
                    Rectangle()
                        .fill(index == 0 ? Color.white : Color.green)
                        .frame(width: squareSize, height: squareSize)
                        .position(x: squareSize * CGFloat(position.1) + squareSize / 2,
                                  y: squareSize * CGFloat(position.0) + squareSize / 2)
                }
                
                // Еда
                Rectangle()
                    .fill(Color.red)
                    .frame(width: squareSize, height: squareSize)
                    .position(x: squareSize * CGFloat(foodPosition.1) + squareSize / 2,
                              y: squareSize * CGFloat(foodPosition.0) + squareSize / 2)
            }
        }
        .aspectRatio(1, contentMode: .fit)
    }
}
