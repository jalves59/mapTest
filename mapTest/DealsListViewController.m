//
//  DealsListViewController.m
//  mapTest
//
//  Created by Joao Alves on 11/12/14.
//  Copyright (c) 2014 joaopaulo. All rights reserved.
//

#import "DealsListViewController.h"
#import "CategoryViewController.h"
#import "DetailViewController.h"

@interface DealsListViewController ()

@end

@implementation DealsListViewController


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
   
    

}




-(id)initWithCoder:(NSCoder *)aDecoder{
    
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        
        // The className to query on
        self.parseClassName = @"Places";
        
        // The key of the PFObject to display in the label of the default cell style
        //self.textKey = @"Name";
        
        // Whether the built-in pull-to-refresh is enabled
        self.pullToRefreshEnabled = YES;
        
        // Whether the built-in pagination is enabled
        self.paginationEnabled = YES;
    }
    return self;
}



#pragma mark - PFQueryTableViewController delegates

- (PFQuery *)queryForTable
{
    
    
    
    //Creates a relation based on a clicked cell at CategoryViewController and what the Relation is pointing at on Parse
    PFRelation *dealsRelation = [self.clickedCell relationForKey:@"catRelation"];
    
    
    
    
    return [dealsRelation query];
}

-(PFTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath object:(PFObject *)object{
    
    static NSString *simpleTableIdentifier = @"DealsCell";
    
    PFTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil) {
        cell = [[PFTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
//    [object refresh];
    
    cell.textLabel.text = [object objectForKey:@"Name"];
    
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    // Recognizes touched Deal
    self.clickedDeal = [self objectAtIndexPath:indexPath];
    
    [self performSegueWithIdentifier:@"detail" sender:self];
    
    
}


 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
     if ([segue.identifier isEqualToString:@"detail"]) {
         DetailViewController *destinationDetail = segue.destinationViewController;
         destinationDetail.clickedDealDetail = self.clickedDeal;
     }
   
     
     
 }
 


@end


















