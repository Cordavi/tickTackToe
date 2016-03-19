//
//  ViewController.m
//  Tic-Tac-Toe
//
//  Created by Cordavi on 3/18/16.
//  Copyright © 2016 Cordavi. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *buttons;
@property (nonatomic) BOOL isPlayerOneTurn;
@end

@implementation ViewController

-(void)viewDidLoad {
  [super viewDidLoad];
  
}

- (void)setupGame {
  self.isPlayerOneTurn = NO;
}

- (void)makeMoveForSpace:(NSUInteger) place {
  NSString *moveString = self.isPlayerOneTurn ? @"X" : @"O";
  for (UIButton *button in self.buttons) {
    if (button.tag == place) {
      [button setTitle:moveString forState:UIControlStateNormal];
    }
  }
  self.isPlayerOneTurn = !self.isPlayerOneTurn;
}

-(IBAction)buttonTapped:(id)sender {
  NSInteger buttonTag = ((UIButton *)sender).tag;
  UIButton *button = sender;
  [self makeMoveForSpace:buttonTag];
}



@end
