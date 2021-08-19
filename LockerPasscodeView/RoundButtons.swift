import SwiftUI

struct RoundButtons: View {
    @Binding var isSet : Bool
    
    var size : CGSize
    var body: some View {
        Circle()
            .fill(isSet ? Color.blue : Color.gray)
                .frame(width: size.width, height: size.height, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
        
    }
}

struct RoundButtons_Previews: PreviewProvider {
    static var previews: some View {
        RoundButtons(isSet: Binding.constant(false), size: CGSize(width: 90, height: 90))
    }
}
