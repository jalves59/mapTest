//
//  CategoryViewController.m
//  mapTest
//
//  Created by Joao Alves on 11/12/14.
//  Copyright (c) 2014 joaopaulo. All rights reserved.
//

#import "CategoryViewController.h"
#import "DealsListViewController.h"

@interface CategoryViewController ()

@end

@implementation CategoryViewController

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBarHidden = NO;
    
    UIBarButtonItem *btn =
    [[UIBarButtonItem alloc] initWithTitle:@"Voltar"
                                     style:UIBarButtonItemStylePlain
                                    target:nil
                                    action:nil];
    [[self navigationItem] setBackBarButtonItem:btn];
}


-(id)initWithCoder:(NSCoder *)aDecoder{
    
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        
        // The className to query on
        self.parseClassName = @"Categories";
        
        // The key of the PFObject to display in the label of the default cell style
        //self.textKey = @"name";
        
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
    PFQuery *query = [PFQuery queryWithClassName:self.parseClassName];
    [query orderByDescending:@"Categories"];
    
    
    
    return query;
}

-(PFTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath object:(PFObject *)object{
    
    static NSString *simpleTableIdentifier = @"CategoriesCell";
    
    PFTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil) {
        cell = [[PFTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    //PFObject *categoriesObject = [PFObject objectWithClassName:@"Categories"];
    
    cell.textLabel.text = [object objectForKey:@"Categories"];
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    // Recognizes touched cell
    self.touchedCell = [self objectAtIndexPath:indexPath];
    
    // Returns Touched Cell and its Relation
    NSLog(@"%@",self.touchedCell);
    
    [self performSegueWithIdentifier:@"deals" sender:self];
        
    
}



#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"deals"]) {
        DealsListViewController *destinationDeals = segue.destinationViewController;
        destinationDeals.clickedCell = self.touchedCell;

    }
    
    
}


@end







