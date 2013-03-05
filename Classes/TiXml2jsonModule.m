/**
 * Your Copyright Here
 *
 * Appcelerator Titanium is Copyright (c) 2009-2010 by Appcelerator, Inc.
 * and licensed under the Apache Public License (version 2)
 */
#import "TiXml2jsonModule.h"
#import "TiBase.h"
#import "TiHost.h"
#import "TiUtils.h"
#import "XMLReader.h"

@implementation TiXml2jsonModule

#pragma mark Internal

// this is generated for your module, please do not change it
-(id)moduleGUID
{
	return @"15a9a727-d76d-43cb-ba92-b344a3d83115";
}

// this is generated for your module, please do not change it
-(NSString*)moduleId
{
	return @"ti.xml2json";
}

#pragma mark Lifecycle

-(void)startup
{
	// this method is called when the module is first loaded
	// you *must* call the superclass
	[super startup];
    dispatchQueue = dispatch_queue_create("ti.xml2json.dispatch.queue", NULL);
	
	NSLog(@"[INFO] %@ loaded",self);
}

-(void)shutdown:(id)sender
{
	// this method is called when the module is being unloaded
	// typically this is during shutdown. make sure you don't do too
	// much processing here or the app will be quit forceably
	
	// you *must* call the superclass
	[super shutdown:sender];
}

#pragma mark Cleanup 

-(void)dealloc
{
	// release any resources that have been retained by the module
    dispatch_release(dispatchQueue);
	[super dealloc];
}

#pragma mark Internal Memory Management

-(void)didReceiveMemoryWarning:(NSNotification*)notification
{
	// optionally release any resources that can be dynamically
	// reloaded once memory is available - such as caches
	[super didReceiveMemoryWarning:notification];
}


#pragma Public APIs

-(id)convertXml:(id)arg
{
    if ([arg isKindOfClass:[NSString class]]) {
        NSError *error = nil;
        NSDictionary *result = [XMLReader dictionaryForXMLString:arg error:&error];
        if (error) {
            [self throwException:@"Something went wrong converting xml" subreason:error.localizedDescription location:CODELOCATION];
        }
        return result;
    }
    else if ([arg isKindOfClass:[TiBlob class]]) {
        NSError *error = nil;
        NSDictionary *result = [XMLReader dictionaryForXMLData:((TiBlob*)arg).data error:&error];
        if (error) {
            [self throwException:@"Something went wrong converting xml" subreason:error.localizedDescription location:CODELOCATION];
        }
        return result;
    }
    else {
        [self throwException:@"Expected blob or string argument" subreason:nil location:CODELOCATION];
    }

}

-(id)convert:(id)args
{
    ENSURE_ARG_COUNT(args, 1);
    
    id arg = [args objectAtIndex:0];
    
    return [self convertXml:arg];
    
}

-(void)convertAsync:(id)args
{
    ENSURE_ARG_COUNT(args, 2);
    
    id arg = [args objectAtIndex:0];
    KrollCallback *cb = [args objectAtIndex:1];
    ENSURE_TYPE(cb, KrollCallback);
    
    //pass just the first (string|blob) arg to convertXml()
    
    dispatch_async(dispatchQueue, ^(void) {
        id result = [self convertXml:arg];
        NSDictionary *cbArgs = [NSDictionary dictionaryWithObject:result forKey:@"json"];
        
        [self _fireEventToListener:@"success" withObject:cbArgs listener:cb thisObject:nil];  
    });
}


@end
