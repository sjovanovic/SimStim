//
//  AnimView.m
//  Third Lesson
//
//  Created by Slobodan Jovanovic on 24.1.12..
//  Copyright (c) 2012 DB-Interactive. All rights reserved.
//

#import "AnimView.h"

@implementation AnimView


- (id) initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self != nil) {
        
        
        /*
        
        
        nglGlobalColor(nglColorMake(0, 0, 0, 0));
        
        
        
        self.multipleTouchEnabled = YES;
        
        
        
        
        NSDictionary *settings = [NSDictionary dictionaryWithObjectsAndKeys:
                                  kNGLMeshOriginalYes, kNGLMeshKeyOriginal,
                                  kNGLMeshCentralizeYes, kNGLMeshKeyCentralize,
                                  @"1.0", kNGLMeshKeyNormalize,
                                  nil];
        mesh = [[NGLMesh alloc] initWithFile:@"base-female-nude.obj" settings:settings delegate:nil];
        
        
        
        pickable = [[PickableView alloc] initWithFrame:frame];
        pickable.hidden = TRUE;
        [self addSubview:pickable];
        [pickable addMesh:mesh];
        
         
        pickview = [[PickView alloc] initWithFrame:frame];
        pickview.hidden = TRUE;
        [self addSubview:pickview];
        
        
                
        
        cube = [[NGLMesh alloc] initWithFile:@"sphere.obj" settings:settings delegate:nil];
       
        
        NGLMaterial *material = [NGLMaterial materialRuby];
        [cube setMaterial:material];
        [cube compileCoreMesh];
        
        cube.visible = FALSE;
        
        cube.scaleX = 0.05;
        cube.scaleY = 0.05;
        cube.scaleZ = 0.05;
        
        
        
        camera = [[NGLCamera alloc] initWithMeshes:mesh, cube, nil];
        [camera autoAdjustToScreen:YES animated:YES];
        
        
        */
        
        
        // Starts the debug monitor.
        //[[NGLDebug debugMonitor] startWithView:(NGLView *)self mesh:mesh];
        
        //NSLog(@"structures:  = %f", mesh.structures);
        
        
        
        
        
    }
    return self;
}


- (void) drawView
{
    //mesh.rotateX += position.y;
    mesh.rotateY += position.x;
    mesh.y -= position.y*0.001;
    mesh.z += distance;
    
    //[pickview rotateX:mesh.rotateX];
    [pickview rotateY:mesh.rotateY];
    [pickview y:mesh.y];
    [pickview z:mesh.z];
    
    
    NGLvec3 res = nglVec3ByMatrix((NGLvec3){[pickview getTX], [pickview getTY], [pickview getTZ]}, *mesh.matrixMVInverse);
    cube.x = res.x + mesh.x;
    cube.y = res.y + mesh.y;
    cube.z = res.z + mesh.z;
    
    /*
    NGLvec3 res = nglVec3ByMatrix((NGLvec3){[pickview getTX], [pickview getTY], [pickview getTZ]}, *mesh.matrixMVInverse);
    tx = res.x;
    ty = res.y;
    tz = res.z;
     */
    
     
    [camera drawCamera];
        
    position.x = 0.0;
    position.y = 0.0;
    distance = 0.0;
    
}

// Touch stuff

- (float) distanceFromPoint:(CGPoint)pointA toPoint:(CGPoint)pointB
{
	float xD = fabs(pointA.x - pointB.x);
	float yD = fabs(pointA.y - pointB.y);
	
	return sqrt(xD*xD + yD*yD);
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    touchStartTime = [event timestamp];
    //cube.visible = FALSE;
}

- (void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
	UITouch *touchA, *touchB;
	CGPoint pointA, pointB;
	
	// Pan gesture.
	if ([touches count] == 1)
	{
		touchA = [[touches allObjects] objectAtIndex:0];
		pointA = [touchA locationInView:self];
		pointB = [touchA previousLocationInView:self];
		
		position.x = (pointA.x - pointB.x);
		position.y = (pointA.y - pointB.y);
	}
	// Pinch gesture.
	else if ([touches count] == 2)
	{
		touchA = [[touches allObjects] objectAtIndex:0];
		touchB = [[touches allObjects] objectAtIndex:1];
		
		// Current distance.
		pointA = [touchA locationInView:self];
		pointB = [touchB locationInView:self];
		float currDistance = [self distanceFromPoint:pointA toPoint:pointB];
		
		// Previous distance.
		pointA = [touchA previousLocationInView:self];
		pointB = [touchB previousLocationInView:self];
		float prevDistance = [self distanceFromPoint:pointA toPoint:pointB];
		
		distance = (currDistance - prevDistance) * 0.005;
	}
}

-(void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
	NSSet* allTouches = [event allTouches];
	UITouch*touch1 = [[allTouches allObjects] objectAtIndex:0];
	CGPoint touch1Point = [touch1 locationInView:self];
    
    if ([touches count] == 1)
	{
        NSTimeInterval touchTimeDuration = [event timestamp] - touchStartTime;
        if(touchTimeDuration < 0.2){ // just a tap - no pan - no pinch
            
            pickview.hidden = FALSE;
            NGLvec3 pc = [pickview getPickCoords:touch1Point.x andY:touch1Point.y];
            pickview.hidden = TRUE;
            
            //pickable.hidden = FALSE;
            //NGLvec3 pc = [picker getPickCoords:touch1Point.x andY:touch1Point.y];
            //pickable.hidden = TRUE;
            
                cube.visible = TRUE;
                cube.x = pc.x;
                cube.y = pc.y;
                cube.z = pc.z;
            
        }
    }
    
    //NSLog(@"Touch Coords: X: %f Y: %f", touch1Point.x, touch1Point.y);
	
    //skip = 1.0;
    //[self getRGBAsFromImage:[(NGLView *)self drawToImage] atX:touch1Point.x andY:touch1Point.y count:1];
    //skip = 0.0;
    
    
    //[pickview setPickCoords:touch1Point.x andY:touch1Point.y];
    
}

- (NSArray*)getRGBAsFromImage:(UIImage*)image atX:(int)xx andY:(int)yy count:(int)count
{
    NSMutableArray *result = [NSMutableArray arrayWithCapacity:count];
    
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
        CGFloat alpha = (rawData[byteIndex + 3] * 1.0) / 255.0;
        byteIndex += 4;
        
        
        // unpack coords
        tx = (red*2.0-1.0);
        ty = (green*2.0-1.0);
        tz = (blue*2.0-1.0);
        
        NGLvec3 res = nglVec3ByMatrix((NGLvec3){tx, ty, tz}, *mesh.matrixMVInverse);
        
        tx = tx + mesh.x;
        ty = ty + mesh.y;
        tz = tz + mesh.z;
                
        cube.x = res.x + mesh.x;
        cube.y = res.y + mesh.y;
        cube.z = res.z + mesh.z;
        // end unpack
        
        
        UIColor *acolor = [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
        
        [result addObject:acolor];
    }
    
    free(rawData);
    
    return result;
}

- (float)randomFloatBetween:(float)smallNumber and:(float)bigNumber {
    float diff = bigNumber - smallNumber;
    return (((float) (arc4random() % ((unsigned)RAND_MAX + 1)) / RAND_MAX) * diff) + smallNumber;
}



@end
