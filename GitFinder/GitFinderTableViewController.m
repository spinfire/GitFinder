//
//  GitFinderTableViewController.m
//  GitFinder
//
//  Created by manuel on 03/02/2020.
//  Copyright © 2020 manuel. All rights reserved.
//

#import "GitFinderTableViewController.h"

//#import <AppKit/AppKit.h>
@interface GitFinderTableViewController()
{
    NSArray *devices;
    NSMutableArray *names;
    NSMutableArray *filteredDevices;
    
    BOOL isFiltered;
}
@end


@implementation GitFinderTableViewController

NSMutableArray* getDataUser(NSString *name){
    NSDictionary *arr;
    NSString *str = [NSString stringWithFormat:@"https://api.github.com/search/users\?q\=%@\&per_page=5", name];

    NSURL *url = [[NSURL alloc]initWithString:str];
    NSData *data = [[NSData alloc ]initWithContentsOfURL:url];

    arr = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    
    NSArray* albumsvideo = [arr objectForKey:@"items"];
    NSMutableArray *namesList = [[NSMutableArray alloc] init];
    for (int i = 1; i <= 5; i++)
    {
        NSString *titre1 = [[albumsvideo objectAtIndex:i]valueForKey:@"login"];
        [namesList addObject:titre1];
    }

    return namesList;
    

}

void greetPerson(NSString *name) {
     NSString *bigGreeting = [name uppercaseString];
     
     NSLog(@"Hey there, %@", bigGreeting);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    isFiltered = false;
    self.searchBar.delegate = self;
    greetPerson(@"PERSONA");

}





-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    if (searchText.length == 0){
        isFiltered = false;
    }
    else{
        isFiltered = true;
        names.removeAllObjects;
        if (searchText != Nil){
                names = getDataUser(searchText);
        }
    }
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    if (isFiltered){
        return names.count;
    }
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    if (isFiltered){
        
        cell.textLabel.text = names[indexPath.row];
        
    }
    else{
        //cell.textLabel.text = devices[indexPath.row];
    }
    return cell;
}
@end

