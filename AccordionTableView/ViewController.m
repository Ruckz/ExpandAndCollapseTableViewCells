//
//  ViewController.m
//  AccordionTableView
//
//  Created by Ruckya Sinorina on 7/1/15.
//  Copyright (c) 2015 Ruckya Sinorina. All rights reserved.
//

#import "ViewController.h"
#import "ChildCell.h"
#import "LetsTalkCustomCell.h"


@interface ViewController ()

@end

@implementation ViewController
@synthesize tab;


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    NSInteger numberOfRows = [parentCellItems count];
    if(currentExpandedIndex > -1)
    {
        numberOfRows = numberOfRows + 1;
    }
       
    return  numberOfRows;
}


- (CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    BOOL isChildCell = currentExpandedIndex > -1
                       &&indexPath.row >  currentExpandedIndex
                       &&indexPath.row <= currentExpandedIndex + 1;
    
    if (isChildCell) {
        return 320;
    }
    else{
        return 75;
    }
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ParentCellIdentifier = @"LetsTalkCustomCell";
    static NSString *ChildCellIdentifier = @"ChildCell";
    
    
   BOOL isChildCell = currentExpandedIndex > -1
                    && indexPath.row > currentExpandedIndex
                    && indexPath.row <= currentExpandedIndex + 1;
    
    UITableViewCell *cell ;
    
    if (isChildCell) {
        
        ChildCell *childCell;
        
        childCell = [tableView dequeueReusableCellWithIdentifier:ChildCellIdentifier];
        
        if (childCell == nil) {
            
            
            NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"ChildCell" owner:nil options:nil];
            
            for(id currentObject in topLevelObjects)
            {
                if([currentObject isKindOfClass:[ChildCell class]])
                {
                    childCell = (ChildCell *)currentObject;
                    break;
                }
            }
            
        }
        
        NSLog(@"%@   contents",[cell.contentView subviews]);
        //[cell.contentView addSubview:scrollView];
        
         cell = childCell;
        
    }
    else {
        
        
        
        LetsTalkCustomCell *parentCell = nil;
        parentCell = (LetsTalkCustomCell *) [tableView dequeueReusableCellWithIdentifier:ParentCellIdentifier];
        
        
        if(!parentCell)
        {
            NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"LetsTalkCustomCell" owner:nil options:nil];
            
            for(id currentObject in topLevelObjects)
            {
                if([currentObject isKindOfClass:[LetsTalkCustomCell class]])
                {
                    parentCell = (LetsTalkCustomCell *)currentObject;
                    break;
                }
            }
        }
        NSInteger topIndex;
        if(currentExpandedIndex > -1 && indexPath.row > currentExpandedIndex)
        {
            topIndex = indexPath.row - 1;
        }
        else
        {
            topIndex  = indexPath.row;
        }
       
        parentCell.lab.text = [[parentCellItems objectAtIndex:topIndex] capitalizedString];
        parentCell.lab.textAlignment=NSTextAlignmentLeft;
        parentCell.lab.font = [UIFont fontWithName:@"Futura-CondensedLight" size:24.0];
        parentCell.lab.textColor=[UIColor whiteColor];
             
        cell= parentCell;
        
    }
    return cell;
    
}
#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    BOOL isChildCell = currentExpandedIndex > -1
                        &&indexPath.row >  currentExpandedIndex
                        &&indexPath.row <= currentExpandedIndex + 1;

    if (isChildCell) {
        
        // all action for child cell tap
        return;
        
    }
    
    [self.tab beginUpdates];
    
    
    LetsTalkCustomCell *cell = (LetsTalkCustomCell*)[tableView cellForRowAtIndexPath:indexPath];
    //Check row selection to expand or to collapse
    if (currentExpandedIndex == indexPath.row)                  //selected an expanded cell
    {
        [self collapseSubItemsAtIndex:currentExpandedIndex];
        currentExpandedIndex = -1;                              //set back for no cells are expanded
        cell.arrow.image = [UIImage imageNamed:@"arrow_down_lt"];
    }
    else
    {
        BOOL collapseFirst = currentExpandedIndex > -1;
        
        
        if (collapseFirst) {                                    //a cell other than selected index is expanded
            
            [self collapseSubItemsAtIndex:currentExpandedIndex];
             cell.arrow.image = [UIImage imageNamed:@"arrow_down_lt"];

        }
                                                                        
        if(collapseFirst && indexPath.row > currentExpandedIndex){
            currentExpandedIndex = indexPath.row - 1;
        }
        else
        {
          currentExpandedIndex =  indexPath.row;
        
        }
        
        [self expandItemAtIndex:currentExpandedIndex];
        cell.arrow.image = [UIImage imageNamed:@"arrow_up_lt"];
        
    }
    
    [self.tab endUpdates];
    
    [self.tab scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:currentExpandedIndex inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
}

- (void)expandItemAtIndex:(NSInteger)index
{
    NSMutableArray *indexPaths = [NSMutableArray new];
    NSInteger insertPos = index + 1;
    
    [indexPaths addObject:[NSIndexPath indexPathForRow:insertPos++ inSection:0]];
    
    [self.tab insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationFade];
    [self.tab scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
}

- (void)collapseSubItemsAtIndex:(NSInteger)index
{
    
    NSMutableArray *indexPaths = [NSMutableArray new];
    [indexPaths addObject:[NSIndexPath indexPathForRow:index+1 inSection:0]];
    
    [self.tab deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationFade];
}

- (void)viewDidLoad {
    
    parentCellItems  = [[NSMutableArray alloc]initWithObjects:@"personal care",@"clothing",@"health",@"food & drink",@"travel",@"transport",@"Technology",@"Home",@"Likes",@"Major moments",@"Life goals",nil];
    
    currentExpandedIndex = -1; //No cells are expanded
    
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
