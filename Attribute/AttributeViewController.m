//
//  AttributeViewController.m
//  Attribute
//
//  Created by Alex Paul on 2/5/13.
//  Copyright (c) 2013 Alex Paul. All rights reserved.
//

#import "AttributeViewController.h"

@interface AttributeViewController ()
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UIStepper *selectedWordStepper;
@property (weak, nonatomic) IBOutlet UILabel *selectedWordLabel;
@end

@implementation AttributeViewController

- (IBAction)underline
{
    [self addSelectedWordAttribues:@{NSUnderlineStyleAttributeName : @(NSUnderlineStyleSingle)}];
}

- (IBAction)ununderline
{
    [self addSelectedWordAttribues:@{NSUnderlineStyleAttributeName : @(NSUnderlineStyleNone)}];
}

- (void)addLabelAttributes:(NSDictionary *)attributes range:(NSRange)range
{
    if (range.location != NSNotFound) {
        NSMutableAttributedString *mat = [self.label.attributedText mutableCopy];
        [mat addAttributes:attributes range:range];
        self.label.attributedText = mat;
    }
}

- (void)addSelectedWordAttribues:(NSDictionary *)attributes
{
    NSRange range = [[self.label.attributedText string] rangeOfString:[self selectedWord]];
    [self addLabelAttributes:attributes range:range];
}

- (NSArray *)wordList
{
    NSArray *wordList = [[self.label.attributedText string] componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    if ([wordList count]) {
        return wordList;
    }else{
        return @[@""]; 
    }
}

- (NSString *)selectedWord
{
    return [self wordList][(int)self.selectedWordStepper.value ];
}

- (IBAction)updateSelectedWord
{
    self.selectedWordStepper.maximumValue = [[self wordList] count]-1;
    self.selectedWordLabel.text = [self selectedWord]; 
}

- (IBAction)changeColor:(UIButton *)sender
{
    [self addSelectedWordAttribues:@{NSForegroundColorAttributeName : sender.backgroundColor}]; 
}

- (IBAction)changeFont:(UIButton *)sender
{
    CGFloat fontSize = [UIFont systemFontSize];
    
    NSDictionary *attributes = [self.label.attributedText attributesAtIndex:0 effectiveRange:NULL];
    UIFont *existingFont = attributes[NSFontAttributeName];
    if(existingFont) fontSize = existingFont.pointSize;
    
    UIFont *font = [sender.titleLabel.font fontWithSize:fontSize];
    [self addSelectedWordAttribues:@{NSFontAttributeName : font}];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self updateSelectedWord]; 
}

@end
