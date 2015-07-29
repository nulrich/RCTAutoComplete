var React = require('react-native');
var PropTypes = React.PropTypes;
var StyleSheet = require('StyleSheet');
var { requireNativeComponent } = require('react-native');

var NativeAutoComplete = requireNativeComponent('RCTAutoComplete', null);

var RCTAutoComplete = React.createClass({

    propTypes: {
        /**
         * List of string which will be display in the autocomplete box.
         */
        suggestions: PropTypes.array,
        /**
         * If false, disables auto-correct. The default value is true.
         */
        autoCorrect: PropTypes.bool,
        /**
         * The string that will be rendered before text input has been entered
         */
        placeholder: PropTypes.string,
        /**
         * When the clear button should appear on the right side of the text view
         * @platform ios
         */
        clearButtonMode: PropTypes.oneOf([
            'never',
            'while-editing',
            'unless-editing',
            'always',
        ]),
        /**
         * If true, clears the text field automatically when editing begins
         * @platform ios
         */
        clearTextOnFocus: PropTypes.bool,
        /**
         * Determines which keyboard to open, e.g.`numeric`.
         *
         * The following values work across platforms:
         * - default
         * - numeric
         * - email-address
         */
        keyboardType: PropTypes.oneOf([
            // Cross-platform
            'default',
            'numeric',
            'email-address',
            // iOS-only
            'ascii-capable',
            'numbers-and-punctuation',
            'url',
            'number-pad',
            'phone-pad',
            'name-phone-pad',
            'decimal-pad',
            'twitter',
            'web-search',
        ]),
        /**
         * Determines how the return key should look.
         * @platform ios
         */
        returnKeyType: PropTypes.oneOf([
            'default',
            'go',
            'google',
            'join',
            'next',
            'route',
            'search',
            'send',
            'yahoo',
            'done',
            'emergency-call',
        ]),
        /**
         * If true, the keyboard disables the return key when there is no text and
         * automatically enables it when there is text. The default value is false.
         * @platform ios
         */
        enablesReturnKeyAutomatically: PropTypes.bool,
        /**
         * Can tell TextInput to automatically capitalize certain characters.
         *
         * - characters: all characters,
         * - words: first letter of each word
         * - sentences: first letter of each sentence (default)
         * - none: don't auto capitalize anything
         */
        autoCapitalize: PropTypes.oneOf([
            'none',
            'sentences',
            'words',
            'characters',
        ]),
        /**
         * Set the position of the cursor from where editing will begin.
         * @platorm android
         */
        textAlign: PropTypes.oneOf([
            'start',
            'center',
            'end',
        ]),
    },

    getDefaultProps: function() {
        return {
            suggestions: [],
        };
    },

    _onChange: function (event) {
        event.nativeEvent.possibleCompletionsForString
            && this.props.onTyping
            && this.props.onTyping(event.nativeEvent.possibleCompletionsForString);

        event.nativeEvent.didSelectAutoCompleteString
            && this.props.onSelect
            && this.props.onSelect(event.nativeEvent.didSelectAutoCompleteString);
    },

    _onFocus: function(event: Event) {
        if (this.props.onFocus) {
            this.props.onFocus(event);
        }
    },

    _onBlur: function(event: Event) {
        if (this.props.onBlur) {
            this.props.onBlur(event);
        }
    },

    render: function () {

        var props = Object.assign({}, this.props);

        return (
            <NativeAutoComplete
            {...props}
            onChange={this._onChange}
            onFocus={this._onFocus}
            onBlur={this._onBlur}
            />
        )
    }

});

module.exports = RCTAutoComplete
