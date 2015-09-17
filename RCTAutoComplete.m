#import <Foundation/Foundation.h>
#import "RCTAutoComplete.h"
#import "RCTEventDispatcher.h"
#import "UIView+React.h"
#import "AutoCompleteView.h"

@implementation RCTAutoComplete

RCT_EXPORT_MODULE()

// From AutoCompleteView.m
RCT_EXPORT_VIEW_PROPERTY(suggestions, NSArray)
RCT_EXPORT_VIEW_PROPERTY(maximumNumberOfAutoCompleteRows, NSInteger)
RCT_EXPORT_VIEW_PROPERTY(applyBoldEffectToAutoCompleteSuggestions, BOOL)
RCT_EXPORT_VIEW_PROPERTY(reverseAutoCompleteSuggestionsBoldEffect, BOOL)
RCT_EXPORT_VIEW_PROPERTY(showTextFieldDropShadowWhenAutoCompleteTableIsOpen, BOOL);
RCT_EXPORT_VIEW_PROPERTY(disableAutoCompleteTableUserInteractionWhileFetching, BOOL);
RCT_EXPORT_VIEW_PROPERTY(autoCompleteTableViewHidden, BOOL);

RCT_EXPORT_VIEW_PROPERTY(autoCompleteTableBorderColor, UIColor);
RCT_EXPORT_VIEW_PROPERTY(autoCompleteTableBorderWidth, CGFloat);
RCT_EXPORT_VIEW_PROPERTY(autoCompleteTableBackgroundColor, UIColor);
RCT_EXPORT_VIEW_PROPERTY(autoCompleteTableCellBackgroundColor, UIColor);
RCT_EXPORT_VIEW_PROPERTY(autoCompleteTableCellTextColor, UIColor);
RCT_EXPORT_VIEW_PROPERTY(autoCompleteTableCornerRadius, CGFloat);

RCT_EXPORT_VIEW_PROPERTY(autoCompleteRowHeight, CGFloat);
RCT_EXPORT_VIEW_PROPERTY(autoCompleteFontSize, CGFloat);
RCT_EXPORT_VIEW_PROPERTY(autoCompleteBoldFontName, NSString);
RCT_EXPORT_VIEW_PROPERTY(autoCompleteRegularFontName, NSString);

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
    searchTextField.autoCompleteDataSource = self;
    searchTextField.autoCompleteDelegate = self;
    
    return searchTextField;
}

- (void)autoCompleteTextField:(AutoCompleteView *)textField
 possibleCompletionsForString:(NSString *)string
            completionHandler:(void (^)(NSArray *))handler
{
    // If empty string, empty the completion list
    if([string isEqualToString:@""]) {
        handler([NSArray array]);
    } else {
        textField.handler = handler;
        NSDictionary *event  = @{ @"possibleCompletionsForString": string, @"target": textField.reactTag};
        [self.bridge.eventDispatcher sendInputEventWithName:@"topChange" body:event];
    }
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