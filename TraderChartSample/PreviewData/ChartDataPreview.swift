import Foundation
import TraderChart

extension ChartData {

    static func dummy() -> ChartData{
        // 50レコードのダミーデータを生成
        var timeList: [String] = []
        var openList: [CGFloat?] = []
        var highList: [CGFloat?] = []
        var lowList: [CGFloat?] = []
        var closeList: [CGFloat?] = []
        
        var currentPrice = 100.0
        
        for i in 1...50 {
            timeList.append("\(i)")
            
            let open = currentPrice
            let volatility = Double.random(in: 0.5...3.0) // ボラティリティ
            let direction = Double.random(in: -1...1) // 方向性
            
            let high = open + volatility
            let low = open - volatility
            let close = open + (direction * volatility * 0.7)
            
            openList.append(CGFloat(open))
            highList.append(CGFloat(high))
            lowList.append(CGFloat(low))
            closeList.append(CGFloat(close))
            
            currentPrice = close // 次のローソクの開始価格
        }
        
        let data = TraderChart.ChartData(
            timeList: timeList,
            openList: openList,
            highList: highList,
            lowList: lowList,
            closeList: closeList
        )
        return data
    }
}
