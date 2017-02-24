#import <Foundation/Foundation.h>
#import "RCTAutoComplete.h"
#import "RCTTableViewCell.h"
#import <React/RCTEventDispatcher.h>
#import "UIView+React.h"
#import "AutoCompleteView.h"
#import "DictionaryAutoCompleteObject.h"
#import <React/RCTFont.h>

@implementation RCTAutoComplete

RCT_EXPORT_MODULE()

// From AutoCompleteView.m
RCT_EXPORT_VIEW_PROPERTY(suggestions, NSArray)
RCT_EXPORT_VIEW_PROPERTY(maximumNumberOfAutoCompleteRows, NSInteger)
RCT_EXPORT_VIEW_PROPERTY(applyBoldEffectToAutoCompleteSuggestions, BOOL)
RCT_EXPORT_VIEW_PROPERTY(reverseAutoCompleteSuggestionsBoldEffect, BOOL)
RCT_EXPORT_VIEW_PROPERTY(showTextFieldDropShadowWhenAutoCompleteTableIsOpen, BOOL);
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

RCT_CUSTOM_VIEW_PROPERTY(autoCompleteTableTopOffset, NSInteger, AutoCompleteView)
{
    CGSize size = view.autoCompleteTableOriginOffset;
    size.height = [RCTConvert NSInteger:json];
    view.autoCompleteTableOriginOffset = size;
}

RCT_CUSTOM_VIEW_PROPERTY(autoCompleteTableLeftOffset, NSInteger, AutoCompleteView)
{
    CGSize size = view.autoCompleteTableOriginOffset;
    size.width = [RCTConvert NSInteger:json];
    view.autoCompleteTableOriginOffset = size;
}


RCT_CUSTOM_VIEW_PROPERTY(autoCompleteTableSizeOffset, NSInteger, AutoCompleteView)
{
    view.autoCompleteTableSizeOffset = CGSizeMake([RCTConvert NSInteger:json], 0);
}

RCT_CUSTOM_VIEW_PROPERTY(cellComponent, NSString*, AutoCompleteView) {
    // Register RCTTableViewCellBridge (hosts cell React Component)
    [view registerAutoCompleteCellClass:[RCTTableViewCell class]
                 forCellReuseIdentifier:@"RCTTableViewCell"];
    // Set cell React Component
    [view setCellComponent:[RCTConvert NSString:json]];
}

RCT_EXPORT_VIEW_PROPERTY(autoCompleteFetchRequestDelay, NSTimeInterval);

// From RCTTextFieldManager.m
RCT_EXPORT_VIEW_PROPERTY(autoCorrect, BOOL)
RCT_EXPORT_VIEW_PROPERTY(text, NSString)
RCT_EXPORT_VIEW_PROPERTY(placeholder, NSString)
RCT_EXPORT_VIEW_PROPERTY(placeholderTextColor, UIColor)
RCT_EXPORT_VIEW_PROPERTY(clearButtonMode, UITextFieldViewMode)
RCT_REMAP_VIEW_PROPERTY(clearTextOnFocus, clearsOnBeginEditing, BOOL)
RCT_EXPORT_VIEW_PROPERTY(blurOnSubmit, BOOL)
RCT_EXPORT_VIEW_PROPERTY(keyboardType, UIKeyboardType)
RCT_EXPORT_VIEW_PROPERTY(returnKeyType, UIReturnKeyType)
RCT_EXPORT_VIEW_PROPERTY(enablesReturnKeyAutomatically, BOOL)
RCT_REMAP_VIEW_PROPERTY(color, textColor, UIColor)
RCT_REMAP_VIEW_PROPERTY(autoCapitalize, autocapitalizationType, UITextAutocapitalizationType)
RCT_REMAP_VIEW_PROPERTY(textAlign, textAlignment, NSTextAlignment)
RCT_CUSTOM_VIEW_PROPERTY(fontSize, NSNumber, AutoCompleteView)
{
    view.font = [RCTFont updateFont:view.font withSize:json ?: @(defaultView.font.pointSize)];
}
RCT_CUSTOM_VIEW_PROPERTY(fontWeight, NSString, __unused AutoCompleteView)
{
    view.font = [RCTFont updateFont:view.font withWeight:json]; // defaults to normal
}
RCT_CUSTOM_VIEW_PROPERTY(fontStyle, NSString, __unused AutoCompleteView)
{
    view.font = [RCTFont updateFont:view.font withStyle:json]; // defaults to normal
}
RCT_CUSTOM_VIEW_PROPERTY(fontFamily, NSString, AutoCompleteView)
{
    view.font = [RCTFont updateFont:view.font withFamily:json ?: defaultView.font.familyName];
}
RCT_EXPORT_VIEW_PROPERTY(mostRecentEventCount, NSInteger)

- (UIView *) view
{
    AutoCompleteView *searchTextField = [[AutoCompleteView alloc] initWithEventDispatcher:self.bridge.eventDispatcher];

    searchTextField.autoCompleteDataSource = self;
    searchTextField.autoCompleteDelegate = self;    
    searchTextField.showTextFieldDropShadowWhenAutoCompleteTableIsOpen = false;
    
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
        
        NSDictionary *event  = @{
            @"possibleCompletionsForString": string,
            @"target": textField.reactTag
        };
        
        [self.bridge.eventDispatcher sendInputEventWithName:@"topChange" body:event];
    }
}

- (BOOL)autoCompleteTextField:(MLPAutoCompleteTextField *)textField
          shouldConfigureCell:(UITableViewCell *)cell
       withAutoCompleteString:(NSString *)autocompleteString
         withAttributedString:(NSAttributedString *)boldedString
        forAutoCompleteObject:(id<MLPAutoCompletionObject>)autocompleteObject
            forRowAtIndexPath:(NSIndexPath *)indexPath;
{
    // If no registered Cell Component
    if (((AutoCompleteView*)textField).cellComponent == nil) {
        return YES;
    }
    
    RCTTableViewCell *customCell = (RCTTableViewCell*) cell;
    
    RCTBridge *_bridge = self.bridge;

    // 🚀 https://github.com/aksonov/react-native-tableview/blob/8982116711cd74e819a73237c53307839fe071ce/RNTableView/RNTableView.m#L87
    while ([_bridge respondsToSelector:NSSelectorFromString(@"parentBridge")]
           && [_bridge valueForKey:@"parentBridge"]) {
        _bridge = [_bridge valueForKey:@"parentBridge"];
    }
    
    [customCell initWithBridge:_bridge
                reactComponent:[(AutoCompleteView*)textField cellComponent]
                          json:[(DictionaryAutoCompleteObject*)autocompleteObject json]
    ];
    
    return YES;
}

- (void)autoCompleteTextField:(MLPAutoCompleteTextField *)textField
  didSelectAutoCompleteString:(NSString *)selectedString
       withAutoCompleteObject:(id<MLPAutoCompletionObject>)selectedObject
            forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSDictionary *event = selectedObject
        ? @{
          @"target": textField.reactTag,
          @"didSelectAutoCompleteString": [(DictionaryAutoCompleteObject*)selectedObject json]
        }
        : @{
          @"target": textField.reactTag,
          @"didSelectAutoCompleteString": selectedString
        };
    
    [self.bridge.eventDispatcher sendInputEventWithName:@"topChange" body:event];
}

@end
