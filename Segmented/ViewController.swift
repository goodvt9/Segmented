//
//  ViewController.swift
//  Segmented
//
//  Created by vt9 on 2023/7/26.
//

import UIKit

class ViewController: UIViewController {
    
    let debug = false
    var nowHHmm: Int = 0 //現在時間
    var nowIdx: Int = -1 //現在index
    var selectedIdx: Int = -1 //選擇的 index
    let waveName = "audioWave-" //gif 檔名
    let waveLocation = CGRect(x: 181, y: 127, width: 30 , height:30)
    let defaultTime = Int(2359) //預設時間
    let textContainerInset = UIEdgeInsets.init(top: 10, left: 10, bottom: 10, right: 10) // text padding
    
    //背景圖檔名
    let imageNameArr: [String] = ["20230722155326_copy1","20230722155326_copy2","20230722155326_copy3","20230722155326_copy4","20230722155326_copy5","20230722155326_copy6","20230722155326_copy7","20230722155326_copy8","20230722155326_copy9","20230722155326_copy10","20230722155326_copy11","20230722155326_copy12","20230722155326_copy13"]
    //節目資訊
    let infoDataArr: [[String]] =
    [
        ["台北爵士夜","沈鴻元","00:00","0200"],
        ["音樂水龍頭","劉昱沁","02:00","0700"],
        ["音樂禪","王世強","07:00","0800"],
        ["早安，愛樂","王琦","08:00","1000"],
        ["Another Story","王琦","10:00","1100"],
        ["音樂家和音樂的家","吳逸芳","11:00","1300"],
        ["音樂品味‧口耳相傳","蔣毓方","13:00","1500"],
        ["我不是一堂音樂課","節目部","15:00","1700"],
        ["音樂線上","王世強","17:00","2000"],
        ["音樂開門-「床邊音樂故事」","邱佩轝","20:00","2030"],
        ["音樂開門-「音樂少年」","邱佩轝","20:30","2100"],
        ["什麼是音樂","彭廣林","21:00","2200"],
        ["名曲輕鬆聽","節目部","22:00","2359"]
    ]
    //節目簡述
    let descArr: [String] =
    [
        "靈頓公爵說：「沒有搖擺，就沒有爵士！」\n\n菜鳥帕克說：「你若不置身其中，就無法演奏出真正的爵士！」\n\n金鐘獎主持人，「臺灣爵士一哥」沈鴻元，盡情搖擺，經典回顧！",
        "無論您是日出而作、日落而息的生活模式，或是晝伏夜出的夜貓子！就讓音樂舒緩您白天壓力過後的情緒，穩定您夜裡清醒時的思緒！",
        "行亦禪，坐亦禪，音樂讓您神往，韻律讓您超然...",
        "【戰後啟示錄】\n\n西元1945年，兩顆投下長崎與廣島的原子彈，終止了第二次世界大戰。這個事件發生的前夕與其中重要人物─奧本海默博士，不但被導演諾蘭拍成電影、引起熱議，作曲家約翰亞當斯也曾以此寫過一部歌劇「原子博士」(Doctor Atomic)。今天節目，就來聽聽音樂家回顧那個可怖年代的反思與啟示。",
        "【作曲家，寫什麼？─協奏曲】\n\n拉赫曼尼諾夫的鋼琴協奏曲、孟德爾頌的小提琴協奏曲，或是德弗札克的大提琴協奏曲…等，是否都是您喜歡的曲目呢?這些全是來自十九世紀的作品，更在今日的舞臺與錄音上頻頻出現，為何協奏曲有如此魅力？本次節目將與您分享它的來龍去脈。",
        "",
        "【四季更迭】\n\n四季的更迭，您是否也感受到了？\n義大利作曲家韋瓦第以春夏秋冬做為標題，並在每首樂曲之前標上對應的短詩，成為巴洛克時期非常有代表性的標題音樂。",
        "來自古典，進入生活，大師就在你身邊！\n\n經典曲目，獨創導聆，愛樂分享，真、善、美！\n\nClassical Total Solutions，\n\n人、曲合一，舉世無雙！",
        "【跨界？跨時代？跨文化？】\n\n莫札特身處的環境，加一點「土耳其」在音樂中調味，就可以轟動許多年！\n林姆斯基-高沙可夫身處的環境，加一點「東方」，就成為波瀾壯闊的詩篇！\n在德布西的年代，加一點「爪哇甘美朗」，就成為「神秘」和「神奇」！\n德國詩人歌德曾說：只有深刻認識另一個文化，才能更清楚自己的文化。\n很多世界音樂家似乎都在作類似的事情，讓不同文化的元素，互相融合碰撞出全新的靈感！",
        "主流流行音樂文化並無不好，但是否也應該為現在的青少年「創造另一種音樂的選擇」，而非再繼續創造「同質性的選擇」，以符合多元化社會的發展趨勢。\n\n國寶級聲優，邱佩轝邱姊姊運用「說故事」的方式，在沒有壓力的情況下，介紹古典音樂作品與時代、社會背景之間的意義，有別於學校中樂理、技法的教學，而是透過導聆的方式，從音樂欣賞出發，逐漸培養青少年對美感的欣賞能力。",
        "【作曲家：布魯克納(下)】\n\n「小時了了，大未必佳」？布魯克納自幼便展現音樂天賦，十歲就能演奏管風琴，並學習對位法理論，還曾寫過彌撒曲、七聲部的聖母頌，但為何卻遲至四十歲才創作「交響曲」？他是受誰的影響而開始譜寫管弦樂曲？",
        "【莫札特鋼琴奏鳴曲系列 NO.1】\n\n奧地利作曲家莫札特一生寫下十七首鋼琴奏鳴曲，對他來說，鋼琴是十分重要的樂器，因為從小開始，他就是透過鋼琴演奏獲得許多讚賞之外，此外，鋼琴也是他與外界的溝通工具，在他的鋼琴創作中，往往可以聽到他內心的聲音。本週音樂大夫將一一為您解讀莫札特鋼琴奏鳴曲中所隱藏的訊息！",
        "生活的發條，「鬆」一點，心靈就能，「輕」一些。\n\n聽名曲，放輕鬆…\n\n「名曲輕鬆聽」，Easy Listening，來自古典，進入生活。\n\n臺灣最沒有壓力的聲音，為您量身放送！"
    ]
    
    
    @IBOutlet weak var TitleUILabel: UILabel!
    
