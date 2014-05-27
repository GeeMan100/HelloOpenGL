//
//  RWTMushroom.m
//  HelloOpenGL
//
//  Created by Main Account on 3/23/14.
//  Copyright (c) 2014 Razeware LLC. All rights reserved.
//

#import "cylinder.h"
#import "cylinderblue.h"

@implementation cylinder{
    
}

- (instancetype)initWithShader:(RWTBaseEffect *)shader {
  if ((self = [super initWithName:"cylinderblue" shader:shader vertices:(RWTVertex *)Cylinder_cylinder_Vertices vertexCount:sizeof(Cylinder_cylinder_Vertices) / sizeof(Cylinder_cylinder_Vertices[0])])) {
    
    [self loadTexture:@"cylinderblue.png"];
     
    self.rotationY = M_PI;
    self.rotationX = M_PI_2;
    self.scale = 0.075;
    
      //
      self.matAmbientColor = GLKVector3Make(Cylinder_cylinder_ambient.r, Cylinder_cylinder_ambient.g, Cylinder_cylinder_ambient.b);
      self.matDiffuseColor = GLKVector3Make(Cylinder_cylinder_diffuse.r, Cylinder_cylinder_diffuse.g, Cylinder_cylinder_diffuse.b);
      self.matSpecularColor = GLKVector3Make(Cylinder_cylinder_specular.r, Cylinder_cylinder_specular.g, Cylinder_cylinder_specular.b);
      self.shininess = Cylinder_cylinder_shininess;
  }
  return self;
}

- (void)updateWithDelta:(NSTimeInterval)aDelta
{
    self.rotationZ += M_PI * aDelta;
}

@end
