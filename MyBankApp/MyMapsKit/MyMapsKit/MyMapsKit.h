//
//  MyMapsKit.h
//  MyMapsKit
//
//  Created by Girish Adiga  on 10/9/16.
//  Copyright © 2016 Girish Adiga . All rights reserved.
//

#import <UIKit/UIKit.h>

//! Project version number for MyMapsKit.
FOUNDATION_EXPORT double MyMapsKitVersionNumber;

//! Project version string for MyMapsKit.
FOUNDATION_EXPORT const unsigned char MyMapsKitVersionString[];

// In this header, you should import all the public headers of your framework using statements like #import <MyMapsKit/PublicHeader.h>

//! Framework will show different types of locations
enum LocationTypes {
    ATMS,  // JPMC ATMs
    BANKS  // Probably other things !
};

enum AnnotationViewType {
    DEFAULT,
    ATM_PICTURE, // Different images based on future plans
    BANK_PICTURE
};

