//
//  ViewController.swift
//  SampleHealthKit
//
//  Created by Yamada, Masaya on 4/24/19.
//  Copyright © 2019 Yamada, Masaya. All rights reserved.
//

import UIKit
import HealthKit

class ViewController: UIViewController {
    
    // インスタンス生成
    let healthStore = HKHealthStore()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func healthAccess(_ sender: Any) {
        
        // 各種データの読み込み
        let healthKitTypes: Set = [
            // access heartrate data
            HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.heartRate)!,
            // access walking/running data
            HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.distanceWalkingRunning)!,
            // access step count
            HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.stepCount)!
        ]
        
        healthStore.requestAuthorization(toShare: healthKitTypes, read: healthKitTypes){(_, _) in
            print("ahturised??")
        }
        
        healthStore.requestAuthorization(toShare: healthKitTypes, read: healthKitTypes) {(bool, error) in
            if let e = error {
                print("oops something went wrong during authorisation \(e.localizedDescription)")
            } else {
                print("User has completed the authorisation flow")
            }
        }
    }
    
    // 今日の歩数を取得するための関数
    func getTodaysSteps(completion: @escaping (Double) -> Void){
        
        // Returns the shared quantity type for the provided identifier.
        // 識別したデータを取得するために定義する。
        let stepsQuantityType = HKQuantityType.quantityType(forIdentifier: .stepCount)!
        
        let now = Date()
        // スタート日付を設定する。
        let startOfDay = Calendar.current.startOfDay(for: now)
        
        // Returns a predicate for samples whose start and end dates fall within the specified time interval.
        // 始めと終わりの日付を指定して、時間間隔内にあるサンプルのを返す。
        let predicate = HKQuery.predicateForSamples(withStart: startOfDay, end: now, options: .strictStartDate)
        
        // A query that performs statistical calculations over a set of matching quantity samples, and returns the results.
        // マッチしたサンプル結果を返すクエリ。
        // execute して結果を取得する。
        let query = HKStatisticsQuery(quantityType: stepsQuantityType, quantitySamplePredicate: predicate, options: .cumulativeSum) {
            (_, result, error) in
            var resultCount = 0.0
            guard let result = result else {
                print("Failed to fetch steps rate")
                completion(resultCount)
                return
            }
            
            if let sum = result.sumQuantity() {
                resultCount = sum.doubleValue(for: HKUnit.count())
                print("resultCount \(resultCount)")
            }
            
            DispatchQueue.main.async {
                completion(resultCount)
            }
            
          }
        //クエリの実行
        healthStore.execute(query)
        
    }
    
    @IBOutlet weak var totalSteps: UILabel!
    
    // 歩数の結果表示関数
    @IBAction func getSteps(_ sender: Any) {
        getTodaysSteps {
            (result) in
            print("\(result)")
            DispatchQueue.main.async {
                self.totalSteps.text = "\(result)"
            }
        }
    }
    
}

