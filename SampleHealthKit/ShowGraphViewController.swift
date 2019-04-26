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
    
    // 各ラインのテスト値
    var number1 = 2.0
    var number2 = 4.0
    var number3 = 12.0
    
    @IBAction func renderCharts() {
        horizontaBarChartUpdate()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        horizontaBarChartUpdate()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func horizontaBarChartUpdate () {
        
        // Basic set up of plan chart
        let entry1 = BarChartDataEntry(x: 1.0, y: getStepToday!)
        let entry2 = BarChartDataEntry(x: 2.0, y: number2)
        let entry3 = BarChartDataEntry(x: 3.0, y: number3)
        let dataSet = BarChartDataSet(values: [entry1, entry2, entry3], label: "Widgets Type")
        let data = BarChartData(dataSets: [dataSet])
        horizontalBarChart.data = data
        
        // Color
        dataSet.colors = ChartColorTemplates.vordiplom()
        
        // Refresh chart with new data
        horizontalBarChart.notifyDataSetChanged()
    }
    
    
}
