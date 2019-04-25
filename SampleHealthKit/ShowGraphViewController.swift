//
//  ShowGraphViewController.swift
//  SampleHealthKit
//
//  Created by Yamada, Masaya on 4/25/19.
//  Copyright © 2019 Yamada, Masaya. All rights reserved.
//

import UIKit
import Charts

class ShowGraphViewController: UIViewController{

    // ここに棒グラフを描きます
    @IBOutlet var chartView: BarChartView!
    
    var number1:Double = 3.0
    var number2:Double = 6.0
    var number3:Double = 1.0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        horizontalBarChartUpdate()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    func horizontalBarChartUpdate() {
        
        // Basic set up of plan chart
        let entry1 = BarChartDataEntry(x: 1.0, y: number1)
        let entry2 = BarChartDataEntry(x: 2.0, y: number2)
        let entry3 = BarChartDataEntry(x: 3.0, y: number3)
        let dataSet = BarChartDataSet(values: [entry1, entry2, entry3], label: "Widgets Type")
        let data = BarChartData(dataSets: [dataSet])
        barChart.data = data
        
        // Color
        dataSet.colors = ChartColorTemplates.vordiplom()
        
    }
    

    
}
