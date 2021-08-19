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
    
    var body: some View {
        
        VStack {
            Text("C :- \(currentValue)")
            Text("R :- \(RotationState)")

            if isDataLoaded {
                ZStack {
                    ZStack{
                        
                        Circle()
                            .fill(Color(CGColor(red:211/255, green: 211/255, blue: 211/255, alpha: 1.0)))
                            .frame(width: circleFrame.width * 1.1, height: circleFrame.height * 1.1, alignment: .center)
                        
                        Circle()
                            .stroke(Color.blue, style: StrokeStyle(lineWidth: 7.5))
                            .frame(width: circleFrame.width, height: circleFrame.height, alignment: .center)
                        
                        ForEach(units, id: \.self) { unit in
                            Text("!")
                                .scaleEffect(x: unit % 10 == 0 ? 2.0 : 1.0, y: 1.0, anchor: .center)
                                .foregroundColor(.green)
                                .offset(x: points[unit].x, y: points[unit].y)
                                .scaleEffect(x: 1.0, y: 1.0, anchor: .center)
//                                .rotationEffect(Angle(degrees: Double(unit / 3)))
                        }
                        
                        ForEach(units, id: \.self) { unit in
                            if unit % 10 == 0 {
                                Text("\(unit)")
                                    .foregroundColor(.green)
                                    .rotationEffect(Angle(degrees: 10))

                                    .offset(x: unit == 0 ? pointsForDigits[unit].x : pointsForDigits[unit / 10].x, y: unit == 0 ? pointsForDigits[unit].y : pointsForDigits[unit / 10].y)

                            }
                        }
                        
                        
                    }
                    .rotationEffect(Angle(degrees: RotationState))
                    .gesture(RotationGesture()
                                .onChanged({ Angle in
                                    self.RotationState = Angle.degrees
                                }))
                    

                    Image(systemName: "minus")
                        .foregroundColor(.yellow)
                        .scaleEffect(x: 0.6, y: 3, anchor: .center)
                        .rotationEffect(Angle(degrees: 90))
                        .offset(x: 0, y: -(circleFrame.height / 2) + 0.3)
                        
                    Circle()
                        .fill(Color.black)
                        .frame(width: 160, height: 160, alignment: .center)
                        .onTapGesture {
                            currentValue = Int(self.RotationState)
                            submitValue = true
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
    
        var temp = 0
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
                
                radious = Double(circleFrame.size.width / 2.5)
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
