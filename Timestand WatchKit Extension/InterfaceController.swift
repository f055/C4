import WatchKit
import Foundation

class InterfaceController: WKInterfaceController {
    @IBOutlet var itLabel: WKInterfaceLabel!
    @IBOutlet var isLabel: WKInterfaceLabel!
    @IBOutlet var halfLabel: WKInterfaceLabel!
    @IBOutlet var tenMinutesLabel: WKInterfaceLabel!
    @IBOutlet var quarterLabel: WKInterfaceLabel!
    @IBOutlet var twentyLabel: WKInterfaceLabel!
    @IBOutlet var fiveMinutesLabel: WKInterfaceLabel!
    @IBOutlet var minutesLabel: WKInterfaceLabel!
    @IBOutlet var toLabel: WKInterfaceLabel!
    @IBOutlet var pastLabel: WKInterfaceLabel!
    @IBOutlet var oneLabel: WKInterfaceLabel!
    @IBOutlet var threeLabel: WKInterfaceLabel!
    @IBOutlet var twoLabel: WKInterfaceLabel!
    @IBOutlet var fourLabel: WKInterfaceLabel!
    @IBOutlet var fiveHourLabel: WKInterfaceLabel!
    @IBOutlet var sixLabel: WKInterfaceLabel!
    @IBOutlet var sevenLabel: WKInterfaceLabel!
    @IBOutlet var eightLabel: WKInterfaceLabel!
    @IBOutlet var nineLabel: WKInterfaceLabel!
    @IBOutlet var tenHourLabel: WKInterfaceLabel!
    @IBOutlet var elevenLabel: WKInterfaceLabel!
    @IBOutlet var twelveLabel: WKInterfaceLabel!
    @IBOutlet var oclockLabel: WKInterfaceLabel!

    let onColor = UIColor.white
    let offColor = UIColor.darkGray

    var updateTimer: Timer?
    var labelProvider: LabelProvider?
    
    override init() {
        super.init()
    }

    override func awake(withContext context: Any?) {
        super.awake(withContext: context)

        let labels = NaturalTimeLabels(
            itLabel: itLabel,
            isLabel: isLabel,
            halfLabel: halfLabel,
            tenMinutesLabel: tenMinutesLabel,
            quarterLabel: quarterLabel,
            twentyLabel: twentyLabel,
            fiveMinutesLabel: fiveMinutesLabel,
            minutesLabel: minutesLabel,
            toLabel: toLabel,
            pastLabel: pastLabel,
            oneLabel: oneLabel,
            threeLabel: threeLabel,
            twoLabel: twoLabel,
            fourLabel: fourLabel,
            fiveHourLabel: fiveHourLabel,
            sixLabel: sixLabel,
            sevenLabel: sevenLabel,
            eightLabel: eightLabel,
            nineLabel: nineLabel,
            tenHourLabel: tenHourLabel,
            elevenLabel: elevenLabel,
            twelveLabel: twelveLabel,
            oclockLabel: oclockLabel
        )

        self.labelProvider = LabelProvider(labels: labels, onColor: UIColor.white, offColor: UIColor.darkGray)
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()

        startUpdating()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()

        stopUpdating()
    }

    func startUpdating() {
        showCurrentTime()

        let now = Date()
        var components = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: now)
        components.minute = (components.minute ?? 0) + 1
        components.second = 0
        let fireDate = Calendar.current.date(from: components)
        
        updateTimer = Timer(fireAt: fireDate!, interval: 60.0, target: self, selector: #selector(showCurrentTime), userInfo: nil, repeats: true)
        RunLoop.main.add(updateTimer!, forMode: .default)
    }

    func stopUpdating() {
        updateTimer?.invalidate()
    }

    @objc func showCurrentTime() {
        let flags: Set<Calendar.Component> = [.hour, .minute]
        let now = Date()
        let components = Calendar.autoupdatingCurrent.dateComponents(flags, from: now)

        labelProvider?.showTime(hour: components.hour ?? 0, minute: components.minute ?? 0)
    }
}
