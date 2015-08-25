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
  
  if ((self = [super initWithFrame:CGRectZero])) {
    _eventDispatcher = eventDispatcher;
    [self addTarget:self action:@selector(_textFieldDidChange) forControlEvents:UIControlEventEditingChanged];
    [self addTarget:self action:@selector(_textFieldBeginEditing) forControlEvents:UIControlEventEditingDidBegin];
  }
  
  return self;
}

- (void)setAutoCorrect:(BOOL)autoCorrect
{
    self.autocorrectionType = (autoCorrect ? UITextAutocorrectionTypeYes : UITextAutocorrectionTypeNo);
}

- (BOOL)autoCorrect
{
    return self.autocorrectionType == UITextAutocorrectionTypeYes;
}


#define RCT_TEXT_EVENT_HANDLER(delegateMethod, eventName) \
- (void)delegateMethod                                    \
{                                                         \
  [_eventDispatcher sendTextEventWithType:eventName       \
  reactTag:self.reactTag                                  \
  text:self.text                                         \
    eventCount:1];                                        \
}

RCT_TEXT_EVENT_HANDLER(_textFieldDidChange, RCTTextEventTypeChange)
RCT_TEXT_EVENT_HANDLER(_textFieldBeginEditing, RCTTextEventTypeFocus)

- (BOOL)resignFirstResponder
{
    BOOL result = [super resignFirstResponder];
    if (result) {
        [_eventDispatcher sendTextEventWithType:RCTTextEventTypeBlur
                                       reactTag:self.reactTag
                                           text:self.text
                                            eventCount:1];
    }
    return result;
}
@end
