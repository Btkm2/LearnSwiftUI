//
//  ChartView.swift
//  LearnSwiftUI
//
//  Created by Beket Muratbek on 25.04.2023.
//

import SwiftUI
import Charts

struct ChartView: View {
    enum SortType: String, CaseIterable {
        case BubbleSort
        case InsertionSort
    }
    
    @State var ChartArr: [Float] = Array(repeating: 0, count: 20).map { _ in Float.random(in: 4...25)}
    @State var previous_value: Float = 0.0
    @State var current_value: Float = 0.0
    @State var funcStop: Bool = false
    @State var selectedSortType = SortType.BubbleSort.rawValue
    var body: some View {
        VStack {
            Spacer()
            Grid {
                GridRow {
                    Chart {
                        ForEach(Array(ChartArr.enumerated()), id: \.0) { index, value in
                            BarMark(x: .value("Index", index), y: .value("Value", value))
                                .foregroundStyle(getColor(value: value).gradient)
                        }
                    }
                    .chartLegend(position: .topLeading, alignment: .top, spacing: 10){
                        Text("Bar Chart").foregroundColor(Color.green)
                    }
                    //            .chartOverlay(alignment: .topLeading, content: {_ in
                    //                Text("Bar Chart")
                    //            })
                    .chartXAxis(.hidden)
                    .chartYAxis(.hidden)
                    .padding()
                    .frame(width: UIScreen.main.bounds.width*0.45, height: UIScreen.main.bounds.height*0.3)
                    .background(.ultraThinMaterial)
                    .cornerRadius(20)
                    .shadow(radius: 20)
                    
                    Chart {
                        ForEach(Array(ChartArr.enumerated()), id: \.0) { index, value in
                            PointMark(x: .value("Index", index), y: .value("Value", value))
                                .foregroundStyle(getColor(value: value).gradient)
                        }
                    }
                    .chartXAxis(.hidden)
                    .chartYAxis(.hidden)
                    .padding()
                    .frame(width: UIScreen.main.bounds.width*0.45, height: UIScreen.main.bounds.height*0.3)
                    .background(.ultraThinMaterial)
                    .cornerRadius(20)
                    .shadow(radius: 20)
                }
                
                GridRow {
                    Chart {
                        ForEach(Array(ChartArr.enumerated()), id: \.0) { index, value in
                            LineMark(x: .value("Index", index), y: .value("Value", value))
                                .foregroundStyle(getColor(value: value).opacity(0.1).gradient)
//                                .interpolationMethod(catmullRom)
                        }
                    }
                    .chartXAxis(.hidden)
                    .chartYAxis(.hidden)
                    .padding()
                    .frame(width: UIScreen.main.bounds.width*0.45, height: UIScreen.main.bounds.height*0.3)
                    .background(.ultraThinMaterial)
                    .cornerRadius(20)
                    .shadow(radius: 20)
                    
                    Chart {
                        ForEach(Array(ChartArr.enumerated()), id: \.0) { index, value in
                            AreaMark(x: .value("Index", index), y: .value("Value", value))
                                .foregroundStyle(getColor(value: value).gradient)
                        }
                    }
                    .chartXAxis(.hidden)
                    .chartYAxis(.hidden)
                    .padding()
                    .frame(width: UIScreen.main.bounds.width*0.45, height: UIScreen.main.bounds.height*0.3)
                    .background(.ultraThinMaterial)
                    .cornerRadius(20)
                    .shadow(radius: 20)
                }
            }
            Spacer()
            HStack {
                Button(action: {
                    funcStop = false
                    let count = ChartArr.count
                    ChartArr.removeAll()
                    for _ in 0..<count {
                        ChartArr.append(.random(in: 1...30))
                    }
                }, label: {
                    VStack {
                        Image(systemName: "arrow.counterclockwise")
                            .renderingMode(.original)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 15, height: 15)
                        Text("Refresh array")
                            .font(.system(size: 7, weight: .light, design: .default))
                            .foregroundColor(Color.red)
                    }
                    .frame(width: 40, height: 40)
                })
//                .padding(.trailing, 30)
//                .padding(.leading, -20)
                
                Picker("Choose sort type", selection: $selectedSortType) {
                    ForEach(SortType.allCases, id: \.self) { type in
                        Text(type.rawValue).tag("")
                            .font(.system(size: 8, weight: .light, design: .default))
                    }
                }
                
                Button(action: {
                    Task {
                        try await bubbleSort()
                    }
                }, label: {
                    Text("Sort array")
                })
                .padding()
                .disabled(funcStop ? true : false)
                
                Button(action: {
                    funcStop = true
                }, label: {
                    Image(systemName: "pause.circle")
                })
                
                Button(action: {
                    funcStop = false
                    Task {
                        try await bubbleSort()
                    }
                }, label: {
                    Image(systemName: "play.circle")
                })
            }
            .frame(width: UIScreen.main.bounds.width*0.9, height: UIScreen.main.bounds.height*0.07)
            .background(.ultraThinMaterial)
            .cornerRadius(20)
            .shadow(radius: 20)
        }
    }
    func getColor(value: Float) -> Color {
//        if value.truncatingRemainder(dividingBy: 2.0) == 0 {
//            return .green
//        }else if value.truncatingRemainder(dividingBy: 2.0) != 0 {
//            return .yellow
//        }
        if value == previous_value {
            return .green
        }else if value == current_value {
            return Color(
                hue: 0.12, saturation: 0.9, brightness: 1, opacity: 0.7
            )
        }
        return .blue
    }
    
    func bubbleSort() async throws {
        for j in stride(from: 1, to: ChartArr.count, by: 1) {
            for i in stride(from: 0, to: j, by: 1) {
                if !funcStop {
                    previous_value = ChartArr[i]
                    current_value = ChartArr[j]
                    if ChartArr[j] < ChartArr[i] {
                        ChartArr.swapAt(j, i)
                        try await Task.sleep(until: .now.advanced(by: .milliseconds(50)), clock: .continuous)
                    }
                }
                else {
                    break
                }
            }
        }
    }
}

struct ChartView_Previews: PreviewProvider {
    static var previews: some View {
        ChartView()
    }
}
