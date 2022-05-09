//
//  MovieDetailsTableViewCell.swift
//  The movie DB App
//
//  Created by Itzik Bar-Noy on 22/06/2020.
//  Copyright © 2019 Itzik Bar-Noy. All rights reserved.
//

import UIKit

class MovieDetailsTableViewCell: UITableViewCell {
    
    // MARK: Outlets
    @IBOutlet weak var adultLabel: UILabel!
    @IBOutlet weak var genersLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var runtimeLabel: UILabel!
    @IBOutlet weak var spokenLanguagesLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configureCell(movieProperties: MovieProperties) {
        let color: UIColor = #colorLiteral(red: 0.958645761, green: 0.3645063341, blue: 0.2066842318, alpha: 1)
        var str: String = ""
        
        if let adult = movieProperties.adult {
            str = "Is for adults? " + String(adult ? "Yes" : "No")
            adultLabel.halfTextColorChange(fullText: str, changeText: "Is for adults? ", color: color)
        } else {
            adultLabel.isHidden = true
        }

        if let genres = movieProperties.genres {
            var genersStr = [String]()
            for gener in genres {
                genersStr.append(gener.name ?? "")
            }
            
            str = "Geners: " + genersStr.joined(separator: ", ")
            genersLabel.halfTextColorChange(fullText: str, changeText: "Geners: ", color: color)
        } else {
            genersLabel.isHidden = true
        }

        if let overview = movieProperties.overview {
            str = "Overview: " + overview
            overviewLabel.halfTextColorChange(fullText: str, changeText: "Overview: ", color: color)
        } else {
            overviewLabel.isHidden = true
        }

        if let releaseDate = movieProperties.releaseDate {
            str = "Release date: " + String(releaseDate)
            releaseDateLabel.halfTextColorChange(fullText: str, changeText: "Release date: ", color: color)
        } else {
            releaseDateLabel.isHidden = true
        }

        if let runtime = movieProperties.runtime {
            str = "Run time: " + String(runtime) + " minutes"
            runtimeLabel.halfTextColorChange(fullText: str, changeText: "Run time: ", color: color)
        } else {
            runtimeLabel.isHidden = true
        }
        
        if let spokenLanguages = movieProperties.spokenLanguages {
            var spokenLanguagesStr = [String]()
            for spokenLanguage in spokenLanguages {
                spokenLanguagesStr.append(spokenLanguage.name ?? "")
            }
            
            str = "Spoken languages: " + spokenLanguagesStr.joined(separator: ", ")
            spokenLanguagesLabel.halfTextColorChange(fullText: str, changeText: "Spoken languages: ", color: color)
        } else {
            spokenLanguagesLabel.isHidden = true
        }
    }
}
