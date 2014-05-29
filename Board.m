//
//  RWTMushroom.m
//  HelloOpenGL
//
//  Created by Main Account on 3/23/14.
//  Copyright (c) 2014 Razeware LLC. All rights reserved.
//

#import "Board.h"
#import "boatd.h"

@implementation Board

- (instancetype)initWithShader:(RWTBaseEffect *)shader {
  if ((self = [super initWithName:"boatd" shader:shader vertices:(RWTVertex *)Cube_boardone_Vertices vertexCount:sizeof(Cube_boardone_Vertices) / sizeof(Cube_boardone_Vertices[0])])) {
    
    [self loadTexture:@"boardred.png"];
     
    //self.rotationY = M_PI;
    //self.rotationX = M_PI_2;
    self.scale = 1;
    self.position = GLKVector3Make(0.7, 3, 0);
      //
      self.matAmbientColor = GLKVector3Make(Cube_boardone_ambient.r, Cube_boardone_ambient.g, Cube_boardone_ambient.b);
      self.matDiffuseColor = GLKVector3Make(Cube_boardone_diffuse.r, Cube_boardone_diffuse.g, Cube_boardone_diffuse.b);
      self.matSpecularColor = GLKVector3Make(Cube_boardone_specular.r, Cube_boardone_specular.g, Cube_boardone_specular.b);
      self.shininess = Cube_boardone_shininess;
    
  }
  return self;
}


- (void)updateWithDelta:(NSTimeInterval)aDelta {
    self.rotationX += M_PI * aDelta;
   self.position = GLKVector3Make(0.7, self.position.y - 0.02, 0);
    if (self.position.y <= -3.0) {
        self.position = GLKVector3Make(0.7, 3, 0);
    }

}

@end
