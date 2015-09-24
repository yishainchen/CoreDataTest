//
//  ViewController.h
//  CoreDataTest
//
//  Created by yishain on 9/16/15.
//  Copyright (c) 2015 yishain. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>


@interface ViewController : UIViewController<NSFetchedResultsControllerDelegate>

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

-(void)updateUi;

@end

