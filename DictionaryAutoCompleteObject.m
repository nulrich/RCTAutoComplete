#import "DictionaryAutoCompleteObject.h"

@interface DictionaryAutoCompleteObject ()
@end

@implementation DictionaryAutoCompleteObject


- (id)initWithDictionnary:(NSDictionary *)json
{
    self = [super init];
    if (self) {
        [self setJson:json];
    }
    return self;
}

#pragma mark - MLPAutoCompletionObject Protocol

- (NSString *)autocompleteString
{
    return @"";
}

@end
