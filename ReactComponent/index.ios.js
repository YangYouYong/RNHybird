/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 * @flow
 */

import React, { Component } from 'react';
import {
  AppRegistry,
  StyleSheet,
  Text,
  View,
  TouchableHighlight
} from 'react-native';
import RNHybird from './component.js'
var { NativeModules } = require('react-native');
var RNBridgeModule=NativeModules.RNBridgeModule;
import { NativeAppEventEmitter } from 'react-native';
var subscription; //订阅者

AppRegistry.registerComponent('RNHybird', () => RNHybird);
