//
//  ContentView.swift
//  LengthConverter
//
//  Created by David Bailey on 15/05/2021.
//

import SwiftUI

enum Measurement: String, CaseIterable, Identifiable {
    case meters
    case kilometers
    case feet
    case yards
    case miles

    var id: String { rawValue }
}

extension Measurement {
    var valueInMeters: Double {
        switch self {
        case .meters: return 1
        case .kilometers: return 1000
        case .feet: return 0.3048
        case .yards: return 0.9144
        case .miles: return 1609.344
        }
    }
}

struct ContentView: View {
    @State private var inputString = ""
    @State private var inputMeasurement = Measurement.meters
    @State private var outputMeasurement = Measurement.feet

    private var inputLength: Double { Double(inputString) ?? 0 }
    private var lengthInMeters: Double {
        inputLength * inputMeasurement.valueInMeters
    }
    private var outputLength: Double {
        lengthInMeters / outputMeasurement.valueInMeters
    }

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Original Length")) {
                    HStack {
                        TextField("Length", text: $inputString)
                            .keyboardType(.decimalPad)
                        Text(inputMeasurement.rawValue)
                    }
                    Picker("Unit", selection: $inputMeasurement) {
                        ForEach(Measurement.allCases, id: \.self) {
                            Text($0.rawValue)
                        }
                    }
                }

                Section(header: Text("Converted Length")) {
                    HStack {
                        Text("\(outputLength, specifier: "%.2f")")
                        Text(outputMeasurement.rawValue)
                    }
                    Picker("Unit", selection: $outputMeasurement) {
                        ForEach(Measurement.allCases, id: \.self) {
                            Text($0.rawValue)
                        }
                    }
                }

                Button(action: {
                    inputString = String(format: "%.2f", outputLength)
                    swap(&inputMeasurement, &outputMeasurement)
                }) {
                    HStack {
                        Image(systemName: "arrow.triangle.swap")
                        Text("Swap direction")
                    }
                }
            }
            .navigationBarTitle("Length Converter")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
