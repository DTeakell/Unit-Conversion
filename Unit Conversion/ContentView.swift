//
//  ContentView.swift
//  Unit Conversion
//
//  Created by Dillon Teakell on 4/9/24.
//

import SwiftUI

struct ContentView: View {
    
    // Units to choose from
    let units: [String] = ["Meters", "Kilometers", "Miles", "Yards", "Feet"]
    
    // Input Data
    @State private var inputAmount: Double = 0.0
    @State private var inputUnit = "Meters"
    
    // Output Data
    @State private var outputUnit = "Kilometers"
    
    // Computed Property to convert units
    var computedMeasurement: String {
        
        //Step 1: Make properties for your input to base case, and then your base case to output.
        // EX. Kilometers -> Yards = Kilometers -> Meters -> Yards
        let inputToMeters: Double
        let metersToOutput: Double
        
        //Step 2. Make your input unit property into a switch statement to go through all of the different cases
        switch inputUnit {
            // Your input is Kilometers, so you will convert that to meters
        case "Kilometers":
            inputToMeters = 1000.0
            
            // Your input is Feet, so you will convert feet to meters
        case "Feet":
            inputToMeters = 0.3048
        case "Yards":
            inputToMeters = 0.9144
        case "Miles":
            inputToMeters = 1610
            
            // This is if your input unit is meters, in which case you don't need to convert to the base case since it's already there.
        default:
            inputToMeters = 1.0
        }
        
        // Step 3: Make your output unit property into a switch statement to go through all of the different cases
        switch outputUnit {
        case "Kilometers":
            metersToOutput = 0.001
        case "Feet":
            metersToOutput = 3.28084
        case "Yards":
            metersToOutput = 1.09361
        case "Miles":
            metersToOutput = 0.000621371
        default:
            metersToOutput = 1.0
        }
        
        // Step 4: This is where you take your input units and convert them to the base case.
        // Ex. Kilometers to Meters
        let inputInMeters = inputAmount * inputToMeters
        
        // Step 5: This is where you will convert your base unit to the unit of choice
        // Ex. Meters to Yards
        let output = inputInMeters * metersToOutput
        
        // This is where you format your conversion to a string
        let outputToString = output.formatted(.number)
        return outputToString
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                // Input
                VStack (alignment: .leading) {
                    Picker("Unit Type", selection: $inputUnit) {
                        ForEach(units, id: \.self) {unit in
                            Text(unit)
                        }
                    }
                    .tint(.mint)
                       
                    InputTextView(value: $inputAmount)
                    
                }
                .cardStyle()
            

                // Output
                VStack (alignment: .leading) {
                    Picker("Unit Type", selection: $outputUnit) {
                        ForEach(units, id: \.self) {unit in
                            Text(unit)
                        }
                    }
                    .tint(.mint)
                    
                    OutputTextView(text: computedMeasurement)
                        
                }
                .cardStyle()
            
            Spacer()
                
            }
            .padding()
            .navigationTitle("Unit Conversion")
        }
    }
}

struct Card: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(maxHeight: 120)
            .background(.ultraThinMaterial)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            
    }
}

struct InputTextView: View {
    @Binding var value: Double
    var body: some View {
        TextField("Enter amount of units", value: $value, format: .number)
            .padding(.horizontal)
            .font(.title2)
            .fontWeight(.semibold)
            .frame(maxWidth: .infinity, maxHeight: 50)
            .keyboardType(.decimalPad)
    }
}

struct OutputTextView: View {
    let text: String
    var body: some View {
        
        Text("\(text)")
            .font(.title2)
            .fontWeight(.semibold)
            .foregroundStyle(.mint)
            .frame(maxWidth: .infinity, maxHeight: 50, alignment: .leading)
            .padding(.horizontal)
    }
}

extension View {
    func cardStyle() -> some View {
        modifier(Card())
    }
}


#Preview {
    ContentView()
}

