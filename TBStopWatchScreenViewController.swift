//
//  TBStopWatchScreenViewController.swift
//  TimerBox
//
//

import UIKit

class TBStopWatchScreenViewController: UIViewController, timerProtocol, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var btnStartLap: UIButton!
    @IBOutlet var btnLap: UIButton!
    @IBOutlet var btnClear: UIButton!
    @IBOutlet var lblTotal: UILabel!
    @IBOutlet var lblLap: UILabel!
    @IBOutlet var tblLaps: UITableView!

    var stopWatchTimer : NSTimer?
    var stopWatchTotalStart = Double(0)
    var stopWatchLapStart = Double(0)
    var stopWatchTotal = Double(0)
    var stopWatchLap = Double(0)
    var singleton = TBSingleton()

    var lapsDic = NSMutableDictionary()
    
    let textCellIdentifier = "cell"
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder);
        
    }
    
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil);
        
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func isActive(){
        
        print(NSStringFromClass(self.dynamicType))
        
    }

    func goBackground(){
        
    }
    
    
    override func viewDidAppear(animated: Bool) {
        
        let nib = UINib(nibName: "TBLapTableViewCell", bundle: nil)
        tblLaps.registerNib(nib, forCellReuseIdentifier:textCellIdentifier)

        initScreen()
        
    }

    
    func initScreen(){
    
        lblLap.text = "00 : 00"
        lblTotal.text = "00 : 00"
    
    }
    

    @IBAction func btnStartLapTapped(sender: UIButton){

        stopWatchLapStart = NSDate().timeIntervalSince1970
        stopWatchTotalStart = NSDate().timeIntervalSince1970
        
        stopWatchTimer = NSTimer.scheduledTimerWithTimeInterval(0.12, target: self, selector: "drawStopWatchValue", userInfo: nil, repeats: true)

        lockButtons()
        
    }
    
    @IBAction func btnLapTapped(sender: UIButton){
        
        stopWatchLapStart = NSDate().timeIntervalSince1970
        
        let lap = NSMutableDictionary()
        
        let lapNo = String(lapsDic.allKeys.count + 1)

        lap.setValue(lapNo, forKey: "lapNo")
        lap.setValue(String(lblLap.text!), forKey: "lapTime")
        lap.setValue(String(lblTotal.text!), forKey: "totalTime")
        
        lapsDic.setObject(lap, forKey: lapNo)
        
        tblLaps.reloadData()
        
        let indexPathLocal = NSIndexPath(forRow: lapsDic.allKeys.count-1, inSection: 0)
        self.tblLaps.scrollToRowAtIndexPath(indexPathLocal, atScrollPosition: UITableViewScrollPosition.Middle, animated: true)
        
    }

    @IBAction func btnClearTapped(sender: UIButton){

        if (stopWatchTimer?.valid == true){
        
            stopWatchTimer?.invalidate()
            
            stopWatchTotalStart = Double(0)
            stopWatchLapStart = Double(0)
            
            lockButtons()
            
            initScreen()
            
        }
        
    }
    
    func lockButtons(){
    
        if (stopWatchTimer?.valid == true){
            
            btnStartLap.enabled = false
            btnStartLap.alpha = 0.7

            
        }else{
            
            btnStartLap.enabled = true
            btnStartLap.alpha = 1
            
        }
    
    }
    
    
    func drawStopWatchValue(){
    
        stopWatchTotal = NSDate().timeIntervalSince1970 - stopWatchTotalStart
        stopWatchLap = NSDate().timeIntervalSince1970 - stopWatchLapStart
        
        print("stopWatchTotal \(stopWatchTotal)")
        
        lblTotal.text = singleton.formatIntervalNano(stopWatchTotal)
        lblLap.text = singleton.formatIntervalNano(stopWatchLap)
    
        var timeLeftTotal = singleton.dateToArray(Double(stopWatchTotal))
        var timeLeftLap = singleton.dateToArray(Double(stopWatchLap))

        var fontSizeTotal:CGFloat?
        
        for x in (timeLeftTotal.count - 1).stride(through: 1, by: -1) {
            
            if (timeLeftTotal[x] == 0){
                
                timeLeftTotal.removeAtIndex(x)
                
            }else{
                break;
            }
            
        }
        
        switch(timeLeftTotal.count){
        case 0:
            fontSizeTotal = 48.0
        case 1:
            fontSizeTotal = 48.0
        case 2:
            fontSizeTotal = 48.0
        case 3:
            fontSizeTotal = 36.0
        case 4:
            fontSizeTotal = 30.0
        case 5:
            fontSizeTotal = 24.0
        case 6:
            fontSizeTotal = 20.0
        default:
            fontSizeTotal = 16.0
        }
        
        lblTotal.font = UIFont(name: "HelveticaNeue", size: fontSizeTotal!)

        print("font size \(fontSizeTotal)")
        
        var fontSizeLap:CGFloat?
        
        for x in (timeLeftLap.count - 1).stride(through: 1, by: -1) {
            
            if (timeLeftLap[x] == 0){
                
                timeLeftLap.removeAtIndex(x)
                
            }else{
                break;
            }
            
        }

        switch(timeLeftLap.count){
        case 0:
            fontSizeLap = 48.0
        case 1:
            fontSizeLap = 48.0
        case 2:
            fontSizeLap = 48.0
        case 3:
            fontSizeLap = 36.0
        case 4:
            fontSizeLap = 30.0
        case 5:
            fontSizeLap = 24.0
        case 6:
            fontSizeLap = 20.0
        default:
            fontSizeLap = 16.0
        }
        
        print("font size \(fontSizeTotal)")

        lblLap.font = UIFont(name: "HelveticaNeue", size: fontSizeLap!)
        
    }
    
    
    func curValue() {
        
//        let curDate = NSDate()
//        
//        let calendar = NSCalendar.currentCalendar()
//        
//        let dateComponents = calendar.components([NSCalendarUnit.Minute, NSCalendarUnit.Second, NSCalendarUnit.Nanosecond], fromDate: curDate)
//        
//        print("minutes: \(dateComponents.minute) seconds: \(dateComponents.second) nanoseconds: \(dateComponents.nanosecond)")
//        
//        let interval = curDate.timeIntervalSince1970 - prevInterval
//        
//        print("seconds from 1970: \(curDate) interval: \(interval) ceil interval: \(ceil(interval))")
//        
//        let intInterval = Int(interval)
//        
//        print("int interval: \(intInterval)")
//        
//        
//        prevInterval = curDate.timeIntervalSince1970
        
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        return 69.0
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let laps = lapsDic.allKeys.count
        
        return laps
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tblLaps.dequeueReusableCellWithIdentifier(textCellIdentifier, forIndexPath: indexPath) as! TBLapTableViewCell
        
        let indexKey = String(indexPath.row + 1)
        let dataDic =  lapsDic.objectForKey(indexKey) as! NSDictionary
        
        let lapTime = dataDic.valueForKey("lapTime") as! String
        let totalTime = dataDic.valueForKey("totalTime") as! String
        let lapNo = dataDic.valueForKey("lapNo") as! String
        
        cell.lapTime?.text = lapTime
        cell.totalTime?.text = totalTime
        cell.lapText?.text = "lap# \(lapNo)";
        
        return cell
    }
    
    
}
