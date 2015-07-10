#import <Foundation/Foundation.h>
#import "MLPAutoCompleteTextField/MLPAutoCompleteTextField.h"
#import "AutoCompleteView.h"
#import "RCTViewManager.h"
#import "RCTBridge.h"
#import "UIView+React.h"
#import "RCTConvert.h"
#import "RCTEventDispatcher.h"
#import "RCTUtils.h"


@implementation AutoCompleteView
{
  RCTEventDispatcher *_eventDispatcher;
}

@synthesize suggestions = _suggestions;  //Must do this

- (void) setSuggestions:(NSArray *)n {
  if (self.handler) {
    self.handler(n);
  }
}

- (instancetype)initWithEventDispatcher:(RCTEventDispatcher *)eventDispatcher
{
  
  if ((self = [super initWithFrame:CGRectMake(10, 200, 300, 40)])) {
    _eventDispatcher = eventDispatcher;
    [self addTarget:self action:@selector(_textFieldDidChange) forControlEvents:UIControlEventEditingChanged];
  }
  
  return self;
}

#define RCT_TEXT_EVENT_HANDLER(delegateMethod, eventName) \
- (void)delegateMethod                                    \
{                                                         \
  [_eventDispatcher sendTextEventWithType:eventName       \
  reactTag:self.reactTag                                  \
  text:self.text];                                        \
}

RCT_TEXT_EVENT_HANDLER(_textFieldDidChange, RCTTextEventTypeChange)



@end