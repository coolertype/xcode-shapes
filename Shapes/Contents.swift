class SwiftPlaygrounds {
    let view = Canvas.shared.backingView
    
    func clear() {
        Canvas.shared.clear()
    }
    
    func run () {
        print("x = \(Canvas.shared.visibleSize.width / 2)")
        print("y = \(Canvas.shared.visibleSize.height / 2)")
        print("width = \(Canvas.shared.visibleSize.width)")
        print("height = \(Canvas.shared.visibleSize.height)")

        let circle = Circle (radius: 3)
        circle.draggable = true
        circle.center.y += 28
        
        let rectangle = Rectangle (width: 15, height: 5, cornerRadius: 1)
        rectangle.color = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
        rectangle.center.y += 20
        rectangle.draggable = true
        
        let line = Line (
            start: Point(x: -10, y: 9),
            end: Point(x: 10, y: 9),
            thickness: 0.5)
        line.center.y -= 1
        line.color = #colorLiteral(red: 1, green: 0.1857388616, blue: 0.5733950138, alpha: 1)
        line.rotation = 170 * Double.pi / 180
        
        let text = Text(string: "Hello, world!", fontSize: 32, fontName: "Futura", color: .red)
        
        //let image = Image(url: "https://upload.wikimedia.org/wikipedia/commons/4/47/PNG_transparency_demonstration_1.png")
        //image.center.y = -15
        
        let image = Image(name: "SwiftBird", tint: .green)
        //image.scale = 0.5
        image.size.width *= 0.5
        image.size.height *= 0.5
        image.center.y = -12
        
        let numRectangles = 4
        var xOffset = Double(-numRectangles / 2)
        var yOffset = -26.0
        let saturationEnd = 0.911
        let saturationStart = 0.1
        let saturationStride = (saturationEnd - saturationStart) / Double(numRectangles)
        
        var saturation = saturationStart
        
        for i in 0...numRectangles {
            let rectangle = Rectangle(width: 10, height: 5, cornerRadius: 0.75)
            rectangle.color = Color(hue: 0.079, saturation: saturation, brightness: 0.934)
            saturation += saturationStride
            
            rectangle.center = Point(x: xOffset, y: yOffset)
            xOffset += 1
            yOffset += 1
        }
        
        circle.onTouchDown {
            circle.color = circle.color.darker()
            circle.dropShadow = Shadow ()
        }
        
        circle.onTouchUp {
            circle.color = Color.random()
            circle.dropShadow = nil
        }
        
        Canvas.shared.onTouchUp {
            circle.center = Canvas.shared.currentTouchPoints.first!
            circle.dropShadow = Shadow()
        }
        
        text.onTouchUp {
            animate (duration: 1) {
                line.rotation += 10 * Double.pi / 180
            }
            
        }
        image.onTouchUp {
            line.rotation += 10 * Double.pi / 180
        }
        
    }
}

