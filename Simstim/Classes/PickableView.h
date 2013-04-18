//
//  PickableView.h
//  skinScan3
//
//  Created by Slobodan Jovanovic on 2.4.12..
//  Copyright (c) 2012 Nanosoft. All rights reserved.
//

#import <NinevehGL/NinevehGL.h>

@interface PickableView : NGLView{
    NGLGroup3D *_group;
    NGLGroup3D *_clones;
	NGLCamera *_camera;
    NGLShaders *_pickShaders;
}
- (void) addMesh:(NGLMesh*)mesh;
-(NGLvec3)getPickCoords:(int)xx andY:(int)yy;
-(NGLvec3)getRGBAsFromImage:(UIImage*)image atX:(int)xx andY:(int)yy count:(int)count;
@end
