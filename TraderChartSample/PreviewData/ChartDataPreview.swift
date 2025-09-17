import Foundation
import TraderChart

extension ChartData {

    static func dummy() -> ChartData{
        // チャートのダミーデータを生成
        var timeList: [String] = []
        var openList: [CGFloat?] = []
        var highList: [CGFloat?] = []
        var lowList: [CGFloat?] = []
        var closeList: [CGFloat?] = []
        
        var currentPrice = 100.0
        var trendDrift = 0.0 // ゆるいトレンド用ドリフト
        
        for i in 1...100 {
            timeList.append("\(i)")
            
            // 緩やかなトレンドをランダムウォークで生成（たまに方向転換）
            if Double.random(in: 0...1) < 0.15 { // 方向転換イベント
                trendDrift = Double.random(in: -0.4...0.4)
            }
            
            let open = currentPrice
            
            // ボラティリティを少し抑えつつレコード間の差は以前よりやや拡大
            // ベースボラ: 0.3〜1.2, たまにスパイク
            var baseVol = Double.random(in: 0.3...1.2)
            if Double.random(in: 0...1) < 0.1 { // スパイク
                baseVol *= Double.random(in: 1.5...2.2)
            }
            
            // 次の終値方向: トレンド + ランダム
            let directionComponent = trendDrift + Double.random(in: -0.9...0.9)
            
            // 終値: ベースボラ * 0.6 で従来より低め、ただしトレンド分を織り込む
            let close = open + directionComponent * baseVol * 0.6
            
            // ヒゲ幅（前回よりやや拡大＋たまに長いスパイクヒゲ）
            let bodyRange = abs(close - open)
            var wickRatio = Double.random(in: 0.4...0.9) // ボディ比率を拡大
            if Double.random(in: 0...1) < 0.12 { // ロングウィックイベント
                wickRatio *= Double.random(in: 1.2...1.8)
            }
            let minWick = Double.random(in: 0.12...0.26) // 最低幅も少し上げる
            let wickSize = max(bodyRange * wickRatio, minWick)
            
            // 上下ヒゲのバランス（少し極端な偏りも許容）
            let upperShare = Double.random(in: 0.2...0.8)
            let lowerShare = 1.0 - upperShare
            
            let high = max(open, close) + wickSize * upperShare
            let low = min(open, close) - wickSize * lowerShare
            
            openList.append(CGFloat(open))
            highList.append(CGFloat(high))
            lowList.append(CGFloat(low))
            closeList.append(CGFloat(close))
            
            // 次のレコードの開始価格: 多少ギャップ（小さめ）を入れる
            let gap = Double.random(in: -0.15...0.15)
            currentPrice = close + gap
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
