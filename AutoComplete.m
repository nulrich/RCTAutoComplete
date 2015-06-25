//
//  AutoComplete.m
//  FaceOff
//
//  Created by Nicolas Ulrich on 09/06/2015.
//  Copyright (c) 2015 Facebook. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RCTViewManager.h"
#import "MLPAutoCompleteTextField/MLPAutoCompleteTextField.h"
#import "RCTBridge.h"
#import "RCTEventDispatcher.h"
#import "UIView+React.h"
#import "AutoCompleteView.h"


@interface AutoComplete : RCTViewManager <MLPAutoCompleteTextFieldDataSource, MLPAutoCompleteTextFieldDelegate>

@end

@implementation AutoComplete

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