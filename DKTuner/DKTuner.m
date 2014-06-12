//
//  DKTuner.m
//  DKTuner
//
//  Created by dursun koc on 5/17/14.
//  Copyright (c) 2014 aric. All rights reserved.
//

#import "DKTuner.h"

#define distanceBetween(p1,p2) sqrt(pow((p2.x-p1.x),2) + pow((p2.y-p1.y),2))
#define kDefClearMiddle 45

@interface DKTuner()
@property (strong, nonatomic) UIImageView *sliderImageView;
@property (strong, nonatomic) UILabel *valueLabel;
@property (strong, nonatomic) UILabel *descriptionLabel;
@property (nonatomic) CGPoint centerPoint;
@property (nonatomic) NSString *objectValue;
@property (nonatomic) DKTunerMode mode;
@property (nonatomic) NSArray *avaliableValues;

@property (nonatomic) int maxValue;
@property (nonatomic) int minValue;

@property (nonatomic) BOOL isOutOfScope;
@property (nonatomic) CGPoint _lastPosition;
@property (nonatomic) CGFloat _lastChangedAngle;
@property (nonatomic) CGFloat _distanceForIcons;
@end

@implementation DKTuner

- (id)initWithFrame:(CGRect)frame
         usingImage:(UIImage *)image
   usingDescription:(NSString *)description
           maxValue:(int) maxValue
           minValue:(int) minValue{
    
    return [self initWithFrame:frame
                    usingImage:image
              usingDescription:description
               descriptionFont:[UIFont fontWithName:@"Arial" size:21]
                      maxValue:maxValue
                      minValue:minValue
               backgroundColor:[UIColor clearColor]
                     foreColor:[UIColor blackColor]
                    objectFont:[UIFont fontWithName:@"Arial" size:84]];
}

- (id)initWithFrame:(CGRect)frame
         usingImage:(UIImage *)image
   usingDescription:(NSString *)description
    descriptionFont:(UIFont *)descriptionFont
             values:(NSArray *)values
    backgroundColor:(UIColor *)backgroundColor
          foreColor:(UIColor *)foreColor
         objectFont:(UIFont *)objectFont{
    
    self =  [self initWithFrame:frame
                     usingImage:image
               usingDescription:description
                descriptionFont:descriptionFont
                       maxValue:(int)values.count
                       minValue:1
                backgroundColor:backgroundColor
                      foreColor:foreColor
                     objectFont:objectFont
                           mode:DKTunerModeValues];
    
    if (self) {
        [self setAvaliableValues:values];
        [self setValue:1];
    }
    
    return self;
}

- (id)initWithFrame:(CGRect)frame
         usingImage:(UIImage *)image
   usingDescription:(NSString *)description
    descriptionFont:(UIFont *)descriptionFont
           maxValue:(int) maxValue
           minValue:(int) minValue
    backgroundColor:(UIColor *)backgroundColor
          foreColor:(UIColor *)foreColor
         objectFont:(UIFont *)objectFont{
    
    return [self initWithFrame:frame
                    usingImage:image
              usingDescription:description
               descriptionFont:descriptionFont
                      maxValue:maxValue
                      minValue:minValue
               backgroundColor:backgroundColor
                     foreColor:foreColor
                    objectFont:objectFont
                          mode:DKTunerModeNormal];
}

- (id)initWithFrame:(CGRect)frame
         usingImage:(UIImage *)image
   usingDescription:(NSString *)description
    descriptionFont:(UIFont *)descriptionFont
           maxValue:(int) maxValue
           minValue:(int) minValue
    backgroundColor:(UIColor *)backgroundColor
          foreColor:(UIColor *)foreColor
         objectFont:(UIFont *)objectFont
               mode:(DKTunerMode)mode
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setMode:mode];
        [self setMaxValue:maxValue];
        [self setMinValue:minValue];
        [self setCenterPoint:CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2)];
        
        //ImageView
        self.sliderImageView = [[UIImageView alloc] initWithImage:image];
        [self.sliderImageView setFrame:[self frame]];
        self.sliderImageView.center =self.centerPoint;
        [self addSubview:self.sliderImageView];
        
        //ObjectValueLabel
        self.valueLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height*.4)];
        [self.valueLabel setFont:objectFont];
        [self.valueLabel setTextAlignment:NSTextAlignmentCenter];
        [self.valueLabel setCenter:CGPointMake(self.centerPoint.x, self.centerPoint.y)];
        [self sizeToFit];
        [self.valueLabel setTextColor:foreColor];
        [self addSubview:self.valueLabel];
        
        
        //DescriptionLabel
        self.descriptionLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height*.2)];
        [self.descriptionLabel setFont:descriptionFont];
        [self.descriptionLabel setText:description];
        [self.descriptionLabel setTextAlignment:NSTextAlignmentCenter];
        [self.descriptionLabel setCenter:CGPointMake(self.centerPoint.x, self.centerPoint.y*7/5)];
        [self.descriptionLabel setTextColor:foreColor];
        [self addSubview:self.descriptionLabel];
        
        //GestureRecognizer
        UIPanGestureRecognizer *gestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(gestureRecognized:)];
        gestureRecognizer.delegate = self;
        [self addGestureRecognizer:gestureRecognizer];
        [self setValue:minValue];
        //Background
        [self setBackgroundColor:backgroundColor];
    }
    return self;
}

