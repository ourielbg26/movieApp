//
//  Constants.swift
//  The movie DB App
//
//  Created by Itzik Bar-Noy on 22/06/2020.
//  Copyright © 2019 Itzik Bar-Noy. All rights reserved.
//

import Foundation

struct Constants {
    
    struct Segue {
        static let movieDetailsSegue: String = "MovieDetailsSegue"
    }
    
    struct Page {
        static let maxNumberOfPagesToDisplay: Int = 5
    }
    
    struct Image {
        static let questionMark: String = "questionMark"
    }
    
    struct WebServices {
        static let apiKey: String = "e57dd86aacf8d0a0652e54d0ab534f0a"
    }
    
    struct ErrorMessage {
        static let title = "Oops"
        static let description = "Something went wrong, please try again later."
    }
}
