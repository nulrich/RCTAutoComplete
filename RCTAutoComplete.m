#import <Foundation/Foundation.h>
#import "RCTAutoComplete.h"
#import "RCTEventDispatcher.h"
#import "UIView+React.h"
#import "AutoCompleteView.h"

@implementation RCTAutoComplete

RCT_EXPORT_MODULE()

// From AutoCompleteView.m
RCT_EXPORT_VIEW_PROPERTY(suggestions, NSArray)

// From RCTTextFieldManager.m
RCT_EXPORT_VIEW_PROPERTY(autoCorrect, BOOL)
RCT_EXPORT_VIEW_PROPERTY(placeholder, NSString)
RCT_EXPORT_VIEW_PROPERTY(clearButtonMode, UITextFieldViewMode)
RCT_REMAP_VIEW_PROPERTY(clearTextOnFocus, clearsOnBeginEditing, BOOL)
RCT_EXPORT_VIEW_PROPERTY(keyboardType, UIKeyboardType)
RCT_EXPORT_VIEW_PROPERTY(returnKeyType, UIReturnKeyType)
RCT_EXPORT_VIEW_PROPERTY(enablesReturnKeyAutomatically, BOOL)
RCT_REMAP_VIEW_PROPERTY(color, textColor, UIColor)
RCT_REMAP_VIEW_PROPERTY(autoCapitalize, autocapitalizationType, UITextAutocapitalizationType)
RCT_REMAP_VIEW_PROPERTY(textAlign, textAlignment, NSTextAlignment)
RCT_CUSTOM_VIEW_PROPERTY(fontSize, CGFloat, AutoCompleteView)
{
    view.font = [RCTConvert UIFont:view.font withSize:json ?: @(defaultView.font.pointSize)];
}
RCT_CUSTOM_VIEW_PROPERTY(fontWeight, NSString, __unused AutoCompleteView)
{
    view.font = [RCTConvert UIFont:view.font withWeight:json]; // defaults to normal
}
RCT_CUSTOM_VIEW_PROPERTY(fontStyle, NSString, __unused AutoCompleteView)
{
    view.font = [RCTConvert UIFont:view.font withStyle:json]; // defaults to normal
}
RCT_CUSTOM_VIEW_PROPERTY(fontFamily, NSString, AutoCompleteView)
{
    view.font = [RCTConvert UIFont:view.font withFamily:json ?: defaultView.font.familyName];
}

- (UIView *) view
{
    AutoCompleteView  *searchTextField  = [[AutoCompleteView alloc] initWithEventDispatcher:self.bridge.eventDispatcher];
    [searchTextField setBorderStyle:UITextBorderStyleRoundedRect];
    searchTextField.backgroundColor = [UIColor whiteColor];
    searchTextField.autoCompleteDataSource = self;
    searchTextField.autoCompleteDelegate = self;
    
    return searchTextField;
}

- (void)autoCompleteTextField:(AutoCompleteView *)textField
 possibleCompletionsForString:(NSString *)string
            completionHandler:(void (^)(NSArray *))handler
{
    textField.handler = handler;
    NSDictionary *event  = @{ @"possibleCompletionsForString": string, @"target": textField.reactTag};
    [self.bridge.eventDispatcher sendInputEventWithName:@"topChange" body:event];
}

- (void)autoCompleteTextField:(MLPAutoCompleteTextField *)textField
  didSelectAutoCompleteString:(NSString *)selectedString
       withAutoCompleteObject:(id<MLPAutoCompletionObject>)selectedObject
            forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSDictionary *event  = @{ @"target": textField.reactTag, @"didSelectAutoCompleteString": selectedString };
    [self.bridge.eventDispatcher sendInputEventWithName:@"topChange" body:event];
}

@end