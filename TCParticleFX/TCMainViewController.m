//
//  TCMainViewController.m
//  TCParticleFX
//
//  Created by Lee Tze Cheun on 5/30/13.
//  Copyright (c) 2013 Lee Tze Cheun. All rights reserved.
//

#import "TCMainViewController.h"
#import "TCParticleView.h"

@interface TCMainViewController ()

@property (nonatomic, weak) IBOutlet TCParticleView *particleView;

@end

@implementation TCMainViewController

- (id)init
{
    self = [super initWithNibName:@"TCMainView" bundle:nil];
    if (self) {
        
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
    // Stop the particle effects. They're very resource intensive.
    [self.particleView setIsEmitting:NO];
}

#pragma mark - Touch Gestures

/* Start emitting particles from where the user touched on the screen. */
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.particleView setEmitterPositionFromTouch:[touches anyObject]];
    [self.particleView setIsEmitting:YES];
}

/* Emitter's source position will move to where the user touched. */
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.particleView setEmitterPositionFromTouch:[touches anyObject]];
}

/* Stop emitting particles when user's finger leave the screen. */
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.particleView setIsEmitting:NO];
}

@end
