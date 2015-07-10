#import <Foundation/Foundation.h>
#import "RCTAutoComplete.h"
#import "RCTEventDispatcher.h"
#import "UIView+React.h"
#import "AutoCompleteView.h"

@implementation RCTAutoComplete

RCT_EXPORT_MODULE()
RCT_EXPORT_VIEW_PROPERTY(suggestions, NSArray)

- (UIView *) view
{
    AutoCompleteView  *searchTextField  = [[AutoCompleteView alloc] initWithEventDispatcher:self.bridge.eventDispatcher];
    [searchTextField setBorderStyle:UITextBorderStyleRoundedRect];
    searchTextField.backgroundColor = [UIColor whiteColor];
    searchTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    searchTextField.textColor = [UIColor blackColor];
    searchTextField.returnKeyType = UIReturnKeyDone;
    searchTextField.placeholder = @"Enter name to search";
    searchTextField.autocorrectionType = UITextAutocorrectionTypeNo;
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