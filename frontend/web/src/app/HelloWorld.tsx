import React from 'react';
import { getBaseUrl } from '../../lib/getBaseUrl';

export default async function HelloWorld() {
 await fetch(
    `${getBaseUrl()}/api/sample?delay=3000`,
    {
      cache: 'no-store',
    }
  ).then((res) => res.json());

  return (
    <div>現在の時刻: {new Date().toLocaleString()}</div>
  );
}
