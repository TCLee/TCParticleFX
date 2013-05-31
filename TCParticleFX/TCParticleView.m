//
//  TCParticleView.m
//  TCParticleFX
//
//  Created by Lee Tze Cheun on 5/30/13.
//  Copyright (c) 2013 Lee Tze Cheun. All rights reserved.
//

#import "TCParticleView.h"
#import <QuartzCore/QuartzCore.h>

@interface TCParticleView ()

@property (nonatomic, weak) CAEmitterLayer *particleEmitter;

@end

@implementation TCParticleView

/* We will be using a custom layer type (CAEmitterLayer) for our view. */
+ (Class)layerClass
{
    return [CAEmitterLayer class];
}

- (void)awakeFromNib
{
    self.particleEmitter = (CAEmitterLayer *)self.layer;
    
    [self configureEmitter];
 }

- (void)configureEmitter
{
    // Particle cells spawn in a circle around the emitter's position.
    // The emitter's start position does not matter because we will use the location
    // where the user touched the view.
    self.particleEmitter.emitterPosition = CGPointMake(0, 0);
    self.particleEmitter.emitterSize = CGSizeMake(40, 0);
    self.particleEmitter.emitterMode = kCAEmitterLayerOutline;
    self.particleEmitter.emitterShape = kCAEmitterLayerCircle;
    self.particleEmitter.renderMode = kCAEmitterLayerAdditive;

    // Create the cell for our emitter to start spewing out.
    CAEmitterCell *particleCell = [CAEmitterCell emitterCell];
    
    // Giving the cell a name allows us to retrieve it later.
    [particleCell setName:@"heart"];
    
    // We don't emit cells until the user touches the screen. Hence, birthRate = 0.
    particleCell.birthRate = 0;
    particleCell.lifetime = 4;
    
    particleCell.velocity = 100;
    particleCell.scale = 0.75;
    particleCell.scaleSpeed = -0.2; // Get smaller over time.
    particleCell.spinRange = 2.0 * M_PI; // Spin the hearts from -180 to +180 degrees.
    
    // Cells will have a random color to them.
    particleCell.color      = [[UIColor colorWithRed:1.0 green:0.0 blue:0.0 alpha:0.5] CGColor];
    particleCell.redRange   = 1.0;
    particleCell.greenRange = 1.0;
    particleCell.blueRange  = 1.0;
    // Cell will fade out over its lifetime.
    particleCell.alphaSpeed  = -0.5 / particleCell.lifetime;
        
    // The image used for the particle cells.
    particleCell.contents = (id)([[UIImage imageNamed:@"Heart.png"] CGImage]);
    
    // Add the cell to our emitter layer to begin emitting cells.
    self.particleEmitter.emitterCells = @[particleCell];
}

/* Change the emitter's position to where the user touched. */
- (void)setEmitterPositionFromTouch:(UITouch *)touch
{
    self.particleEmitter.emitterPosition = [touch locationInView:self];
}

/* Set whether the emitter is spawning cells. */
- (void)setIsEmitting:(BOOL)isEmitting
{
    // We gave the cell a name "fire", so we can retrieve it using the key path.
    [self.particleEmitter setValue:(isEmitting ? @125: @0)
                        forKeyPath:@"emitterCells.heart.birthRate"];
}

@end
