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
    
    private var themes = ["Halloween": "๐ป๐ฟ๐๐๐๐งโโ๏ธ๐งโโ๏ธ๐นโฐ๏ธ๐ฌ๐ช",
                          "Fruits": "๐๐ฅญ๐๐๐ฅฅ๐๐๐๐๐ฅ๐ซ",
                          "Animals": "๐ถ๐ญ๐ธ๐๐ฆ๐๐ด๐ผ๐ฆ๐๐ฆ",
                          "Food": "๐๐ฎ๐ฏ๐ญ๐๐๐ฅ๐ฅ๐๐๐๐ฅช",
                          "Sports": "๐๏ธโโ๏ธ๐๐ดโน๏ธโโ๏ธ๐๐๐ง๐๐๐ผ๐คพ๐ฟ๐ฃ๐ฝโโ๏ธ",
                          "Gadgets": "๐ฑ๐ป๐ท๐จ๐นโ๏ธ๐งโจ๏ธ๐พ๐๐น",
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
