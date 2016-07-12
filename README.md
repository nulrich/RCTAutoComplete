# react-native-autocomplete
[MLPAutoCompleteTextField](https://github.com/EddyBorja/MLPAutoCompleteTextField) wrapper for React Native

## Installation

* `$ npm install react-native-autocomplete`
* Right click on Libraries, select **Add files to "…"** and select `node_modules/react-native-autocomplete/RCTAutoComplete.xcodeproj`
* Select your project and under **Build Phases** -> **Link Binary With Libraries**, press the + and select `libRCTAutoComplete.a`.

[Facebook documentation](https://facebook.github.io/react-native/docs/linking-libraries.html#content)

## Usage

For example download [Country list](https://gist.githubusercontent.com/Keeguon/2310008/raw/865a58f59b9db2157413e7d3d949914dbf5a237d/countries.json)

```js

'use strict';

var AutoComplete = require('react-native-autocomplete');
var Countries = require('./countries.json');

import React, { Component } from 'react';
import {
    AppRegistry,
    StyleSheet,
    Text,
    View,
    AlertIOS
} from 'react-native';

class RCTAutoCompleteApp extends Component {

  constructor(props) {
    super(props);
    this.state = {
        data: Countries
    };
  }

   onTyping(text){
        var countries = Countries.filter(function (country) {
            return country.name.toLowerCase().startsWith(text.toLowerCase())
        }).map(function (country) {
            return country.name;
        });

        this.setState({data: countries});
    }


  render() {
        return (
            <View style={styles.container}>
                <Text style={styles.welcome}>
                Search for a country
                </Text>
                <AutoComplete
                    onTyping={(text) => this.onTyping(text)}
                    onSelect={(e) => AlertIOS.alert('You choosed', e)}
                    onBlur={() => AlertIOS.alert('Blur')}
                    onFocus={() => AlertIOS.alert('Focus')}
                    onSubmitEditing={(e) => AlertIOS.alert('onSubmitEditing')}
                    onEndEditing={(e) => AlertIOS.alert('onEndEditing')}

                    suggestions={this.state.data}

                    placeholder='This is a great placeholder'
                    style={styles.autocomplete}
                    clearButtonMode='always'
                    returnKeyType='go'
                    textAlign='center'
                    clearTextOnFocus={true}

                    maximumNumberOfAutoCompleteRows={10}
                    applyBoldEffectToAutoCompleteSuggestions={true}
                    reverseAutoCompleteSuggestionsBoldEffect={true}
                    showTextFieldDropShadowWhenAutoCompleteTableIsOpen={false}
                    autoCompleteTableViewHidden={false}

                    autoCompleteTableBorderColor='lightblue'
                    autoCompleteTableBackgroundColor='azure'
                    autoCompleteTableCornerRadius={10}
                    autoCompleteTableBorderWidth={1}

                    autoCompleteRowHeight={35}

                    autoCompleteFontSize={15}
                    autoCompleteRegularFontName='Helvetica Neue'
                    autoCompleteBoldFontName='Helvetica Bold'
                    autoCompleteTableCellTextColor={'red'}
                />
            </View>
        );

  }
}


var styles = StyleSheet.create({
    autocomplete: {
        alignSelf: 'stretch',
        height: 50,
        backgroundColor: '#FFF',
        borderColor: 'lightblue',
        borderWidth: 1
    },
    container: {
        flex: 1,
        backgroundColor: '#F5FCFF',
    },
    welcome: {
        fontSize: 20,
        textAlign: 'center',
        marginBottom: 10,
        marginTop: 50,

    }
});

AppRegistry.registerComponent('RCTAutoCompleteApp', () => RCTAutoCompleteApp);
```

## License
MIT © Nicolas Ulrich 2015
