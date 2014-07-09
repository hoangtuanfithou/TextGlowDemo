//
//  RRSGlowLabel.m
//  TextGlowDemo
//
//  Created by Andrew on 28/04/2010.
//  Red Robot Studios 2010.
//

#import "RRSGlowLabel.h"


@interface RRSGlowLabel()
- (void)initialize;
@end

@implementation RRSGlowLabel

@synthesize glowColor, glowOffset, glowAmount;

- (void)setGlowColor:(UIColor *)newGlowColor
{
    if (newGlowColor != glowColor) {
        [glowColor release];
        CGColorRelease(glowColorRef);

        glowColor = [newGlowColor retain];
        glowColorRef = CGColorCreate(colorSpaceRef, CGColorGetComponents(glowColor.CGColor));
    }
}

- (void)initialize {
    colorSpaceRef = CGColorSpaceCreateDeviceRGB();
    
    self.glowOffset = CGSizeMake(0.0, 0.0);
    self.glowAmount = 0.0;
    self.glowColor = [UIColor clearColor];
}

- (void)awakeFromNib {
    [self initialize];
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self != nil) {
        [self initialize];
    }
    return self;
}

- (void)drawTextInRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    
    CGContextSetShadow(context, self.glowOffset, self.glowAmount);
    CGContextSetShadowWithColor(context, self.glowOffset, self.glowAmount, glowColorRef);
    
    [super drawTextInRect:rect];
    
    CGContextRestoreGState(context);
}

- (void)dealloc {
    CGColorRelease(glowColorRef);
    CGColorSpaceRelease(colorSpaceRef);
    [glowColor release];
    [super dealloc];
}

- (void)setDarkShadowLevel:(int)darkLevel {
    for (UIView *subView in self.subviews) {
        if([subView isKindOfClass:[RRSGlowLabel class]]) {
            [subView removeFromSuperview];
        }
    }
    for (int i = 0; i<darkLevel; i++) {
        RRSGlowLabel *aLabel = [self duplicateLabel];
        [self addSubview:aLabel];
    }
}

- (void)setDarkShadowLevel:(int)darkLevel {
    for (UIView *subView in self.subviews) {
        if([subView isKindOfClass:[RRSGlowLabel class]]) {
            [subView removeFromSuperview];
        }
    }
    for (int i = 0; i<darkLevel; i++) {
        RRSGlowLabel *aLabel = [self duplicateLabel];
        [self addSubview:aLabel];
    }
}


- (RRSGlowLabel *)duplicateLabel {
    RRSGlowLabel *duplicateLabel = [[RRSGlowLabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    duplicateLabel.text = self.text;
    duplicateLabel.textColor = self.textColor;
    duplicateLabel.font = self.font;
    duplicateLabel.numberOfLines = self.numberOfLines;
    duplicateLabel.textAlignment = self.textAlignment;
    duplicateLabel.backgroundColor = [UIColor clearColor];
    
    duplicateLabel.glowColor = self.glowColor;
    duplicateLabel.glowOffset = self.glowOffset;
    duplicateLabel.glowAmount = self.glowAmount;
    
    return [duplicateLabel autorelease];
}


@end
