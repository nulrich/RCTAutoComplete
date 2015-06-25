'use strict';

var AutoComplete = require('./AutoComplete');
var Countries = require('./countries.json');
var React = require('react-native');
var {
    AppRegistry,
    StyleSheet,
    Text,
    View,
    AlertIOS
} = React;

var RCTAutoComplete = React.createClass({

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

AppRegistry.registerComponent('RCTAutoComplete', () => RCTAutoComplete);
