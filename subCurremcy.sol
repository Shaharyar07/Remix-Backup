// SPDX-License-Identifier: GPL-3.0
// The contract that allows only owner to create new coins
// Anyone can send coins without the need of registering with a username and password all your need is Etherum keypair
pragma solidity >=0.7.0 <0.9.0;
 
 contract Coin {
     //by making it public it is accessable from other contracts
     address public minter;
     mapping(address => uint) public balances;

    event Sent(address from , address to,uint amount);

    //constructor only run when contract is deployed
     constructor(){
         minter = msg.sender;
     }

     // Only the owner can make the new coins and send them to an address
    function mint(address reciever,uint amount) public {
        require(msg.sender == minter);
        balances[reciever] += amount;
    }

    error insufficientBalance(uint requested,uint available);
//Send Coin
    function send(address reciever,uint amount) public{
        if(amount > balances[msg.sender])
        revert insufficientBalance({
            requested: amount,
            available:balances[msg.sender]
        });
        balances[msg.sender] -= amount;
        balances[reciever] += amount;

        emit Sent(msg.sender,reciever,amount);
    }
    

 }