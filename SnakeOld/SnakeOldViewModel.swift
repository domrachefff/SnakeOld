import SwiftUI
import CoreHaptics

class SnakeOldViewModel: ObservableObject {
    @Published var snakePosition: [(Int, Int)] = [(5, 5)]
    @Published var foodPosition: (Int, Int) = (3, 3)
    @Published var direction: Direction = .right
    @Published var isGameOver = false
    
    private var engine: CHHapticEngine?
    
    let gridSize = 10
    
    func startGame() {
        Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { _ in
            self.moveSnake()
        }
    }
    
    func moveSnake() {
        var newHead = snakePosition.first!
        
        switch direction {
        case .up: newHead.0 -= 1
        case .down: newHead.0 += 1
        case .left: newHead.1 -= 1
        case .right: newHead.1 += 1
        }
        
        // Проверка на столкновение
        if newHead.0 < 0 || newHead.1 < 0 || newHead.0 >= gridSize || newHead.1 >= gridSize || snakePosition.contains(where: { $0 == newHead }) {
            isGameOver = true
            return
        }
        
        // Добавление новой головы
        snakePosition.insert(newHead, at: 0)
        
        // Проверка на еду
        if newHead == foodPosition {
            foodPosition = (Int.random(in: 0..<gridSize), Int.random(in: 0..<gridSize))
        } else {
            snakePosition.removeLast()
        }
    }
    
    func resetGame() {
        snakePosition = [(5, 5)]
        foodPosition = (3, 3)
        direction = .right
        isGameOver = false
    }
    
    func changeDirection(to newDirection: Direction) {
        if (direction == .up && newDirection != .down) ||
           (direction == .down && newDirection != .up) ||
           (direction == .left && newDirection != .right) ||
           (direction == .right && newDirection != .left) {
            direction = newDirection
            triggerHapticFeedback()
        }
    }
    
    func prepareHaptics() {
        do {
            engine = try CHHapticEngine()
            try engine?.start()
        } catch {
            print("Haptic engine failed to start: \(error.localizedDescription)")
        }
    }
    
    func triggerHapticFeedback() {
        guard let engine = engine else { return }
        
        let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: 0.5)
        let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: 1.0)
        
        let event = CHHapticEvent(eventType: .hapticTransient, parameters: [sharpness, intensity], relativeTime: 0)
        
        do {
            let pattern = try CHHapticPattern(events: [event], parameters: [])
            let player = try engine.makePlayer(with: pattern)
            try player.start(atTime: 0)
        } catch {
            print("Failed to play haptic feedback: \(error.localizedDescription)")
        }
    }
}
