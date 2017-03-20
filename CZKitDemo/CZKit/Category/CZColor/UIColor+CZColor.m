//
//  UIColor+CZColor.m
//  CZColorDemo
//
//  Created by Apple on 2017/3/20.
//  Copyright © 2017年 Clay Zhu. All rights reserved.
//

#import "UIColor+CZColor.h"

@implementation UIColor (CZColor)

+ (CGFloat)colorComponentFrom:(NSString *)string start:(NSUInteger)start length:(NSUInteger)length {
	NSString *substring = [string substringWithRange: NSMakeRange(start, length)];
	NSString *fullHex = length == 2 ? substring : [NSString stringWithFormat:@"%@%@", substring, substring];
	unsigned hexComponent;
	[[NSScanner scannerWithString: fullHex] scanHexInt:&hexComponent];
	return hexComponent / 255.0;
}

+ (UIColor *)colorWithHexString:(NSString *)hexString {
	NSString *colorString = [[hexString stringByReplacingOccurrencesOfString:@"#" withString:@""] uppercaseString];
	CGFloat alpha, red, blue, green;
	switch ([colorString length]) {
		case 3: // #RGB
			alpha = 1.0f;
			red   = [self colorComponentFrom:colorString start:0 length:1];
			green = [self colorComponentFrom:colorString start:1 length:1];
			blue  = [self colorComponentFrom:colorString start:2 length:1];
			break;
		case 4: // #ARGB
			alpha = [self colorComponentFrom:colorString start:0 length:1];
			red   = [self colorComponentFrom:colorString start:1 length:1];
			green = [self colorComponentFrom:colorString start:2 length:1];
			blue  = [self colorComponentFrom:colorString start:3 length:1];
			break;
		case 6: // #RRGGBB
			alpha = 1.0f;
			red   = [self colorComponentFrom:colorString start:0 length:2];
			green = [self colorComponentFrom:colorString start:2 length:2];
			blue  = [self colorComponentFrom:colorString start:4 length:2];
			break;
		case 8: // #AARRGGBB
			alpha = [self colorComponentFrom:colorString start:0 length:2];
			red   = [self colorComponentFrom:colorString start:2 length:2];
			green = [self colorComponentFrom:colorString start:4 length:2];
			blue  = [self colorComponentFrom:colorString start:6 length:2];
			break;
		default:
			[NSException raise:@"Invalid color value" format:@"Color value %@ is invalid. It should be a hex value of the form #RBG, #ARGB, #RRGGBB, or #AARRGGBB.", hexString];
			break;
	}
	return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}

+ (UIColor *)colorWithHexString:(NSString *)hexString alpha:(CGFloat)alpha {
	NSString *colorString = [[hexString stringByReplacingOccurrencesOfString:@"#" withString:@""] uppercaseString];
	CGFloat red, blue, green;
	switch ([colorString length]) {
		case 3:	// #RGB
			red   = [self colorComponentFrom:colorString start:0 length:1];
			green = [self colorComponentFrom:colorString start:1 length:1];
			blue  = [self colorComponentFrom:colorString start:2 length:1];
			break;
		case 6:	// #RRGGBB
			red   = [self colorComponentFrom:colorString start:0 length:2];
			green = [self colorComponentFrom:colorString start:2 length:2];
			blue  = [self colorComponentFrom:colorString start:4 length:2];
			break;
		default:
			[NSException raise:@"Invalid color value" format:@"Color value %@ is invalid. It should be a hex value of the form #RBG, or #RRGGBB.", hexString];
			break;
	}
	return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}

+ (UIColor *)colorWithR:(CGFloat)r g:(CGFloat)g b:(CGFloat)b {
	return     [UIColor colorWithRed:r / 255.0  green:g / 255.0 blue:b / 255.0 alpha:1.0];
}

+ (UIColor *)colorWithR:(CGFloat)r g:(CGFloat)g b:(CGFloat)b alpha:(CGFloat)alpha {
	return [UIColor colorWithRed:r / 255.0  green:g / 255.0 blue:b / 255.0 alpha:alpha];
}

+ (UIColor *)randomColor {
	static BOOL seeded = NO;
	if (!seeded) {
		srand48(time(0));	// drand48 函数需要使用 srand48 来初始化随机数种子
		seeded = YES;
	}
	// drand48 函数会生成一个 0.0 – 1.0 的 double
	CGFloat r = (CGFloat)drand48();
	CGFloat g = (CGFloat)drand48();
	CGFloat b = (CGFloat)drand48();
	return [UIColor colorWithRed:r green:g blue:b alpha:1.0];
}

@end
