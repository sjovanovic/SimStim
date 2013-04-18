//
//  Picker.m
//  skinScan3
//
//  Created by Slobodan Jovanovic on 2.4.12..
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Picker.h"

@implementation Picker
- (id) initWithView: (NGLView*)view andCamera:(NGLCamera*)camera {
    self = [super init];
    if (self != nil) {
        _view = view;
        _camera = camera;
        //_meshes = [NSMutableArray alloc];
        _clones = [[NGLGroup3D alloc] init];
        // define pick shaders
        NSString *vShader = @"\
        varying lowp vec4 color;\
        void main()\
        {\
        gl_Position = u_nglMVPMatrix * a_nglPosition;\
        color = vec4((a_nglPosition.x+1.0)*0.5, (a_nglPosition.y+1.0)*0.5, (a_nglPosition.z+1.0)*0.5, 1.0);\
        }";
        NSString *pShader = @"\
        varying lowp vec4 color;\
        void main(void)\
        { \
        gl_FragColor = color;\
        }";
        _pickShaders = [NGLShaders shadersWithSourceVertex:vShader andFragment:pShader];
    }
    return self;
}
- (void) addPickableMesh:(NGLMesh*)mesh{
    //[_meshes addObject:mesh];
    [_meshes addObject:mesh];
    NGLMesh *clone = [mesh copy];
    clone.tag = [mesh tag];
    // attach shaders
    clone.shaders = _pickShaders;
    [clone compileCoreMesh];
    // add the clone
    [_clones addObject:clone];
    [_camera addMesh:clone];
    
}

- (void) addObject:(NGLObject3D *)object{
    [super addObject:object];
    NGLMesh *clone = (NGLMesh *)[object copy];
    // attach shaders
    clone.shaders = _pickShaders;
    [clone compileCoreMesh];
    //[_clones addObject:clone];
    /*clone.tag = [object tag];
    clone.visible = FALSE;
    
    // add the clone
    [_clones addObject:clone];
    [_camera addMesh:clone];
     */
}

-(NGLvec3)getPickCoords:(int)xx andY:(int)yy
{
    /*for (int i = 0; i < [_meshes count]; i++) {
        NGLMesh* m = [_meshes objectAtIndex: i];
        m.visible = FALSE;
    }*/
    
    NGLMesh * mesh;
    while((mesh = (NGLMesh*)[self nextIterator])){
        mesh.visible = FALSE;
        int tag = [mesh tag];
        if([_clones hasObjectWithTag:tag]){
            NGLMesh * clone = (NGLMesh*)[_clones objectWithTag:tag];
            clone.visible = TRUE;
            clone.x = mesh.x;
            clone.y = mesh.y;
            clone.z = mesh.z;
            clone.rotateX = mesh.rotateX;
            clone.rotateY = mesh.rotateY;
            clone.rotateZ = mesh.rotateZ;
            clone.scaleX = mesh.scaleX;
            clone.scaleY = mesh.scaleY;
            clone.scaleZ = mesh.scaleZ;
        }
    }
    
    NGLvec3 res = [self getRGBAsFromImage:[_view drawToImage] atX:xx andY:yy count:1];
    
    while((mesh = (NGLMesh*)[self nextIterator])){
        mesh.visible = TRUE;
        int tag = [mesh tag];
        if([_clones hasObjectWithTag:tag]){
            NGLMesh * clone = (NGLMesh*)[_clones objectWithTag:tag];
            clone.visible = FALSE;
        }
    }

        
    return res;
}
- (NGLvec3)getRGBAsFromImage:(UIImage*)image atX:(int)xx andY:(int)yy count:(int)count
{
    //NSMutableArray *result = [NSMutableArray arrayWithCapacity:count];
    NGLvec3 result;
    // First get the image into your data buffer
    CGImageRef imageRef = [image CGImage];
    NSUInteger width = CGImageGetWidth(imageRef);
    NSUInteger height = CGImageGetHeight(imageRef);
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    unsigned char *rawData = (unsigned char*) calloc(height * width * 4, sizeof(unsigned char));
    NSUInteger bytesPerPixel = 4;
    NSUInteger bytesPerRow = bytesPerPixel * width;
    NSUInteger bitsPerComponent = 8;
    CGContextRef context = CGBitmapContextCreate(rawData, width, height,
                                                 bitsPerComponent, bytesPerRow, colorSpace,
                                                 kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big);
    CGColorSpaceRelease(colorSpace);
    CGContextDrawImage(context, CGRectMake(0, 0, width, height), imageRef);
    CGContextRelease(context);
    // Now your rawData contains the image data in the RGBA8888 pixel format.
    int byteIndex = (bytesPerRow * yy) + xx * bytesPerPixel;
    for (int ii = 0 ; ii < count ; ++ii)
    {
        CGFloat red = (rawData[byteIndex]     * 1.0) / 255.0;
        CGFloat green = (rawData[byteIndex + 1] * 1.0) / 255.0;
        CGFloat blue  = (rawData[byteIndex + 2] * 1.0) / 255.0;
        //CGFloat alpha = (rawData[byteIndex + 3] * 1.0) / 255.0;
        byteIndex += 4;
        // unpack
        result = (NGLvec3){
            (red*2.0-1.0), 
            (green*2.0-1.0), 
            (blue*2.0-1.0)
        };
        // end unpack
    }
    
    free(rawData);
    return result;
}

@end