    @IBOutlet weak var timeUILabel: UILabel!
    
    @IBOutlet weak var ownerUILabel: UILabel!
    
    @IBOutlet weak var microphoneUIImageView: UIImageView!
    
    @IBOutlet weak var subImgUIImageView: UIImageView!
    
    @IBOutlet weak var descUITextView: UITextView!
    
    @IBOutlet weak var title123UISegmentedControl: UISegmentedControl!
    
    @IBOutlet weak var title456UISegmentedControl: UISegmentedControl!
    
    @IBOutlet weak var title789UISegmentedControl: UISegmentedControl!
    
    @IBOutlet weak var title101112UISegmentedControl: UISegmentedControl!
    
    @IBOutlet weak var title13UISegmentedControl: UISegmentedControl!
    
    @IBOutlet weak var ShowUIPageControl: UIPageControl!
    
    @IBOutlet weak var LeftUIButton: UIButton!
    
    @IBOutlet weak var RightUIButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //取得現在的時間與屬於目前哪一段節目的index
        GetCurrentTime()
        
        //online gif 動畫
        SetOnlineWave()
        
        //產生 Segment title
        GenSegmentData(kind: "genTitle")
        
        //產生畫面內容
        GenView(idx: nowIdx, type: "")
        
        //同步 index
        selectedIdx = nowIdx
        ShowUIPageControl.currentPage = nowIdx
    }
    
    
    //online gif 動畫
    func SetOnlineWave() {
        let waveView = UIImageView(frame: waveLocation)
        let animatedImage = UIImage.animatedImageNamed(waveName, duration: 1)
        waveView.image = animatedImage
        waveView.tag = 100
        view.addSubview(waveView)
    }
    
    //取得現在的時間與屬於目前哪一段節目的index
    func GetCurrentTime() {
        nowHHmm = GetNow() //現在是幾點幾分
        if debug {print("now HHmm: \(nowHHmm)")}
        
        nowIdx = GetOnLineIdx(HHmm: nowHHmm) //取出online節目的結束時間 index
        if debug {print("nowIdx: \(nowIdx)")}
    }
    
    //現在是幾點幾分
    func GetNow() -> Int {
        let now = Date.now
        let nowFormat = DateFormatter()
        nowFormat.locale = Locale(identifier: "zh")
        nowFormat.dateFormat = "HHmm"
        return Int(nowFormat.string(from: now)) ?? defaultTime //預設值2359
    }
    
    //取出online節目的結束時間 index
    func GetOnLineIdx(HHmm: Int) -> Int {
        var _nowIdx = 0
        for index in (0...infoDataArr.count-1) {
            let endTime: Int = Int(infoDataArr[index][3]) ?? defaultTime
            if HHmm < endTime {
                _nowIdx = index
                break
            }
        }
        return _nowIdx
    }
    
    //調整 textView 高度
    func UITextViewReSize(textView: UITextView) -> UITextView{
        //https://blog.csdn.net/RRJia/article/details/122907931
        let newUITextView = textView
        //預設 textView 的大小，寬度設為固定寬度，高度設為 CGFloat 的最大值
        let presetSize = CGSize(width: textView.frame.size.width, height: CGFloat.greatestFiniteMagnitude)
        //重新計算 textView 的大小
        let newSize = textView.sizeThatFits(presetSize)
        newUITextView.frame = CGRect(origin: CGPoint(x: textView.frame.origin.x, y: textView.frame.origin.y), size: CGSize(width: textView.frame.size.width, height: newSize.height))
        //更新 textView 的大小
        return newUITextView
    }
    
    //init segment
    func OffSegmentSelected() {
        let segmentArr: [UISegmentedControl] = [title123UISegmentedControl, title456UISegmentedControl, title789UISegmentedControl, title101112UISegmentedControl, title13UISegmentedControl]
        
        for idx in (0...segmentArr.count-1) {
            segmentArr[idx].selectedSegmentIndex = UISegmentedControl.noSegment
            segmentArr[idx].tintColor = UIColor.lightGray
            segmentArr[idx].setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .selected)
            segmentArr[idx].setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.systemGray], for: .normal)
        }
    }
    
    //設定 segment
    func SetSegment(segment: UISegmentedControl,dataIdx: Int, quotient: Int, kind: String) {
        
        //取得現在的時間與屬於目前哪一段節目的index
        GetCurrentTime()
        
        //取得 segment title
        if kind == "genTitle" {
            segment.setTitle(infoDataArr[dataIdx][0], forSegmentAt: quotient)
        }
        
        if debug { print("\(quotient)") }
        
        //判斷 selected
        let chkIdx = (kind == "genTitle") ? nowIdx : selectedIdx
        if dataIdx == chkIdx {
            if debug {
                print("setup")
                print("\(segment.titleForSegment(at: quotient) ?? String())")
            }
            segment.selectedSegmentIndex = quotient
            segment.selectedSegmentTintColor = UIColor.darkGray
        }
    }
    
    //讀取資料準備執行迴圈產生 Segment title
    //kind: genTitle 建立 title 名稱
    //      set 清除/建立 selected
    func GenSegmentData(kind: String) {
        OffSegmentSelected() //init segment
        for index in (0...infoDataArr.count-1) {
            let quotient = index % 3
            if index < 3 {
                if debug {print("title123UISegmentedControl idx:\(index) nowIdx:\(nowIdx) selectedIdx:\(selectedIdx)")}
                SetSegment(segment: title123UISegmentedControl, dataIdx: index, quotient: quotient, kind: kind)
            } else if index < 6 {
                if debug {print("title456UISegmentedControl idx:\(index) nowIdx:\(nowIdx) selectedIdx:\(selectedIdx)")}
                SetSegment(segment: title456UISegmentedControl, dataIdx: index, quotient: quotient, kind: kind)
            } else if index < 9 {
                if debug {print("title789UISegmentedControl idx:\(index) nowIdx:\(nowIdx) selectedIdx:\(selectedIdx)")}
                SetSegment(segment: title789UISegmentedControl, dataIdx: index, quotient: quotient, kind: kind)
            } else if index < 12 {
                if debug {print("title101112UISegmentedControl idx:\(index) nowIdx:\(nowIdx) selectedIdx:\(selectedIdx)")}
                SetSegment(segment: title101112UISegmentedControl, dataIdx: index, quotient: quotient, kind: kind)
            } else {
                if debug {print("title13UISegmentedControl idx:\(index) nowIdx:\(nowIdx) selectedIdx:\(selectedIdx)")}
                SetSegment(segment: title13UISegmentedControl, dataIdx: index, quotient: quotient, kind: kind)
            }
        }
    }
    
    //產生 View 內容
    func GenView(idx: Int, type: String) {
        //get title
        TitleUILabel.text = infoDataArr[idx][0]
        //get owner
        ownerUILabel.text = infoDataArr[idx][1]
        //get time
        timeUILabel.text = "\(infoDataArr[idx][2])-\(infoDataArr[idx][3])"
        //get image
        subImgUIImageView.image = UIImage(named: imageNameArr[idx])
        //get desc
        let _desc = descArr[idx]
        descUITextView.text = (_desc == "") ? infoDataArr[idx][0] : _desc
        //調整文字上下左右的間距
        //https://medium.com/彼得潘的-swift-ios-app-開發問題解答集/讓-uitextview-的高度等於文字內容的高度-608331d3e40c
        descUITextView.textContainerInset = textContainerInset
        //調整 textView 高度
        descUITextView = UITextViewReSize(textView: descUITextView)
        
        
        //判斷是否 online
        GetCurrentTime() //取得現在的時間與屬於目前哪一段節目的index
        if idx == nowIdx {
            if let viewWithTag = self.view.viewWithTag(100) {
                viewWithTag.isHidden = false
            }
            microphoneUIImageView.backgroundColor = UIColor.green
        } else {
            if let viewWithTag = self.view.viewWithTag(100) {
                viewWithTag.isHidden = true
            }
            microphoneUIImageView.backgroundColor = UIColor.clear
        }
        
        //處理 Segmentgen
        if type == "set" {
            GenSegmentData(kind: type)
        }
        
        //同步 index
        ShowUIPageControl.currentPage = idx
    }
    
    @IBAction func PrevBtn(_ sender: Any) {
        selectedIdx = (selectedIdx + infoDataArr.count - 1) % infoDataArr.count
        GenView(idx: selectedIdx, type: "set")
        if debug {
            print("prev: \(selectedIdx)")
            print("now: \(nowIdx)")
        }
    }
    
    @IBAction func NextBtn(_ sender: Any) {
        selectedIdx = (selectedIdx + 1) % infoDataArr.count
        GenView(idx: selectedIdx, type: "set")
        if debug {
            print("now: \(nowIdx)")
            print("next: \(selectedIdx)")
        }
    }
    
    @IBAction func changePageControl(_ sender: Any) {
        selectedIdx = ShowUIPageControl.currentPage
        GenView(idx: selectedIdx, type: "set")
    }
    
    @IBAction func sg1SegmentedControl(_ sender: Any) {
        selectedIdx = title123UISegmentedControl.selectedSegmentIndex
        GenView(idx: selectedIdx, type: "set")
    }
    
    @IBAction func sg2SegmentedControl(_ sender: Any) {
        selectedIdx = title456UISegmentedControl.selectedSegmentIndex + 3
        GenView(idx: selectedIdx, type: "set")
    }
    
    @IBAction func sg3SegmentedControl(_ sender: Any) {
        selectedIdx = title789UISegmentedControl.selectedSegmentIndex + 6
        GenView(idx: selectedIdx, type: "set")
    }
    
    @IBAction func sg4SegmentedControl(_ sender: Any) {
        selectedIdx = title101112UISegmentedControl.selectedSegmentIndex + 9
        GenView(idx: selectedIdx, type: "set")
    }
    
    @IBAction func sg5SegmentedControl(_ sender: Any) {
        selectedIdx = title13UISegmentedControl.selectedSegmentIndex + 12
        GenView(idx: selectedIdx, type: "set")
    }
}

