//
//  PickView.m
//  skinScan3
//
//  Created by Slobodan Jovanovic on 20.3.12..
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PickView.h"

@implementation PickView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // initiate vars
        tx = 0.0;
        ty = 0.0;
        tz = 0.0;
        px = 0.0;
        py = 0.0;
        pz = 0.0;
        
        self.multipleTouchEnabled = YES;
        
        NSDictionary *settings = [NSDictionary dictionaryWithObjectsAndKeys:
                                  kNGLMeshOriginalYes, kNGLMeshKeyOriginal,
                                  kNGLMeshCentralizeYes, kNGLMeshKeyCentralize,
                                  @"1.0", kNGLMeshKeyNormalize,
                                  nil];
        mesh = [[NGLMesh alloc] initWithFile:@"base-female-nude.obj" settings:settings delegate:nil];
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
        NGLShaders *shadersSource = [NGLShaders shadersWithSourcesVertex:vShader andFragment:pShader];
        //NGLShaders *shadersSource = [NGLShaders shadersWithSourceVertex:vShader andFragment:pShader];
        mesh.shaders = shadersSource;
        [mesh compileCoreMesh];
        
        camera = [[NGLCamera alloc] initWithMeshes:mesh, nil];
        //[camera autoAdjustToScreen:YES animated:YES];
        [camera autoAdjustAspectRatio:YES animated:YES];
        
    }
    return self;
}

- (void) drawView
{
    [camera drawCamera];
}

-(NGLvec3)getPickCoords:(int)xx andY:(int)yy
{
    return [self getRGBAsFromImage:[(NGLView *)self drawToImage] atX:xx andY:yy count:1];
}

-(void)setPickCoords:(int)xx andY:(int)yy
{
    [self getRGBAsFromImage:[(NGLView *)self drawToImage] atX:xx andY:yy count:1];
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
        
        // unpack coords
        tx = (red*2.0-1.0);
        ty = (green*2.0-1.0);
        tz = (blue*2.0-1.0);
        
        NGLvec3 res = nglVec3ByMatrix((NGLvec3){tx, ty, tz}, *mesh.matrixMVInverse);
        
        //tx = tx + mesh.x;
        //ty = ty + mesh.y;
        //tz = tz + mesh.z;
        
        //NSLog(@"Tx: %f Ty: %f Tz: %f", tx, ty, tz);
        
        px = res.x + mesh.x;
        py = res.y + mesh.y;
        pz = res.z + mesh.z;
        
        result = (NGLvec3){px, py, pz};
        
        // end unpack
        
        
        //UIColor *acolor = [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
        
        //[result addObject:acolor];
    }
    
    free(rawData);
    return result;
}



-(float)px
{
    return px;
};
-(void)setPx:(float)c
{
    px = c;
};

-(float)py
{
    return py;
};
-(void)setPy:(float)c
{
    py = c;
};

-(float)pz
{
    return pz;
};
-(void)setPz:(float)c
{
    pz = c;
};



-(float)getPX
{
    return px;
};
-(float)getPY;
{
    return py;
};

-(float)getPZ;
{
    return pz;
};

-(float)getTX;
{
    return tx;
};

-(float)getTY;
{
    return ty;
};

-(float)getTZ{
    return tz;
};

-(void)x:(float)c
{
    mesh.x = c;
};
-(void)y:(float)c
{
    mesh.y = c;
};
-(void)z:(float)c
{
    mesh.z = c;
};
-(void)rotateX:(float)c
{
    mesh.rotateX = c;
};
-(void)rotateY:(float)c
{
    mesh.rotateY = c;
};
-(void)rotateZ:(float)c
{
    mesh.rotateZ = c;
};

@end
