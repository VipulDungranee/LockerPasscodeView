//
//  NumberDilerView.swift
//  LockerPasscodeView
//
//  Created by Mac-290 on 19/08/21.
//

import SwiftUI

struct NumberDilerView: View {
    
    @Binding var RotationState : Double
    
    @Binding var currentValue : Int
    
    var circleFrame : CGRect = CGRect(x: 0, y: 0, width: 300, height: 300)
    
    @State var units : [Int] = [0,1,2,3,4,5,6,7,8,9]
    
    @State var points : [CGPoint] = [CGPoint]()
    @State var pointsForDigits : [CGPoint] = [CGPoint]()

    
    @State var isDataLoaded = false
    
    @Binding var submitValue : Bool
    
    @State var callTap : Bool = false
    @State var digitlTap : Bool = false
        
    @State var angle : Angle = .zero
    @State var currentAngle : Angle = .zero
    @State var prevAngle : Angle = .zero

    
    @State var rotationSpeed : Double = 0.0

    @State var prevLocation : CGPoint = CGPoint(x: 0, y: 0)
    
    var body: some View {
        
        VStack {
            Text("C :- \(currentValue)")
            Text("R :- \(RotationState)")

            if isDataLoaded {
                ZStack {
                    ZStack{
                        
                        Circle()
                            .fill(Color(CGColor(red:233/255, green: 233/255, blue: 233/255, alpha: 1.0)))
                            .frame(width: circleFrame.width * 1.1, height: circleFrame.height * 1.1, alignment: .center)
//                            .shadow(radius: 10)
                        
                        Circle()
                            .stroke(Color.blue, style: StrokeStyle(lineWidth: 7.5))
                            .frame(width: circleFrame.width, height: circleFrame.height, alignment: .center)
                        
                        ForEach(units, id: \.self) { unit in
                            Text("!")
                                .scaleEffect(x: unit % 10 == 0 ? 2.0 : 1.0, y: 1.0, anchor: .center)
                                .foregroundColor(.gray)
                                .offset(x: points[unit].x, y: points[unit].y)
                                .scaleEffect(x: 1.0, y: 1.0, anchor: .center)
                        }
                        .hidden()
                        
                                                
                        ForEach(units, id: \.self) { unit in
                            if unit % 10 == 0 {
                                
                                
                                
                                ZStack {
                                    Image(systemName: "circlebadge")
                                        .background(LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1)), Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)),Color(#colorLiteral(red: 0.1294117719, green: 0.2156862766, blue: 0.06666667014, alpha: 1))]), startPoint: .topLeading, endPoint: .bottomTrailing))
                                        .scaleEffect(2.0)
                                        .cornerRadius(10)
                                        .clipped()
                                    
                                    
                                    Text("\(unit / 10)")
                                        .font(.system(size: 17, weight: .bold, design: .serif))
                                        .foregroundColor(.white)
                                        .offset(x: -0.2, y: 0)
                                        .shadow(color: .black, radius: 1, x: -1.0, y: 0.5)
                                        .scaleEffect(0.85)


                                }
                                .overlay(Circle().stroke(lineWidth: 0.1).shadow(color: .green, radius: 5, x: -1.0, y: 0.5))
                                .scaleEffect(digitlTap ? 2.2 : 2.1)
                                .offset(x: unit == 0 ? pointsForDigits[unit].x : pointsForDigits[unit / 10].x, y: unit == 0 ? pointsForDigits[unit].y : pointsForDigits[unit / 10].y)
                                    .onTapGesture {
                                        currentValue = Int(self.RotationState)
                                        submitValue = true
                                        
                                        digitlTap.toggle()
                                        
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2, execute: {
                                            digitlTap.toggle()
                                        })
                                    }
                                
                                

                            }
                        }
                        
                        
                    }
                    .rotationEffect(angle)
                    .animation(.linear(duration: rotationSpeed), value: angle)


                    .gesture(
                        DragGesture()
                        
                            .onChanged { value in
                                
                                if rotationSpeed == 0.3 {
                                    rotationSpeed = 0.0
                                }
                                
                                   
                                if prevLocation.x == 0 && prevLocation.y == 0 {
                                    prevLocation = value.location
                                    
                                    let deltaY = prevLocation.y - (circleFrame.height / 2)
                                    let deltaX = prevLocation.x - (circleFrame.width / 2)
                                    
                                    prevAngle = Angle(radians: Double(atan2(deltaY, deltaX)))
                                }
                                
                                     
        
                                let deltaY = value.location.y  - (circleFrame.height / 2)
                                let deltaX = value.location.x - (circleFrame.width / 2)
                                let newAngel = (Angle(radians: Double(atan2(deltaY, deltaX))) - prevAngle)
                                
                                print(newAngel.degrees)
                                
                                
                                
                                if newAngel > angle {
                                    angle = newAngel
                                }
                            }
                            .onEnded({ Value in
                                RotationState = angle.degrees
                                rotationSpeed = 0.3
                                angle = .zero
                                prevLocation.x = 0
                                prevLocation.y = 0
                            })
                    )
                    

                    Image(systemName: "arrowtriangle.down.fill")
                        .foregroundColor(.red)
                        .scaleEffect(x: 1.0, y: 1.0, anchor: .center)
                        .rotationEffect(Angle(degrees: 360))
                        .offset(x: 0, y: -(circleFrame.height / 2) + 3.0)
                        
                              
                    ZStack {
                        Circle()
                            .stroke()
                        Image("ic_callButton")
                            .scaleEffect(1.0)
                            .scaleEffect(x: 1.0, y: 1.0,anchor: UnitPoint(x: 0.5, y: 0.5))
                            .scaleEffect(callTap ? 2.2 : 2.3)
                            .animation(.spring(response: 0.4, dampingFraction: 0.6))

                    }
                    .frame(width: 160, height: 160, alignment: .center)
                    .onTapGesture {
                        
                        
                        print("cValue...",RotationState)
                        
                        var diledValue = RotationState.degreeToInt() ?? 0
                        print("value...",diledValue)

                        currentValue = diledValue
                        submitValue = true
                        
                        callTap.toggle()
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2, execute: {
                            callTap.toggle()
                        })
                    }
                        
                }
                .padding()
            }
            
        }
        .onAppear(perform: {
            
           setDataForIcons()
            
        })
    }
}

