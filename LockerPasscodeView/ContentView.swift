//
//  ContentView.swift
//  LockerPasscodeView
//
//  Created by Mac-290 on 19/08/21.
//

import SwiftUI

struct ContentView: View {
    
    @State var buttons : [Int:Int] = [1:0,2:0,3:0]
    @State var buttonFirstIsSet = false
    @State var buttonSecondIsSet = false
    @State var buttonThirdIsSet = false

    @State var currentValue : Int = 0
    @State var submitValue : Bool = false
    
    @State var rotationValue : Double = 0.0

    
    var body: some View {
        VStack {
            HStack {
                RoundButtons(isSet: $buttonFirstIsSet, size: CGSize(width: 32, height: 32))
                RoundButtons(isSet: $buttonSecondIsSet, size: CGSize(width: 32, height: 32))
                RoundButtons(isSet: $buttonThirdIsSet, size: CGSize(width: 32, height: 32))
            }
            .padding()
            
            
            NumberDilerView(RotationState: $rotationValue, currentValue: $currentValue, circleFrame: CGRect(x: 0, y: 0, width: 350, height: 350), submitValue: $submitValue)
            
            Spacer()
        }
        .onChange(of: currentValue, perform: { value in
            if submitValue {
                print("currentValue :",currentValue)
            }
            
            if !buttonFirstIsSet && submitValue == true {
                buttonFirstIsSet = true
                buttons[1] = currentValue
            }
            else if buttonFirstIsSet,!buttonSecondIsSet && submitValue == true {
                buttonSecondIsSet = true
                buttons[2] = currentValue

            }
            else if buttonFirstIsSet,buttonSecondIsSet,!buttonThirdIsSet && submitValue == true {
                buttonThirdIsSet = true
                buttons[3] = currentValue

            }
            else if buttonFirstIsSet,buttonSecondIsSet,buttonThirdIsSet && submitValue == true {
                //reset to 0
                rotationValue = 0
            }
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
