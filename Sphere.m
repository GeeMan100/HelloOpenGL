//
//  RWTMushroom.m
//  HelloOpenGL
//
//  Created by Main Account on 3/23/14.
//  Copyright (c) 2014 Razeware LLC. All rights reserved.
//

#import "Sphere.h"
#import "sphere7.h"

@implementation Sphere

- (instancetype)initWithShader:(RWTBaseEffect *)shader {
  if ((self = [super initWithName:"sphere7" shader:shader vertices:(RWTVertex *)Sphere_sphere_Vertices vertexCount:sizeof(Sphere_sphere_Vertices) / sizeof(Sphere_sphere_Vertices[0])])) {
    
    [self loadTexture:@"sphere2.png"];
     
    self.rotationY = M_PI;
    self.rotationX = M_PI_2;
    self.scale = 0.1;
    
      //
      self.matAmbientColor = GLKVector3Make(Sphere_sphere_ambient.r, Sphere_sphere_ambient.g, Sphere_sphere_ambient.b);
      self.matDiffuseColor = GLKVector3Make(Sphere_sphere_diffuse.r, Sphere_sphere_diffuse.g, Sphere_sphere_diffuse.b);
      self.matSpecularColor = GLKVector3Make(Sphere_sphere_specular.r, Sphere_sphere_specular.g, Sphere_sphere_specular.b);
      self.shininess = Sphere_sphere_shininess;
    
  }
  return self;
}


- (void)updateWithDelta:(NSTimeInterval)aDelta {
    self.rotationZ += M_PI * aDelta;
   
}

@end
