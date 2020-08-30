//
//  ViewController.swift
//  Example
//
//  Created by Stonly on 31/08/2020.
//  Copyright © 2020 Stonly. All rights reserved.
//

import UIKit

import StonlySdk
import FloatingPanel

class ViewController: UIViewController, Guidable {
    let fpDelegate = MyFloatingPanelDelegate()
    
    @IBOutlet var modalButton: UIButton!
    @IBOutlet var fullScreenButton: UIButton!
    @IBOutlet var knowledgeBaseButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Stonly iOS library"
        
        customizeNavigation()
        customizeButtons()
        
        Stonly.shared.initialize(widgetId: "0041028e-a25b-11e9-a307-06e18af4fc90") { result in
            print(result)
        }
    }
    
    private func customizeNavigation() {
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.barTintColor = UIColor.init(red: 40.0/255.0, green: 61.0/255.0, blue: 123.0/255.0, alpha: 1.0)
    }
    
    private func customizeButtons() {
        [modalButton, fullScreenButton, knowledgeBaseButton].forEach {
            $0?.layer.borderWidth = 1.0
            $0?.layer.borderColor = UIColor.stonlyGrey.cgColor
            $0?.layer.cornerRadius = 4.0
            
            $0?.imageEdgeInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
            $0?.titleEdgeInsets = UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 0)
        }
    }
    
    @IBAction func modalButtonTapped(_ sender: UIButton) {
        //https://stonly.com/guide/en/stonly-embedded-on-home-page-197/Steps/1139
        let config = GuideConfiguration(explanationId: "stonly-embedded-on-home-page-197", stepId: "1139")
        try? present(screenType: .guide(config), floatingPanelDelegate: fpDelegate)
    }
    
    @IBAction func fullScreenGuideButtonTapped(_ sender: UIButton) {
        //https://stonly.com/guide/en/stonly-embedded-on-home-page-197/Steps/1139
        let config = GuideConfiguration(explanationId: "stonly-embedded-on-home-page-197", stepId: "1139")
        let newScreen = StonlyWebViewController()
        newScreen.view.backgroundColor = .white
        try? newScreen.start(screenType: .guide(config))
        show(newScreen, sender: self)
        
    }
    
    @IBAction func fullScreenKBButtonTapped(_ sender: UIButton) {
        //https://stonly.com/kb/en
        let config = KnowledgeBaseConfiguration(baseURL: "https://stonly.com")
        let newScreen = StonlyWebViewController()
        newScreen.view.backgroundColor = .white
        show(newScreen, sender: self)
        try? newScreen.start(screenType: .knowledgeBase(config))
    }
    
    private func showPanel() {
//        let theme = ThemeConfig(language: "en", accent: .green)
        let kbConfig = KnowledgeBaseConfiguration(baseURL: "https://stonly.com")
        try? present(screenType: .knowledgeBase(kbConfig), animated: true)
//        let listener = EventListener()
//        listener.add(for: .currentSteps) { print($0?.description ?? "") }
//        listener.add(for: .currentStep) { print($0?.description ?? "") }
//        listener.add(for: .endOfExplanation) { print($0?.description ?? "") }
//        listener.add(for: .explanationIntroduction) { print($0?.description ?? "") }
//        listener.add(for: .goBackClicked) { print($0?.description ?? "") }
//        let screenType = ScreenType.guide(GuideConfiguration(explanationId: "77", stepId: "1380", theme: theme, eventsListener: listener))
//        try? present(screenType: screenType, floatingPanelDelegate: fpDelegate)
    }
}

//Example as at: https://github.com/SCENEE/FloatingPanel
class MyFloatingPanelDelegate: FloatingPanelControllerDelegate {
    func floatingPanel(_ vc: FloatingPanelController, layoutFor newCollection: UITraitCollection) -> FloatingPanelLayout? {
        return FullFloatingPanelLayout()
    }
}

class FullFloatingPanelLayout: FloatingPanelLayout {
    func insetFor(position: FloatingPanelPosition) -> CGFloat? {
        switch position {
            case .full: return 16.0
            case .half: return 216.0
            case .tip: return 44.0
            default: return nil
        }
    }
    
    public var initialPosition: FloatingPanelPosition {
        return .full
    }
}
