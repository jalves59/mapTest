//
//  CategoryViewController.h
//  mapTest
//
//  Created by Joao Alves on 11/12/14.
//  Copyright (c) 2014 joaopaulo. All rights reserved.
//

#import <Parse/Parse.h>

@interface CategoryViewController : PFQueryTableViewController

@property(nonatomic, strong) PFObject *touchedCell;
@property(nonatomic, strong) PFRelation *relation;
@property(nonatomic, strong) PFQuery *queryForTouched;


@end
