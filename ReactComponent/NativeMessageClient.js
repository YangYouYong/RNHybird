/**
 * Created by yangyouyong on 2018/1/22.
 */

import React, { Component } from 'react';
import {View, Text, NativeModules, NativeAppEventEmitter} from 'react-native'

var RNBridgeModule=NativeModules.RNBridgeModuleClient;
var subscription; //订阅者

export default class NativeMessageClient extends Component {

    componentDidMount(){
        console.log('开始通知...');
        subscription = NativeAppEventEmitter.addListener(
                'UpdateNativeModule',
                (reminder) => {
                console.log("moduleList:" + JSON.stringify(reminder.moduleList));

        //TODO: update global NativeModuleList
    }
    );
    }

    componentWillUnmount(){
        subscription.remove();
    }

    render() {
        return (<View style={{marginTop:20}}>
                </View>);
    }
} 