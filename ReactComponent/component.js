/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 * @flow
 */

import React, { Component } from 'react';
import {
  StyleSheet,
  Text,
  View,
  TouchableHighlight
} from 'react-native';
var { NativeModules } = require('react-native');
var RNBridgeModule=NativeModules.RNBridgeModuleClient;
import { NativeAppEventEmitter } from 'react-native';
var subscription; //订阅者

class CustomButton extends Component {
  render() {
    return (
      <TouchableHighlight
        style={styles.button}
        underlayColor="#a5a5a5"
        onPress={this.props.onPress}>
        <Text style={styles.buttonText}>{this.props.text}</Text>
      </TouchableHighlight>
    );
  }
}
export default class hunheDemo extends Component {
  constructor(props){
    super(props);
    this.state={
        events:'',
        msg:'',
    }
  }
  nativeFunction(args){
    console.log(args);
  }
  //获取Promise对象处理
  async _updateEvents(){
    try{
        var events=await RNBridgeModule.RNInvokeOCPromise({'name':'cpbeern'});
        this.setState({events});
    }catch(e){
        this.setState({events:e.message});
    }
  }
    asyncCallBackMessage(messageId,content){
        try{
            RNBridgeModule.RNSendMessage(
                {'messageId':messageId,
                    'messageType':'CALL_BACK',
                    ...content})
            console.log('await response');
        }catch(e){
            //this.setState({events:e.message});
        }
    }

  componentWillReceiveProps(props){
    console.log(props);
    if (props.message != undefined) {
      this.setState({msg:props.message});
    }
  }
  componentDidMount(){
    console.log('开始订阅通知...');
    subscription = NativeAppEventEmitter.addListener(
         'EventReminder',
          (reminder) => {
            console.log("did recive reminder:" + reminder);
            let errorCode=reminder.errorCode;
            if(errorCode===0){
               this.setState({msg:reminder.name});
            }else{
               this.setState({msg:reminder.msg});
                const callBackJson = {
                    'content':'this is just a call back'
                    };

                this.asyncCallBackMessage(reminder.name.messageId,callBackJson)
            }
           
          }
         );
  }
  componentWillUnmount(){
     subscription.remove();
  }

  render() {
    return (
      <View style={{marginTop:20}}>
        <Text style={styles.welcome}>
           混合RN与iOS通信实例
        </Text>
        <Text style={{margin:5}}>'返回数据为:'+{this.state.events}</Text>
        <CustomButton text='RN调用iOS原生方法_CallBack回调'
          onPress={()=>{RNBridgeModule.RNInvokeOCCallBack(
            {'name':'cpbee','description':'http://www.cpbee.com'},
            (error,events)=>{
                if(error){
                  console.error(error);
                }else{
                  this.setState({events:events});
                }
          })}}
        />
        <CustomButton text='RN调用iOS原生方法_Promise回调'
           onPress={()=>this._updateEvents()}
        />
        <Text style={{margin:20}}>
          '返回数据为:'+{this.state.msg}
        </Text>
        <CustomButton text='iOS调用访问React Native'
            onPress={()=>RNBridgeModule.VCOpenRN({'name':'cpbeern'})}
        />
           
      </View>
    );
  }
}

const styles = StyleSheet.create({
  welcome: {
    fontSize: 20,
    textAlign: 'center',
    margin: 10,
  },
  button: {
    margin:5,
    backgroundColor: 'white',
    padding: 10,
    borderWidth: 1,
    borderColor: '#facece',
  },
});
