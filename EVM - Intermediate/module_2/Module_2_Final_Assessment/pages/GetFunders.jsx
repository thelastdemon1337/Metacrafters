import React, { useState } from 'react';

function GetFunders({ atmContract }) {
  const [funders, setFunders] = useState([]);
  const [fundedAmounts, setFundedAmounts] = useState([]);

  async function handleGetFunders() {
    setFunders(await atmContract.getFunders());
  }

  async function getAmountFunded(funder) {
    const fundedAmount = await atmContract.getAmountFunded(funder);
    setFundedAmounts(prevAmounts => [...prevAmounts, fundedAmount]);
  }

  return (
    <div>
      <button onClick={handleGetFunders}>Get Funders</button>
      <table>
        <thead>
          <tr>
            <th>Address</th>
            <th>Amount</th>
          </tr>
        </thead>
        <tbody>
          {funders.map((funder, index) => {
            getAmountFunded(funder);
            return (
              <tr key={index}>
                <td>{funder}</td>
                <td>{fundedAmounts[index]?.toString()}</td>
              </tr>
            );
          })}
        </tbody>
      </table>
    </div>
  );
}

export default GetFunders;
