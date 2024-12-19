import SwiftUI

struct SnakeOldMainView: View {
    @StateObject private var viewModel = SnakeOldViewModel()
    
    var body: some View {
        VStack {
            GameBoardView(snakePosition: viewModel.snakePosition, foodPosition: viewModel.foodPosition, gridSize: viewModel.gridSize)
            
            Spacer()
            
            ControlPanelView(viewModel: viewModel, direction: $viewModel.direction)
        }
        .alert(isPresented: $viewModel.isGameOver) {
            Alert(title: Text("Game Over"), message: Text("Try again!"), dismissButton: .default(Text("OK"), action: viewModel.resetGame))
        }
        .onAppear {
            viewModel.startGame()
            viewModel.prepareHaptics()
        }
    }
}

#Preview {
    SnakeOldMainView()
}
