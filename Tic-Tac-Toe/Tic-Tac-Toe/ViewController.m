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
@property (strong, nonatomic) NSArray *sortedButtons;
@property (nonatomic) BOOL isPlayerOneTurn;
@end

@implementation ViewController

typedef enum buttonPlaceTags {
    topLeft,
    topCenter,
    topRight,
    centerLeft,
    centerCenter,
    centerRight,
    bottomLeft,
    bottomCenter,
    bottomRight
} ButtonPlace;

#pragma mark lifecycle

-(void)viewDidLoad {
    [super viewDidLoad];
    [self setupGame];
}

#pragma mark setup

- (void)setupGame {
    self.isPlayerOneTurn = YES;
    NSSortDescriptor *ascendingSort = [[NSSortDescriptor alloc] initWithKey:@"tag" ascending:YES];
    self.sortedButtons = [self.buttons sortedArrayUsingDescriptors:@[ascendingSort]];
    
    for (UIButton *button in self.buttons) {
        [button setTitle:nil forState:UIControlStateNormal];
    };
}

#pragma mark accessors

- (NSArray *)winningCombinations {
    
    return @[
             @[@(topLeft), @(topCenter) ,@(topRight)],
             @[@(centerLeft), @(centerCenter), @(centerRight)],
             @[@(bottomLeft), @(bottomCenter), @(bottomRight)],
             @[@(topLeft), @(centerCenter), @(bottomRight)],
             @[@(topRight), @(centerCenter), @(bottomLeft)],
             @[@(topLeft), @(centerLeft), @(bottomLeft)],
             @[@(topCenter), @(centerCenter), @(bottomCenter)],
             @[@(topRight), @(centerRight), @(bottomRight)]
             ];
}

#pragma mark imperatives

- (void)makeMoveForSpace:(NSUInteger) place {
    NSString *moveString = self.isPlayerOneTurn ? @"X" : @"O";
    for (UIButton *button in self.buttons) {
        if (button.tag == place) {
            [button setTitle:moveString forState:UIControlStateNormal];
        }
    }
    self.isPlayerOneTurn = !self.isPlayerOneTurn;
}


- (void)checkForWin {
    
    for (NSArray *winningCombo in [self winningCombinations]) {
        UIButton *buttonOne = self.sortedButtons[[winningCombo[0] integerValue]];
        UIButton *buttonTwo = self.sortedButtons[[winningCombo[1] integerValue]];
        UIButton *buttonThree = self.sortedButtons[[winningCombo[2] integerValue]];
        
        if ([buttonOne.currentTitle isEqual:buttonTwo.currentTitle] && [buttonTwo.currentTitle isEqual:buttonThree.currentTitle]) {
            UIAlertController *gameOverAlertController = [UIAlertController
                                                  alertControllerWithTitle:@"Winner"
                                                  message:@"Player has won!"
                                                  preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *restartGameAction = [UIAlertAction
                                                actionWithTitle:@"Restart Game"
                                                style:UIAlertActionStyleDefault
                                                handler:^(UIAlertAction *refreshGame) {
                                                    [self setupGame];
                                                }];
            
            [gameOverAlertController addAction:restartGameAction];
            
            [self presentViewController:gameOverAlertController animated:YES completion:nil];
        }
    }
}


#pragma mark IBActions

-(IBAction)buttonTapped:(id)sender {
    UIButton *tappedButton = (UIButton *)sender;
    //NSLog(@"%@",tappedButton.titleLabel.text);
    
    if (!tappedButton.currentTitle) {
        NSInteger buttonTag = tappedButton.tag;
        [self makeMoveForSpace:buttonTag];
        [self checkForWin];
    }
}



@end





//    UIButton *firstButton = self.sortedButtons[0];
//    UIButton *secondButton = self.sortedButtons[1];
//    UIButton *thirdButton = self.sortedButtons[2];
//    UIButton *fourthButton = self.sortedButtons[3];
//    UIButton *fifthButton = self.sortedButtons[4];
//    UIButton *sixthButton = self.sortedButtons[5];
//    UIButton *seventhButton = self.sortedButtons[6];
//    UIButton *eighthButton = self.sortedButtons[7];
//    UIButton *ninthButton = self.sortedButtons[8];
//
//
//    //Horiztonal Solutions
//    if ([firstButton.titleLabel.text isEqual: secondButton.titleLabel.text] && [secondButton.titleLabel.text isEqualToString:thirdButton.titleLabel.text]) {
//        NSLog(@"PLAYER WINS!");
//    }
//
//    if ([fourthButton.titleLabel.text isEqual: fifthButton.titleLabel.text] && [fifthButton.titleLabel.text isEqualToString:sixthButton.titleLabel.text]) {
//        NSLog(@"PLAYER WINS!");
//    }
//
//    if ([seventhButton.titleLabel.text isEqual: eighthButton.titleLabel.text] && [eighthButton.titleLabel.text isEqualToString:ninthButton.titleLabel.text]) {
//        NSLog(@"PLAYER WINS!");
//    }
//
//
//    //Vertical Solutions
//    if ([firstButton.titleLabel.text isEqual:fourthButton.titleLabel.text] && [fourthButton.titleLabel.text isEqualToString:seventhButton.titleLabel.text]) {
//        NSLog(@"PLAYER WINS!");
//    }
//
//    if ([secondButton.titleLabel.text isEqual:fifthButton.titleLabel.text] && [fifthButton.titleLabel.text isEqualToString:eighthButton.titleLabel.text]) {
//        NSLog(@"PLAYER WINS!");
//    }
//
//    if ([thirdButton.titleLabel.text isEqual:sixthButton.titleLabel.text] && [sixthButton.titleLabel.text isEqualToString:ninthButton.titleLabel.text]) {
//        NSLog(@"PLAYER WINS!");
//    }
//
//    //Diagonal Solutions
//    if ([firstButton.titleLabel.text isEqual:fifthButton.titleLabel.text] && [fifthButton.titleLabel.text isEqualToString:ninthButton.titleLabel.text]) {
//        NSLog(@"PLAYER WINS!");
//    }
//
//    if ([thirdButton.titleLabel.text isEqual:fifthButton.titleLabel.text] && [fifthButton.titleLabel.text isEqualToString:seventhButton.titleLabel.text]) {
//        NSLog(@"PLAYER WINS!");
//    }
