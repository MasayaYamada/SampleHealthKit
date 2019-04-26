//
//  ShowGraphViewController.swift
//  SampleHealthKit
//
//  Created by Yamada, Masaya on 4/25/19.
//  Copyright © 2019 Yamada, Masaya. All rights reserved.
//

import UIKit
import Charts

class ShowGraphViewController: UIViewController {

    // ここに棒グラフを描きます
    @IBOutlet weak var horizontalBarChart: HorizontalBarChartView!
    
    // 歩数受け取り用変数
    var getStepToday: Double?
    
    // テストデータ
    let testData = 1200.0

    override func viewDidLoad() {
        super.viewDidLoad()
        horizontaBarChartUpdate()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func horizontaBarChartUpdate () {
        
        // 基本的なチャートの書き方
        if getStepToday == nil {
            getStepToday = 0.0
        }
        
        // データの挿入
        let entry1 = BarChartDataEntry(x: 1.0, y: getStepToday!)
        let entry2 = BarChartDataEntry(x: 2.0, y: testData)
        //データのセット
        let dataSet = BarChartDataSet(values: [entry1, entry2], label: "Sample Show Case")
        let data = BarChartData(dataSets: [dataSet])
        // チャートの表示
        horizontalBarChart.data = data
        // Color の設定
        dataSet.colors = ChartColorTemplates.vordiplom()
    }
    
    
}
