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
    NSMutableArray *filteredDevices;
    
    BOOL isFiltered;
}
@end

@implementation GitFinderTableViewController
void getDataUser(NSString *name){
    NSDictionary *arr;
    NSString *str = [NSString stringWithFormat:@"https://api.github.com/search/users\?q\=%@", name];

    NSURL *url = [[NSURL alloc]initWithString:str];
    NSData *data = [[NSData alloc ]initWithContentsOfURL:url];

    arr = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];

    NSLog(@"%@",arr);
}

void greetPerson(NSString *name) {
     NSString *bigGreeting = [name uppercaseString];
     
     NSLog(@"Hey there, %@", bigGreeting);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    isFiltered = false;
    self.searchBar.delegate = self;
    devices = @[@"iPhone",@"iPad",@"iPod",@"iMac",@"iWatch", @"iTV"];

    greetPerson(@"PERSONA");

}





-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    if (searchText.length == 0){
        isFiltered = false;
    }
    else{
        isFiltered = true;
        getDataUser(searchText);
        filteredDevices = [[NSMutableArray alloc]init];
        for (NSString *device in devices){
            NSRange nameRange = [device rangeOfString:searchText options:NSCaseInsensitiveSearch];
            if (nameRange.location != NSNotFound){
                [filteredDevices addObject:device];
            }
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
        return filteredDevices.count;
    }
    return devices.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    if (isFiltered){
        
        cell.textLabel.text = filteredDevices[indexPath.row];
        
    }
    else{
        cell.textLabel.text = devices[indexPath.row];
    }
    return cell;
}
@end

