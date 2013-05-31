//
//  TCParticleView.h
//  TCParticleFX
//
//  Created by Lee Tze Cheun on 5/30/13.
//  Copyright (c) 2013 Lee Tze Cheun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TCParticleView : UIView

- (void)setEmitterPositionFromTouch:(UITouch *)touch;

- (void)setIsEmitting:(BOOL)isEmitting;

@end
