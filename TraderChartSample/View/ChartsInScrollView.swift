import SwiftUI
import TraderChart

struct ChartsInScrollView: View {
    
    @State var chartViews: [TraderChartView] = (0..<3).map { _ in TraderChartView() }

    @State var turningPointsList: [[TurningPointCalculator.PointData]?] = []

    var chartData: [ChartData] = (0..<3).map { _ in ChartData.dummy() }

    init() {
        chartViews.enumerated().forEach { offset, chartView in
            chartView.setData(chartData[offset])
            initChart(chartView: chartView)
            
//            chartView.xAxis.indexOf(point: <#T##CGPoint#>, scrollOffset: chartView.scrollOffset)
        }
        turningPointsList = chartViews.map {
            $0.turningPoint.results?.points
        }
    }

    var body: some View {
        VStack {
            ForEach(Array(chartViews.enumerated()), id: \.offset) { index, chartView in
                TraderChartUI(chartView: chartView)
                    .frame(maxHeight: .infinity)
            }
        }
    }

    func test(index: Int) {
        let points = turningPointsList.indices.contains(index) ? turningPointsList[index] : nil
        guard let points else { return }
        
        points.map { point in
            let chartView = chartViews[index]
            point.index
            chartView.xAxis.indexOf(point: $0, scrollOffset: chartView.scrollOffset)
        }
    }

    func initChart(chartView: TraderChartView) {
        var colorConfig = ColorConfig()
        colorConfig["background"] = UIColor.black
        chartView.colorConfig = colorConfig
        chartView.mainGraphArea.yAxis.designatedDecimalLength = 3
    }
}

#Preview {
    ChartsInScrollView()
}
