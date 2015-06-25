#import <UIKit/UIKit.h>
#import "MLPAutoCompleteTextField/MLPAutoCompleteTextField.h"

@class RCTEventDispatcher;


@interface AutoCompleteView : MLPAutoCompleteTextField <UITextFieldDelegate>
  @property (retain, nonatomic) NSArray *suggestions;
  @property (copy) void (^handler)(NSArray *);

- (instancetype)initWithEventDispatcher:(RCTEventDispatcher *)eventDispatcher NS_DESIGNATED_INITIALIZER;

@end