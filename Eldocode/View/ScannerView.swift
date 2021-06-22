//
//  ScannerView.swift
//  Eldocode
//
//  Created by Daniil on 19.06.2021.
//

import SwiftUI
import CarBode
import AVFoundation

struct ScannerView: View {
    var body: some View {
        VStack{
            CBScanner(
                     supportBarcode: .constant([.qr, .code128]), //Set type of barcode you want to scan
                     scanInterval: .constant(5.0) //Event will trigger every 5 seconds
                 ){
                     //When the scanner found a barcode
                     print("BarCodeType =",$0.type.rawValue, "Value =",$0.value)
                 }
                 onDraw: {
                     print("Preview View Size = \($0.cameraPreviewView.bounds)")
                     print("Barcode Corners = \($0.corners)")
                     
                     //line width
                     let lineWidth = 2

                     //line color
                     let lineColor = UIColor.red

                     //Fill color with opacity
                     //You also can use UIColor.clear if you don't want to draw fill color
                     let fillColor = UIColor(red: 0, green: 1, blue: 0.2, alpha: 0.4)
                     
                     //Draw box
                    $0.draw(lineWidth: CGFloat(lineWidth), lineColor: lineColor, fillColor: fillColor)
                 }
        }
        
    }
}

struct ScannerView_Previews: PreviewProvider {
    static var previews: some View {
        ScannerView()
    }
}
