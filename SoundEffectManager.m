//
//  SoundEffectManager.m
//
//  Copyright 2011 Hicaduda. All rights reserved.
//

#import "SoundEffectManager.h"

@implementation SoundEffectManager

static SystemSoundID GetSound( NSString *name ) {
    static NSMutableDictionary *sSoundIDs;
    NSNumber *soundIDObj = [sSoundIDs objectForKey: name];
    if( ! soundIDObj ) {
        NSLog(@"Loading sound '%@'",name);
        NSString *type = name.pathExtension;
        if( ! type.length )
            type = @"aiff";
        name = name.stringByDeletingPathExtension;
        
        NSString *path = [[NSBundle mainBundle] pathForResource: name
                                                         ofType: type];
        NSURL *url;
        if( path )
            url = [NSURL fileURLWithPath: path];
        else {
            NSLog(@"Couldn't find sound %@",name);
            return 0;
        }
        SystemSoundID soundID;
        if( AudioServicesCreateSystemSoundID((CFURLRef)url,&soundID) != noErr ) {
            NSLog(@"Couldn't load sound %@",url);
            return 0;
        }
        
        soundIDObj = [NSNumber numberWithUnsignedInt: soundID];
        if( ! sSoundIDs )
            sSoundIDs = [[NSMutableDictionary alloc] init];
        [sSoundIDs setObject: soundIDObj forKey: name];
    }
    return [soundIDObj unsignedIntValue];
}

+ (void)playSoundNamed:(NSString *)soundName {	
	AudioServicesPlaySystemSound( GetSound(soundName) );
}

+ (void)preloadSoundNamed:(NSString *)soundName {
	(void) GetSound(soundName);
}

@end
