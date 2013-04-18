//
//  AnimView.h
//  Third Lesson
//
//  Created by Slobodan Jovanovic on 24.1.12..
//  Copyright (c) 2012 DB-Interactive. All rights reserved.
//

#import <NinevehGL/NinevehGL.h>
#import "PickView.h"
#import "PickableView.h"
 
@interface AnimView : NGLView <NGLViewDelegate> {
    NGLMesh *mesh;
    NGLMesh *cube;
	NGLCamera *camera;
    
    float distance;
	CGPoint position;
    
    
    NGLvec4 color;
    NGLTexture *texture;
    
    UIImage *_image;
    
    float tx;
    float ty;
    float tz;
    
    bool skip;
    
    PickView *pickview;
    
    NSTimeInterval touchStartTime;
    
    
    PickableView *pickable;
}

-(NSArray*)getRGBAsFromImage:(UIImage*)image atX:(int)xx andY:(int)yy count:(int)count;

@end
