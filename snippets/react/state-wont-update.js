import React, { useState, useEffect } from 'react';

const [thing, setthing] = useState(''); // the state on update of which we want to call some function

const someAction = () => {
  let temp = 'test';
  setthing(temp); // the state will now be 'test'
};

useEffect(() => {
  // this hook will get called every time when thing has changed
  console.log('Updated State', thing);
}, [thing]);
