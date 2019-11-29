//
//  ViewController.swift
//  KB_advent2018_day1
//
//  Created by Kangyoon Bae on 11/27/19.
//  Copyright © 2019 appforcivil. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    //UI components
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblMessage: UILabel!
    @IBOutlet weak var pbLoading: UIActivityIndicatorView!
    
    @IBOutlet weak var lblFirstDup: UILabel!
    @IBOutlet weak var lblFinal: UILabel!
    @IBOutlet weak var btnCalibrate: UIButton!
    
    //Input Data Array
    var arrayOfFrequencychanges:Array<Any> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    
        
        //Simulating a slow network/big data loading condition
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0, execute: {
            self.loadFrequencyDataFromURL()
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func btnCalibrateClicked(_ sender: Any) {
        //Call calculateFinalFrequency and update UI
        lblFinal.text = "Final frequency  \n\(calculateFinalFrequency(changeOfFrequencyArray: arrayOfFrequencychanges as! Array<String>))"
        
        //Call findFirstDuplicatedFrequency and update UI
        lblFirstDup.text = "First duplicated frequency \n\(findFirstDuplicatedFrequency(changeOfFrequencyArray: arrayOfFrequencychanges as! Array<String>))"
        setMessage(message: "Calibration Completed!")
        
    }
    
    
    
    /**
     Load frequency data (raw input) from URL
     Then call formattedFrequencychanges
     */
    func loadFrequencyDataFromURL(){        
        
        //Load Input from URL
        let myURL = Bundle.main.object(forInfoDictionaryKey: "DataInput_URL") as! String
        
        //If URL is Valid
        if let url = URL(string: myURL) {
            do {
                //Read raw input from URL
                let rawInputFromURL = try String(contentsOf: url)
                //Print rawInputFromURL to see
                //print(rawInputFromURL)
               
                //Call formattedFrequencychanges
                formattedFrequencychanges(rawInput: rawInputFromURL)
            } catch let error{
                //Contents could not be loaded
                //print("Error: \(error)")
                setMessage(message: "Error: \(error)")
                hideLoadingProgressBar()
            }
        } else {
            //Not valid URL!
            //print("Error: \(myURL) is a not a valid URL")
            setMessage(message: "Error: \(myURL) is a not a valid URL")
            hideLoadingProgressBar()
        }
    }
    
    
    /**
     Create an Array from fequency changes raw input
     */
    func formattedFrequencychanges(rawInput:String){
        //Seperate string by newline and put them into an Array
        arrayOfFrequencychanges = rawInput.components(separatedBy: .newlines)
        
        //Remove last object from Array (which is empty string object)
        arrayOfFrequencychanges.removeLast()
        
        hideLoadingProgressBar()
        setMessage(message: "Data loading completed")
    }
    
    
    
    
    /**
    Calculate final frequency based frequency changes
    - Parameter changeOfFrequencyArray: given frequency changes
    */
    func calculateFinalFrequency(changeOfFrequencyArray:Array<String>) ->Int{
        //Start with 0
        var currentFrequency = 0

        //Loop through changeOfFrequencyArray
        for changeOfFrequency in changeOfFrequencyArray{
            //print("Frequency \(currentFrequency) apply changes \(changeOfFrequency) =>")
            
            //Sum change to current
            currentFrequency += Int(changeOfFrequency)!
            
            //print("Updated frequency \(currentFrequency)\n")
        }
        
        //Result
        print("Final frequency : \(currentFrequency)")
        return currentFrequency

    }

    
    /**
     Find the first duplicated frequency
     - Parameter changeOfFrequencyArray: given Frequency changes
     - Returns: Final frequency value.
     */
    func findFirstDuplicatedFrequency(changeOfFrequencyArray:Array<String>) ->Int{
        //Start with 0
        var currentFrequency = 0
        
        //Set searching n(1) is faster than Array n(0) and we don't need Dictionary(Map)
        var setOfFrequency:Set = [0]
        
        //Variable for result
        var firstDuplicatedFrequency:Int? = nil
        

        //While condition to continue
        while firstDuplicatedFrequency == nil{
            
            //Loop through this is duplicate code block from previous part however, merging two function might be breaking SRP (although this break DRY)
            for changeOfFrequency in changeOfFrequencyArray{
                currentFrequency += Int(changeOfFrequency)!
                
                //Check duplicated frequency
                if setOfFrequency.contains(currentFrequency){
                    //Set result value
                    firstDuplicatedFrequency = currentFrequency
                    //Exit loop
                    break
                }
                //Adding currentFrequency to setOfFrequency
                setOfFrequency.insert(currentFrequency)
            }
            //print("Start new cycle")
        }
        
        //Print result
        print("First duplicated frequency \(firstDuplicatedFrequency!)")
        
        return firstDuplicatedFrequency!
    }
    
    
    //Set message label
    func setMessage(message:String){
        lblMessage.pushTransition(0.3)
        lblMessage.text = message
        lblMessage.isHidden = false
    }
    
    
    //Show loading progress bar
    func showLoadingProgressBar(){
        pbLoading.isHidden = false
    }
    
    
    //Hide loading progress bar
    func hideLoadingProgressBar(){
        pbLoading.stopAnimating()
        pbLoading.isHidden = true
    }

}


//Extension for Animation simple animation
extension UIView {
    func pushTransition(_ duration:CFTimeInterval) {
        let animation:CATransition = CATransition()
        animation.timingFunction = CAMediaTimingFunction(name:
            kCAMediaTimingFunctionEaseInEaseOut)
        animation.type = kCATransitionPush
        animation.subtype = kCATransitionFromTop
        animation.duration = duration
        layer.add(animation, forKey: kCATransitionPush)
    }
}









