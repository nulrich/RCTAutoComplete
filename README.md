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

var React = require('react-native');
var AutoComplete = require('react-native-autocomplete');
var Countries = require('./countries.json');

var {
    AppRegistry,
    StyleSheet,
    Text,
    View,
    AlertIOS
} = React;

var Test = React.createClass({

    getInitialState: function() {
        return {data: []};
    },

    onTyping: function (text) {

        var countries = Countries.filter(function (country) {
            return country.name.toLowerCase().startsWith(text.toLowerCase())
        }).map(function (country) {
            return country.name;
        });

        this.setState({
            data:  countries
        });
    },

    onSelect: function (event) {
        AlertIOS.alert(
            'You choosed',
            event
        );
    },

    render: function() {
        return (
            <View style={styles.container}>
            <Text style={styles.welcome}>
            Search for a country
                </Text>
            <AutoComplete onTyping={this.onTyping}
            onSelect={this.onSelect}
            suggestions={this.state.data}/>
            </View>
        );
    }
});

var styles = StyleSheet.create({
    container: {
        flex: 1,
        alignItems: 'center',
        backgroundColor: '#F5FCFF',
    },
    welcome: {
        fontSize: 20,
        textAlign: 'center',
        marginBottom: 10,
        marginTop: 50,

    }
});

AppRegistry.registerComponent('Test', () => Test);
```

## License
MIT © Nicolas Ulrich 2015
