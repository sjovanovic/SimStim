//
//  Picker.h
//  skinScan3
//
//  Created by Slobodan Jovanovic on 2.4.12..
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <NinevehGL/NinevehGL.h>

@interface Picker : NGLGroup3D {
    NGLView * _view;
    NGLCamera * _camera;
    //NSMutableArray *_meshes;
    NGLGroup3D *_meshes;
    NGLGroup3D *_clones;
    NGLShaders *_pickShaders;
}
- (id) initWithView: (NGLView*)view andCamera:(NGLCamera*)camera;
-(void) addPickableMesh:(NGLMesh*)mesh;
-(NGLvec3)getPickCoords:(int)xx andY:(int)yy;
-(NGLvec3)getRGBAsFromImage:(UIImage*)image atX:(int)xx andY:(int)yy count:(int)count;
@end
