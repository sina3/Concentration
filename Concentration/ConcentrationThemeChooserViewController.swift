//
//  ConcentrationThemeChooserViewController.swift
//  Concentration
//
//  Created by Sina on 2021-06-10.
//

import UIKit

class ConcentrationThemeChooserViewController: UIViewController, UISplitViewControllerDelegate {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        splitViewController?.delegate = self
    }
    
    func splitViewController(
        _ splitViewController: UISplitViewController,
        collapseSecondary secondaryViewController: UIViewController,
        onto primaryViewController: UIViewController
    ) -> Bool {
        if let cvc = secondaryViewController as? ConcentrationViewController {
            return cvc.theme == nil
        }
        return false
    }
    
    
    private var splitViewDetailConcentrationViewController: ConcentrationViewController? {
        return splitViewController?.viewControllers.last as? ConcentrationViewController
    }
    
    private var lastSeguedToConcentrationViewController: ConcentrationViewController?
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Choose Theme" {
            if let themeName = (sender as? UIButton)?.currentTitle, let theme = themes[themeName] {
                if let cvc = segue.destination as? ConcentrationViewController {
                    cvc.theme = theme
                    lastSeguedToConcentrationViewController = cvc
                }
            }

        }
    
    }
    
    private var themes = ["Halloween": "👻👿🎃💀🙀🧙‍♂️🧛‍♀️👹⚰️🍬🔪",
                          "Fruits": "🍎🥭🍉🍑🥥🍐🍌🍇🍒🥝🫐",
                          "Animals": "🐶🐭🐸🐒🦆🐝🐴🐼🦉🐗🦋",
                          "Food": "🍕🌮🌯🌭🍔🍝🥗🥓🍗🍟🍝🥪",
                          "Sports": "🏌️‍♀️🏊🚴⛹️‍♀️🏄🏇🧗🏂🏋🏼🤾🏿🚣🏽‍♂️",
                          "Gadgets": "📱💻📷🖨📹⌚️🎧⌨️💾🎙🕹",
                   ]
    
    
    
    @IBAction func changeTheme(_ sender: Any) {
        if let cvc = splitViewDetailConcentrationViewController {
            if let themeName = (sender as? UIButton)?.currentTitle, let theme = themes[themeName] {
                cvc.theme = theme
            }
        } else if let cvc = lastSeguedToConcentrationViewController {
            if let themeName = (sender as? UIButton)?.currentTitle, let theme = themes[themeName] {
                cvc.theme = theme
            }
            navigationController?.pushViewController(cvc, animated: true)
        } else {
            performSegue(withIdentifier: "Choose Theme", sender: sender)
        }

            
        
    }


}
