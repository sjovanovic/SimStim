//
//  PickView.h
//  skinScan3
//
//  Created by Slobodan Jovanovic on 20.3.12..
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <NinevehGL/NinevehGL.h>

@interface PickView : NGLView{
    NGLMesh *mesh;
    NGLCamera *camera;
    
    // picked transformed coordinates
    float px;
    float py;
    float pz;
    
    // picked on mesh coordinates
    float tx;
    float ty;
    float tz;
    
}


@property (nonatomic) float px;
@property (nonatomic) float py;
@property (nonatomic) float pz;

-(float)getPX;
-(float)getPY;
-(float)getPZ;

-(float)getTX;
-(float)getTY;
-(float)getTZ;


-(void)x:(float)c;
-(void)y:(float)c;
-(void)z:(float)c;
-(void)rotateX:(float)c;
-(void)rotateY:(float)c;
-(void)rotateZ:(float)c;


-(NGLvec3)getRGBAsFromImage:(UIImage*)image atX:(int)xx andY:(int)yy count:(int)count;
-(void)setPickCoords:(int)xx andY:(int)yy;
-(NGLvec3)getPickCoords:(int)xx andY:(int)yy;

@end
