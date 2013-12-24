//
//  ValueSelector.m
//  WMReader
//
//  Created by Yuan Pengfei on 11-3-15.
//  Copyright 2011 Yuan Pengfei. All rights reserved.
//

#import "ValueSelector.h"


@implementation ValueSelector

@synthesize delegate, valueLabel, textLabel, slider;

- (void)changed:(UISlider *)sender
{
    self.valueLabel.text = [NSString stringWithFormat:@"%d", (int)sender.value];
    [delegate valueSelector:self valueChangedTo:sender.value];
}

- (void)dealloc
{
    [valueLabel release];
    [textLabel release];
    [slider release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.slider.minimumValue = [delegate minValueValueSelector:self];
    self.slider.maximumValue = [delegate maxValueForValueSelector:self];
    self.slider.value = [delegate valueForValueSelector:self];
    self.textLabel.text = [delegate textForValueSelector:self];
    self.valueLabel.text = [NSString stringWithFormat:@"%d", (int)self.slider.value];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    valueLabel = nil;
    textLabel = nil;
    slider = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return YES;
}

@end
