//
//  SearchController.swift
//  Rokk3rShop
//
//  Created by Konstantin Efimenko on 3/15/16.
//  Copyright © 2016 Kostiantyn Iefymenko. All rights reserved.
//

import UIKit
import RealmSwift

protocol SearchControllerDelegate: class {
    func onSearchingComplete()
}

class SearchController: NSObject {
    
    var realmQueue: dispatch_queue_t?
    
    var brandsArray = [Brand]()
    var clothingTypeArray = [ClothingType]()
    var resultQueryArray = [String]()
    weak var delegate: SearchControllerDelegate?
    
    func search(searchString: String){
        let itemsForSearch = searchString.componentsSeparatedByString(" ")
            
            var resultQueryArray = [String]()
            var brandsArray = [Brand]()
            var clothingTypeArray = [ClothingType]()
            var brandsDictionary = [Brand: NSInteger]()
            var clothingTypesDictionary = [ClothingType: NSInteger]()
            
            let realm = try! Realm()
        
            for item in itemsForSearch{
                let brands = realm.objects(Brand).filter("name CONTAINS [c] %@", item)
                let clothingTypes = realm.objects(ClothingType).filter("name CONTAINS [c] %@", item)
                
                for brand in brands{
                    if brandsDictionary[brand] != nil {
                        brandsDictionary[brand] = brandsDictionary[brand]!+1
                    }else{
                        brandsDictionary[brand] = 1
                    }
                }
                
                for clothingType in clothingTypes{
                    if clothingTypesDictionary[clothingType] != nil {
                        clothingTypesDictionary[clothingType] = clothingTypesDictionary[clothingType]!+1
                    }else{
                        clothingTypesDictionary[clothingType] = 1
                    }
                }
                
                if brands.count == 0 && clothingTypes.count == 0 {
                    resultQueryArray.append(item)
                }
            }
        
            brandsArray = Array(brandsDictionary.keys).sort{
                let obj1 = brandsDictionary[$0]
                let obj2 = brandsDictionary[$1]
                return obj1 > obj2
            }
            
            clothingTypeArray = Array(clothingTypesDictionary.keys).sort{
                let obj1 = clothingTypesDictionary[$0]
                let obj2 = clothingTypesDictionary[$1]
                return obj1 > obj2
            }
        
            self.brandsArray =  brandsArray
            self.clothingTypeArray =  clothingTypeArray
            self.resultQueryArray = resultQueryArray
            self.delegate?.onSearchingComplete()

    }
    
    func sectionsNumber() -> NSInteger{
        
        var result = 0
        if brandsArray.count>0 {
            result++
        }
        
        if clothingTypeArray.count>0 {
            result++
        }
        
        if resultQueryArray.count>0 {
            result++
        }
        
        return result
    }

    func rowsNumber(inSection: NSInteger) -> NSInteger{
        
        if inSection == 0 {
            if brandsArray.count > 0 {
                return brandsArray.count
            }else if clothingTypeArray.count > 0 {
                return clothingTypeArray.count
            }else{
                return resultQueryArray.count
            }
        } else if inSection == 1 {
            if clothingTypeArray.count > 0 {
                return clothingTypeArray.count
            }else{
                return resultQueryArray.count
            }
        } else {
            return resultQueryArray.count
        }
        
    }
    
    func headerForSection(inSection: NSInteger) -> String{
        if inSection == 0 {
            if brandsArray.count > 0 {
                return "Brand"
            }else if clothingTypeArray.count > 0 {
                return "Clothing type"
            }else{
                return "Result query"
            }
        } else if inSection == 1 {
            if clothingTypeArray.count > 0 {
                return "Clothing type"
            }else{
                return "Result query"
            }
        } else {
            return "Result query"
        }
    }
    

    func titleForRow(inIndexPath indexPath: NSIndexPath) -> String{
        
        var result = ""
        if indexPath.section == 0 {
        if self.brandsArray.count > 0 {
                result =  self.brandsArray[indexPath.row].name
                
            }else if self.clothingTypeArray.count > 0 {
                result =  self.clothingTypeArray[indexPath.row].name
                
            }else{
                result =  self.resultQueryArray[indexPath.row]
            }
        } else if indexPath.section == 1 {
            if self.clothingTypeArray.count > 0 {
                result =  self.clothingTypeArray[indexPath.row].name
            }else{
                result = self.resultQueryArray[indexPath.row]
            }
        } else {
            result = self.resultQueryArray[indexPath.row]
        }
        return result        
        
    }
}
