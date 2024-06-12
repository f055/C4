import UIKit

class ViewController: UIViewController {
    @IBOutlet var itLabel: UILabel!
    @IBOutlet var isLabel: UILabel!
    @IBOutlet var halfLabel: UILabel!
    @IBOutlet var tenMinutesLabel: UILabel!
    @IBOutlet var quarterLabel: UILabel!
    @IBOutlet var twentyLabel: UILabel!
    @IBOutlet var fiveMinutesLabel: UILabel!
    @IBOutlet var minutesLabel: UILabel!
    @IBOutlet var toLabel: UILabel!
    @IBOutlet var pastLabel: UILabel!
    @IBOutlet var oneLabel: UILabel!
    @IBOutlet var threeLabel: UILabel!
    @IBOutlet var twoLabel: UILabel!
    @IBOutlet var fourLabel: UILabel!
    @IBOutlet var fiveHourLabel: UILabel!
    @IBOutlet var sixLabel: UILabel!
    @IBOutlet var sevenLabel: UILabel!
    @IBOutlet var eightLabel: UILabel!
    @IBOutlet var nineLabel: UILabel!
    @IBOutlet var tenHourLabel: UILabel!
    @IBOutlet var elevenLabel: UILabel!
    @IBOutlet var twelveLabel: UILabel!
    @IBOutlet var oclockLabel: UILabel!

    let onColor = UIColor.white
    let offColor = UIColor.darkGray

    var updateTimer: Timer?
    var labelProvider: LabelProvider?

    override func viewDidLoad() {
        super.viewDidLoad()

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

        labelProvider = LabelProvider(labels: labels, onColor: UIColor.white, offColor: UIColor.darkGray)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        startUpdating()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)

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
