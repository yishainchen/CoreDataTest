//
//  ViewController.m
//  CoreDataTest
//
//  Created by yishain on 9/16/15.
//  Copyright (c) 2015 yishain. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
#import "User.h"
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

{
    NSMutableArray *userArray;
}
@property UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addUser)];
    self.navigationItem.rightBarButtonItem = addButton;
    [self getData];
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)addUser
{

    [self performSegueWithIdentifier:@"showAddView" sender:nil];
    
    return;
//    AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
//    NSEntityDescription *entity = [NSEntityDescription entityForName:@"User" inManagedObjectContext:delegate.managedObjectContext];
//    User *record = [[User alloc] initWithEntity:entity insertIntoManagedObjectContext:delegate.managedObjectContext];
//    record.age = @(5);
//    record.location = @"天不⽼,情難絕。⼼似雙絲網,中有千千結。";
//    record.name = @"張三影";
//    NSError *error = nil;
//    [delegate.managedObjectContext save:&error];
//    
//    [self getData];
//    [self.tableView reloadData];
}

-(void)getData
{
    
    AppDelegate *delegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"User" inManagedObjectContext:delegate.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    NSSortDescriptor *descriptor = [[NSSortDescriptor alloc] initWithKey:@"age" ascending:YES];
    [fetchRequest setSortDescriptors:@[descriptor]];
    
    
    NSError *error = nil;
    userArray = [[delegate.managedObjectContext executeFetchRequest:fetchRequest error:&error] mutableCopy];
    NSLog(@"arr = %@",userArray);
    
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
        
        AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
        
        User *user = userArray[indexPath.row];
        
        [userArray removeObject:user];
        
        [delegate.managedObjectContext deleteObject:user];
        [delegate.managedObjectContext save:nil];
        
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
}

- (void)insertNewObject:(id)sender {
    
    
    NSManagedObjectContext *context = [self.fetchedResultsController managedObjectContext];
    NSEntityDescription *entity = [[self.fetchedResultsController fetchRequest] entity];
    NSManagedObject *newManagedObject = [NSEntityDescription insertNewObjectForEntityForName:[entity name] inManagedObjectContext:context];
    
    // If appropriate, configure the new managed object.
    // Normally you should use accessor methods, but using KVC here avoids the need to add a custom class to the template.
    [newManagedObject setValue:[NSDate date] forKey:@"timeStamp"];
    
    // Save the context.
    NSError *error = nil;
    if (![context save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    [self getData];
    User *user = userArray[indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%@", user.age];
    
    //[self configureCell:cell atIndexPath:indexPath];
    return cell;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
    
    //return [[self.fetchedResultsController sections] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return userArray.count;

}



@end
