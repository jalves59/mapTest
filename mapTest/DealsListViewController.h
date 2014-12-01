//
//  DealsListViewController.h
//  mapTest
//
//  Created by Joao Alves on 11/12/14.
//  Copyright (c) 2014 joaopaulo. All rights reserved.
//

#import <Parse/Parse.h>

@interface DealsListViewController : PFQueryTableViewController

@property(nonatomic, strong) PFObject *clickedCell;
@property(nonatomic, strong) PFObject *clickedDeal;
@property (nonatomic, retain) NSMutableDictionary *sections;

@end
