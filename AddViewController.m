//
//  AddViewController.m
//  CoreDataTest
//
//  Created by yishain on 9/23/15.
//  Copyright © 2015 yishain. All rights reserved.
//

#import "AddViewController.h"
#import "AppDelegate.h"
#import "User.h"

@interface AddViewController ()

@end

@implementation AddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(done)];
    // Do any additional setup after loading the view.
}


-(void)done {
    
    AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    
    if(self.user) {
        
        self.user.age = @([self.ageText.text intValue]);
        self.user.name = self.nameText.text;
        self.user.location = self.locationTxt.text;
    }
    else {
        
        NSEntityDescription *entity = [NSEntityDescription entityForName:@"User" inManagedObjectContext:delegate.managedObjectContext];
        User *record = [[User alloc] initWithEntity:entity insertIntoManagedObjectContext:delegate.managedObjectContext];
        record.age = @([self.ageText.text intValue]);
        record.location = self.locationTxt.text;
    }
    
    
    NSError *error = nil;
    [delegate.managedObjectContext save:&error];
//    
//    int count = self.navigationController.viewControllers.count;
//    MasterViewController *masterController = self.navigationController.viewControllers[count-2];
//    [masterController updateUi];
//    
//    [self.navigationController popViewControllerAnimated:YES];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end
