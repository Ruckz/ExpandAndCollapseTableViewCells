//
//  ViewController.h
//  AccordionTableView
//
//  Created by Ruckya Sinorina on 7/1/15.
//  Copyright (c) 2015 Ruckya Sinorina. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UITableViewDelegate,UITableViewDelegate>

{
    NSArray   *parentCellItems;
    NSInteger currentExpandedIndex;
   

}

@property (nonatomic, strong) IBOutlet UITableView *tab;

@end

