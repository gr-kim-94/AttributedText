//
//  AttributtedText.swift
//
//  Created by 김가람 on 2023/07/03.
//

import SwiftUI

struct AttributedString {
    var text: String
    var fontSize: CGFloat = 13
    var fontWight: UIFont.Weight = .regular
    var foregroundColor: Color = .clear
    var backgroundColor: Color = .clear
}

struct AttributedText: UIViewRepresentable {
    fileprivate var configuration = { (view: UILabel) in }
    
    @Binding var attributedTexts: [AttributedString]
    
    func makeUIView(context: UIViewRepresentableContext<Self>) -> UILabel {
        let label = UILabel()
        
        let attributedText = NSMutableAttributedString()
        
        attributedTexts.forEach {
            let attributes: [NSAttributedString.Key: Any] = [
                .font : UIFont.systemFont(ofSize: $0.fontSize, weight: $0.fontWight),
                .foregroundColor : UIColor($0.foregroundColor),
                .backgroundColor : UIColor($0.backgroundColor)]
            attributedText.append(NSAttributedString(string: $0.text, attributes: attributes))
        }
        
        label.attributedText = attributedText
        
        return label
    }
    
    func updateUIView(_ uiView: UILabel, context: UIViewRepresentableContext<Self>) {
        configuration(uiView)
    }
}

struct AttributedText_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            AttributedText(attributedTexts: .constant([AttributedString(text: "Hello", foregroundColor: .red), AttributedString(text: "World", foregroundColor: .blue)]))
        }
    }
}
