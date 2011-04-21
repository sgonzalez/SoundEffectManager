//
//  SoundEffectManager.h
//
//  Copyright 2011 Hicaduda. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AudioToolbox/AudioToolbox.h>


@interface SoundEffectManager : NSObject {
    
}
+ (void)preloadSoundNamed:(NSString *)soundName;
+ (void)playSoundNamed:(NSString *)soundName;
@end
