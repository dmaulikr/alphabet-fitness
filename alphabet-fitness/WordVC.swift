//
//  WordVC.swift
//  alphabet-fitness
//
//  Created by Kath Faulkner on 28/12/2015.
//  Copyright © 2015 T3D. All rights reserved.
//

import UIKit

class WordVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var workoutTitleLbl: UILabel!
    @IBOutlet weak var workoutTimeLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.contentInset = UIEdgeInsetsMake(45, 0, 0, 0)
        
        workoutTitleLbl.text = ExerciseManager.instance.workoutWord.uppercaseString
        workoutTimeLbl.text = ExerciseManager.instance.getWorkoutTime()
    
        let swipeRight = UISwipeGestureRecognizer(target: self, action: "respondToSwipeGesture:")
        swipeRight.direction = UISwipeGestureRecognizerDirection.Right
        self.view.addGestureRecognizer(swipeRight)
    }
    
    func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            switch swipeGesture.direction {
            case UISwipeGestureRecognizerDirection.Right:
                backBtnPressed()
            default: break
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func backBtnPressed() {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    @IBAction func startBtnPressed() {
        goToExercise(0)
    }
    
    func goToExercise(workoutPos: Int) {
        ExerciseManager.instance.setWorkoutPosition(workoutPos)
        performSegueWithIdentifier("ExerciseViewList", sender: self)
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCellWithIdentifier("ExerciseCell") as? ExerciseCell {
            cell.configureCell(ExerciseManager.instance.currentWorkout[indexPath.row])
            return cell
            
        } else {
            return ExerciseCell()
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ExerciseManager.instance.currentWorkout.count
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        goToExercise(indexPath.row)
    }

}
