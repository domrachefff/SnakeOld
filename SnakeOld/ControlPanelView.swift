import SwiftUI

struct ControlPanelView: View {
    @ObservedObject var viewModel: SnakeOldViewModel
    @Binding var direction: Direction
    
    var body: some View {
        HStack {
            Button(action: { viewModel.changeDirection(to: .left)}) {
                Image(systemName: "arrow.left")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .padding()
                    .background(Color.blue.opacity(0.7))
                    .cornerRadius(8)
            }
            
            VStack {
                Button(action: { viewModel.changeDirection(to: .up)}) {
                    Image(systemName: "arrow.up")
                        .resizable()
                        .frame(width: 50, height: 50)
                        .padding()
                        .background(Color.blue.opacity(0.7))
                        .cornerRadius(8)
                }
                
                Button(action: { viewModel.changeDirection(to: .down)}) {
                    Image(systemName: "arrow.down")
                        .resizable()
                        .frame(width: 50, height: 50)
                        .padding()
                        .background(Color.blue.opacity(0.7))
                        .cornerRadius(8)
                }
            }
            
            Button(action: { viewModel.changeDirection(to: .right)}) {
                Image(systemName: "arrow.right")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .padding()
                    .background(Color.blue.opacity(0.7))
                    .cornerRadius(8)
            }
        }
        .padding()
    }
}
