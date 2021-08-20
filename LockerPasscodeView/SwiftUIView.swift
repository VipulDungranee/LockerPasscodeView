//
//  SwiftUIView.swift
//  LockerPasscodeView
//
//  Created by Mac-290 on 20/08/21.
//

import SwiftUI

struct SwiftUIView: View {
    
    @State var angle : Angle = .zero
    var circleFrame : CGRect = CGRect(x: 0, y: 0, width: 300, height: 300)

    var body: some View {
        
        Circle()
            .fill(AngularGradient(gradient: Gradient(colors: [Color.red, Color.blue]), center: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, angle: .degrees(90)))
            .padding()
        .rotationEffect(angle)
            .gesture(
                DragGesture()
                    .onChanged { value in

                        let deltaY = value.location.y - (circleFrame.height / 2)
                        let deltaX = value.location.x - (circleFrame.width / 2)
                        angle = Angle(radians: Double(atan2(deltaY, deltaX)))
                        
                    }
            )
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIView()
    }
}
