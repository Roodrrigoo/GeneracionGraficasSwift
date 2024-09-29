//
//  SavingHistory.swift
//  GraficasApp
//
//  Created by user240292 on 9/18/24.
//

import SwiftUI
import Charts
import Foundation

struct CountryData: Identifiable, Decodable {
    let id = UUID()
    let nameCountry: String
    let numParties: Int
}

struct CountryList: Decodable {
    let countrylist: [CountryData]
}

struct SavingHistory: View {
    @State private var countries: [CountryData] = []
    @State private var isLoading: Bool = false // Estado para controlar si se está cargando

    var body: some View {
        VStack {
            // Botón de recarga con la flecha
            HStack {
                Spacer()
                Button(action: {
                    isLoading = true
                    loadData() // Llamar a la función de carga cuando se presione el botón
                }) {
                    Image(systemName: "arrow.clockwise")
                        .font(.title)
                        .foregroundColor(.red) // Color rojo para el botón de recarga
                }
                .padding()
            }

            if !countries.isEmpty {
                // Fondo negro o transparente, barras en naranja y texto en rojo
                Chart(countries.prefix(4)) { country in
                    BarMark(
                        x: .value("Country", country.nameCountry),
                        y: .value("Parties", country.numParties)
                    )
                    .foregroundStyle(.orange) // Color de las barras
                }
                .frame(height: 300)
                .padding()
                .background(Color.black) // Fondo negro de la gráfica
                //.background(Color.clear) // Si prefieres fondo transparente, descomenta esta línea y comenta la anterior
                .chartXAxis {
                    AxisMarks {
                        AxisValueLabel().foregroundStyle(Color.red) // Indicadores del eje X en rojo
                    }
                }
                .chartYAxis {
                    AxisMarks {
                        AxisValueLabel().foregroundStyle(Color.red) // Indicadores del eje Y en rojo
                    }
                }
            } else {
                Text("Cargando...")
                    .foregroundColor(.red) // Texto de carga en rojo
            }
        }
        .onAppear(perform: {
            isLoading = true
            loadData()
        }) // Cargar datos cuando la vista aparezca
    }

    // Función para cargar datos de la API
    private func loadData() {
        guard let url = URL(string: "https://www.goabase.net/es/api/party/json/?country=list-all") else {
            return
        }

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                print("Error al obtener los datos: \(String(describing: error))")
                return
            }

            if let countryList = try? JSONDecoder().decode(CountryList.self, from: data) {
                DispatchQueue.main.async {
                    self.countries = countryList.countrylist
                    self.isLoading = false // Detener el indicador de carga
                }
            } else {
                print("Error al decodificar los datos")
                DispatchQueue.main.async {
                    self.isLoading = false
                }
            }
        }

        task.resume()
    }
}

struct SavingHistory_Previews: PreviewProvider {
    static var previews: some View {
        SavingHistory()
    }
}
