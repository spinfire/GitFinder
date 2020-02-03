//
//  GitFinderTableViewController.h
//  GitFinder
//
//  Created by manuel on 03/02/2020.
//  Copyright © 2020 manuel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GitFinderTableViewController : UITableViewController <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate>
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@end
