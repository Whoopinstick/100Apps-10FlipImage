//
//  ContentView.swift
//  10 - FlipImage
//
//  Created by Kevin Paul on 8/16/20.
//  Copyright © 2020 Whoopinstick. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var image: Image?
    @State private var inputImage: UIImage?
    @State private var showingImagePicker = false
    @State private var imageRotation = 0.0
    
    var body: some View {
        NavigationView {
            VStack {
                ZStack {
                    RoundedRectangle(cornerRadius: 15.0)
                        .fill(image == nil ? Color.secondary : Color.clear)
                    
                    //display the image
                    if image != nil {
                        image?
                            .resizable()
                            .scaledToFit()
                            .rotationEffect(Angle(degrees: imageRotation))
                    } else {
                        Text("Tap to select a photo")
                            .foregroundColor(Color.white)
                            .font(.headline)
                    }
                }
                .onTapGesture {
                    //select an image
                    self.showingImagePicker = true
                }
                    
                .padding(.vertical)
                
                
                Button("Rotate") {
                    self.imageRotation += 90
                }
                .disabled(image == nil ? true : false)
                
            }
                
            .padding([.horizontal, .bottom])
                
            .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
                ImagePicker(image: self.$inputImage)
            }
                
            .navigationBarTitle("Image Flip")
            
        }
    }
    
    func loadImage() {
        guard let inputImage = inputImage else { return }
        image = Image(uiImage: inputImage)
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