-(void) gestureRecognized:(UIPanGestureRecognizer *) sender{
    CGPoint velocity = [sender velocityInView:self];
    CGPoint location = [sender locationInView:self];
    CGFloat vel = fabsf(velocity.y)+fabsf(velocity.x);
    int perInterval = -1;
    CGFloat angleInterval;
    switch (self.mode) {
        case DKTunerModeValues:
            angleInterval = 80;
            break;
        default:
            angleInterval = 10;
            break;
    }
    
    
    if(vel > 1400){
        
        switch (self.mode) {
            case DKTunerModeValues:
                perInterval = -1;
                angleInterval = 60;
                break;
            default:
                angleInterval = 30;
                perInterval = -10;
                break;
        }
    }
    angleInterval = angleInterval*M_PI/180;
    CGFloat distanceToMiddle = distanceBetween(self.centerPoint, location);
    self.isOutOfScope = (distanceToMiddle < kDefClearMiddle);
    
    if (sender.state == UIGestureRecognizerStateChanged || sender.state == UIGestureRecognizerStateBegan) {
        if(!self.isOutOfScope){
            CGPoint sliderStartPoint = self._lastPosition;
            if(CGPointEqualToPoint(self._lastPosition, CGPointZero)) sliderStartPoint = location;
            CGFloat angle = [self angleBetweenCenterPoint:self.centerPoint point1:sliderStartPoint point2:location];
            self._lastChangedAngle = self._lastChangedAngle + angle;
            self._lastPosition = location;
            int numberOfIntervals = round(self._lastChangedAngle/angleInterval);
            
            if(numberOfIntervals != 0){
                [self increaseValueBy:(perInterval*numberOfIntervals)];
                self.sliderImageView.transform = CGAffineTransformMakeRotation(([[self objectValue] integerValue] * M_PI) / 180.0f);
                self._lastChangedAngle = 0;
            }
        }
        else{
            self._lastPosition = CGPointZero;
            self._lastChangedAngle = 0;
            
        }
    }
    
    if (sender.state == UIGestureRecognizerStateEnded) {
        self._lastPosition = CGPointZero;
        self._lastChangedAngle = 0;
    }
}
-(CGFloat)angleBetweenCenterPoint:(CGPoint)centerPoint point1:(CGPoint)p1 point2:(CGPoint)p2{
    CGPoint v1 = CGPointMake(p1.x - centerPoint.x, p1.y - centerPoint.y);
	CGPoint v2 = CGPointMake(p2.x - centerPoint.x, p2.y - centerPoint.y);
	
	CGFloat angle = atan2f(v2.x*v1.y - v1.x*v2.y, v1.x*v2.x + v1.y*v2.y);
	
	return angle;
}
- (CGPoint)pointFromPoint:(CGPoint)origin withDistance:(float)distance towardAngle:(float)angle
{
    double radAngle = angle * M_PI / 180.0;
    return CGPointMake(origin.x + distance * cos(radAngle), origin.y + distance * sin(radAngle));
}

- (void) increaseValueBy:(int) val{
    
    int newVal = (int)[self.objectValue integerValue] + val;
    if (newVal>[self maxValue]) {
        newVal = [self maxValue];
    }
    if (newVal<[self minValue]) {
        newVal = [self minValue];
    }
    [self setValue:newVal];
}

-(void) setValue:(int) value{
    if (value < [self minValue]) {
        return;
    }
    [self setObjectValue:[NSString stringWithFormat:@"%d", value]];
    switch (self.mode) {
        case DKTunerModeNormal:{
            [[self valueLabel] setText:[self objectValue]];
            break;
        }
        case DKTunerModeTime:{
            int minutes = (int)[self.objectValue integerValue] / 60;
            int seconds = [self.objectValue integerValue] % 60;
            [[self valueLabel] setText:[NSString stringWithFormat:@"%02d:%02d",minutes,seconds]];
            break;
        }
        case DKTunerModeValues:{
            [[self valueLabel] setText:[self.avaliableValues objectAtIndex:(value-1)]];
            break;
        }
        default:
            [[self valueLabel] setText:[self objectValue]];
            break;
    }
    
}

-(void) show{
    [[self superview] bringSubviewToFront:self];
    [self setUserInteractionEnabled:YES];
    [[self sliderImageView] setHidden:NO];
    [[self valueLabel] setHidden:NO];
    [[self descriptionLabel] setHidden:NO];
    
}

-(void) hide{
    [self setUserInteractionEnabled:NO];
    [[self sliderImageView] setHidden:YES];
    [[self valueLabel] setHidden:YES];
    [[self descriptionLabel] setHidden:YES];
}

-(NSString *)getValue{
    return [self objectValue];
}

@end
