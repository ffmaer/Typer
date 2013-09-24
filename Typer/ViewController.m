//
//  ViewController.m
//  Typer
//
//  Created by tcz on 8/19/13.
//  Copyright (c) 2013 Maer Studios Inc. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *selectedText;
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UIStepper *stepper;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self select];
    
}

-(NSArray *)wordList{
    NSArray *wordList = [[self.label.attributedText string] componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    return wordList;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)select {
    self.stepper.maximumValue = [[self wordList] count]-1;
    self.selectedText.text = [self selectedWord];
}

-(NSString *)selectedWord{
    return [[self wordList] objectAtIndex:self.stepper.value];
}

-(void)changeAttribute:(NSDictionary *)attribute{
    NSMutableAttributedString *mat = [self.label.attributedText mutableCopy];
    [mat addAttributes:attribute range:[[self.label.attributedText string] rangeOfString:[self selectedWord]]];
    self.label.attributedText = mat;
}

- (IBAction)changeColor:(UIButton *)sender {
    [self changeAttribute:@{NSForegroundColorAttributeName : sender.backgroundColor}];
}


- (IBAction)changeFont:(UIButton *)sender {
    CGFloat fontSize = [UIFont systemFontSize];
    NSDictionary *attributes = [self.label.attributedText attributesAtIndex:0 effectiveRange:NULL];
    UIFont *existingFont = attributes[NSFontAttributeName];
    if(existingFont) fontSize = existingFont.pointSize;
    
    UIFont *font = [sender.titleLabel.font fontWithSize:fontSize];
    [self changeAttribute:@{NSFontAttributeName : font}];
}
- (IBAction)underline:(UIButton *)sender {
    [self changeAttribute:@{NSUnderlineStyleAttributeName : @(NSUnderlineStyleSingle)}];
}
- (IBAction)ununderline:(UIButton *)sender {
        [self changeAttribute:@{NSUnderlineStyleAttributeName : @(NSUnderlineStyleNone)}];
}
- (IBAction)outline:(UIButton *)sender {
    [self changeAttribute:@{NSStrokeWidthAttributeName : @1}];
}
- (IBAction)unoutline {
        [self changeAttribute:@{NSStrokeWidthAttributeName : @0}];
}



@end
