import SwiftUI
import TraderChart

struct ChartsInScrollView: View {
    
    @State var chartViews: [TraderChartView] = (0..<3).map { _ in TraderChartView() }

    var chartData: [ChartData] = (0..<3).map { _ in ChartData.dummy() }

    init() {
        chartViews.enumerated().forEach { offset, chartView in
            chartView.setData(chartData[offset])
            initChart(chartView: chartView)
        }
    }

    var body: some View {
        ScrollView {
            ForEach(Array(chartViews.enumerated()), id: \.offset) { index, chartView in
                TraderChartUI(chartView: chartView)
                    .frame(height: 200)
            }
        }
    }
    
    func initChart(chartView: TraderChartView) {
        var colorConfig = ColorConfig()
        colorConfig["background"] = UIColor.black
        chartView.colorConfig = colorConfig
    }
}

#Preview {
    ChartsInScrollView()
}
