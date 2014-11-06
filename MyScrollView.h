//
//  MyScrollView.h
//  UIDay12
//
//  Created by qianfeng on 14-9-18.
//  Copyright (c) 2014年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BnsModel.h"

@interface MyScrollView : UIView <UIScrollViewDelegate>
{
    UIScrollView *_scrollView;
    UIImageView *_curImageView;
    UILabel *_labelTitle;
    
    UIPageControl *_pageCtrl;
    
    int _totalPages;
    int _curPages;
    CGRect _scrollFrame;
    
    NSArray *_imagesArray;
    NSMutableArray *_curImages;
}

-(int)validPageValue:(NSInteger)value;
-(id)initWithFrame:(CGRect)frame andPictures:(NSArray *)pictureArray;
-(NSArray *)getDisplayImagesWithCurpage:(int)page;
-(void)refreshScrollView;

@end
