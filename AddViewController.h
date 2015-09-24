//
//  AddViewController.h
//  CoreDataTest
//
//  Created by yishain on 9/23/15.
//  Copyright © 2015 yishain. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"

@interface AddViewController : UIViewController


@property (weak, nonatomic) IBOutlet UITextField *nameText;

@property (weak, nonatomic) IBOutlet UITextField *ageText;

@property (weak, nonatomic) IBOutlet UITextField *locationTxt;
@property (strong, nonatomic) User *user;

@end
