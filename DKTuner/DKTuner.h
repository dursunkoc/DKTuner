//
//  DKTuner.h
//  DKTuner
//
//  Created by dursun koc on 5/17/14.
//  Copyright (c) 2014 aric. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DKTuner : UIView<UIGestureRecognizerDelegate>
typedef NS_ENUM(NSInteger, DKTunerMode) {
    DKTunerModeNormal,
    DKTunerModeValues,
    DKTunerModeTime
};

- (id)initWithFrame:(CGRect)frame
         usingImage:(UIImage *)image
   usingDescription:(NSString *)description
           maxValue:(int) maxValue
           minValue:(int) minValue;

- (id)initWithFrame:(CGRect)frame
         usingImage:(UIImage *)image
   usingDescription:(NSString *)description
    descriptionFont:(UIFont *)descriptionFont
             values:(NSArray *)values
    backgroundColor:(UIColor *)color
          foreColor:(UIColor *)color
         objectFont:(UIFont *)objectFont;

- (id)initWithFrame:(CGRect)frame
         usingImage:(UIImage *)image
   usingDescription:(NSString *)description
    descriptionFont:(UIFont *)descriptionFont
           maxValue:(int) maxValue
           minValue:(int) minValue
    backgroundColor:(UIColor *)color
          foreColor:(UIColor *)color
         objectFont:(UIFont *)objectFont;

- (id)initWithFrame:(CGRect)frame
         usingImage:(UIImage *)image
   usingDescription:(NSString *)description
    descriptionFont:(UIFont *)descriptionFont
           maxValue:(int) maxValue
           minValue:(int) minValue
    backgroundColor:(UIColor *)color
          foreColor:(UIColor *)color
         objectFont:(UIFont *)objectFont
               mode:(DKTunerMode) mode;


-(void) setValue:(int) value;

-(NSString *) getValue;

-(void) show;
-(void) hide;

@end
