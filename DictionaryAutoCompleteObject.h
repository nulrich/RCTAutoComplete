#import <Foundation/Foundation.h>
#import "MLPAutoCompletionObject.h"

@interface DictionaryAutoCompleteObject : NSObject <MLPAutoCompletionObject>
    @property (strong) NSDictionary *json;

    - (id)initWithDictionnary:(NSDictionary *)json;
@end