extension NumberDilerView {
    
    func setDataForIcons() {
        
        var radious = Double(circleFrame.size.width / 2.5)
        let pi = 3.14159
    
        var counter = 0
        
        for k in 0...360
        {
            
            if k < 100 {
                units.append(k)
            }
            
            
            radious = Double(circleFrame.size.width / 2.2)
            let x = radious * sin(pi * 2 * Double(k) / 360)
            let y = radious * cos(pi * 2 * Double(k) / 360)
            
            
            if k % 36 == 0 && k != 360 {
                points.append((CGPoint(x: x, y: y)))
                counter += 1
            }
            if k % 4 == 0,counter < 100 {
                points.append((CGPoint(x: x, y: y)))
                counter += 1
            }
        
            
            //for digit
            if k % 36 == 0 && k != 360 {
                
                radious = Double(circleFrame.size.width / 2.7)
                let x = radious * sin(pi * 2 * Double(k) / 360)
                let y = radious * cos(pi * 2 * Double(k) / 360)
                
                pointsForDigits.append(CGPoint(x: x, y: y))
            }
            
        }
        
        print("count1",points.count)
        print("count2",pointsForDigits.count)
        
        isDataLoaded = true

    }
    
}

struct NumberDilerView_Previews: PreviewProvider {
    static var previews: some View {
        NumberDilerView(RotationState: Binding.constant(0.0), currentValue: Binding.constant(0), submitValue: Binding.constant(false))
    }
}

extension Double {
     func degreeToInt() -> Int? {
        var val = 0
        
        val = Int(self / 36.0)
            
        if val < 0 {
            val = val * (-1)
        }
        
        
        switch self {
        case (0...(36 * 1)):
            return 5
        case (37...72):
            return 6
        case (73...108):
            return 7
        case (109...144):
            return 8
        case (145...180):
            return 9
        case (181...216):
            return 0
        case (217...252):
            return 1
        case (253...288):
            return 2
        case (289...324):
            return 3
        case (324...359):
            return 4
        default:
            return val
        }
        
        return val
    }
}
