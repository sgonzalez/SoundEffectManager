//
//  Usage.m
//
//  Copyright 2011 Hicaduda. All rights reserved.
//

#import "SoundEffectManager.h" //Link against AudioToolbox.framework in project

//Playing a sound (chaches if not already chached)
[SoundEffectManager playSoundNamed:@"SoundEffect.aiff"];

//Preloading a sound (does NOT play it)
[SoundEffectManager preloadSoundNamed:@"MyOtherSoundEffect.aiff"];
