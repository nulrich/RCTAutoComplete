#import <UIKit/UIKit.h>
#import "MLPAutoCompleteTextField/MLPAutoCompleteTextField.h"

@class RCTEventDispatcher;


@interface AutoCompleteView : MLPAutoCompleteTextField <UITextFieldDelegate>

@property (nonatomic, copy) NSString *cellComponent;

@property (retain, nonatomic) NSArray *suggestions;
@property (copy) void (^handler)(NSArray *);

@property (nonatomic, assign) BOOL caretHidden;
@property (nonatomic, assign) BOOL autoCorrect;
@property (nonatomic, assign) BOOL selectTextOnFocus;
@property (nonatomic, assign) BOOL blurOnSubmit;
@property (nonatomic, assign) UIEdgeInsets contentInset;
@property (nonatomic, strong) UIColor *placeholderTextColor;
@property (nonatomic, assign) NSInteger mostRecentEventCount;
@property (nonatomic, strong) NSNumber *maxLength;

- (instancetype)initWithEventDispatcher:(RCTEventDispatcher *)eventDispatcher NS_DESIGNATED_INITIALIZER;

- (void)textFieldDidChange;

@end
