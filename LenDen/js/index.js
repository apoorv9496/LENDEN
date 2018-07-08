
var web3 = new Web3();
web3.setProvider(new Web3.providers.HttpProvider("http://localhost:8545"));

if(typeof Web3 !== 'undefined'){
	console.log("undefined");
}
else{
	web3.setProvider(new Web3.providers.HttpProvider("http://localhost:8545"));
}

// setting default account for calling the contract functions
web3.eth.defaultAccount = web3.eth.accounts[0];

// instantiating contract object
const contract = web3.eth.contract([
	{
		"constant": false,
		"inputs": [
			{
				"name": "index",
				"type": "uint256"
			},
			{
				"name": "addr",
				"type": "address"
			},
			{
				"name": "amount",
				"type": "uint256"
			},
			{
				"name": "interestRate",
				"type": "uint256"
			},
			{
				"name": "period",
				"type": "uint256"
			}
		],
		"name": "acceptToLend",
		"outputs": [],
		"payable": false,
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"constant": false,
		"inputs": [
			{
				"name": "index",
				"type": "uint256"
			}
		],
		"name": "borrow",
		"outputs": [
			{
				"name": "",
				"type": "string"
			}
		],
		"payable": false,
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"constant": false,
		"inputs": [
			{
				"name": "name",
				"type": "string"
			},
			{
				"name": "userAddress",
				"type": "address"
			}
		],
		"name": "createAccount",
		"outputs": [],
		"payable": false,
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"constant": false,
		"inputs": [
			{
				"name": "amount",
				"type": "uint256"
			},
			{
				"name": "rate",
				"type": "uint256"
			},
			{
				"name": "period",
				"type": "uint256"
			},
			{
				"name": "reqType",
				"type": "string"
			}
		],
		"name": "createRequest",
		"outputs": [
			{
				"name": "",
				"type": "string"
			}
		],
		"payable": false,
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"constant": false,
		"inputs": [
			{
				"name": "index",
				"type": "uint256"
			}
		],
		"name": "lend",
		"outputs": [
			{
				"name": "",
				"type": "string"
			}
		],
		"payable": true,
		"stateMutability": "payable",
		"type": "function"
	},
	{
		"constant": false,
		"inputs": [],
		"name": "payBack",
		"outputs": [
			{
				"name": "",
				"type": "string"
			}
		],
		"payable": true,
		"stateMutability": "payable",
		"type": "function"
	},
	{
		"inputs": [],
		"payable": false,
		"stateMutability": "nonpayable",
		"type": "constructor"
	},
	{
		"constant": true,
		"inputs": [
			{
				"name": "",
				"type": "uint256"
			}
		],
		"name": "_borrowRequestList",
		"outputs": [
			{
				"name": "reqAddress",
				"type": "address"
			},
			{
				"name": "amount",
				"type": "uint256"
			},
			{
				"name": "interestRate",
				"type": "uint256"
			},
			{
				"name": "period",
				"type": "uint256"
			},
			{
				"name": "active",
				"type": "bool"
			}
		],
		"payable": false,
		"stateMutability": "view",
		"type": "function"
	},
	{
		"constant": true,
		"inputs": [
			{
				"name": "",
				"type": "uint256"
			}
		],
		"name": "_lendRequestList",
		"outputs": [
			{
				"name": "reqAddress",
				"type": "address"
			},
			{
				"name": "amount",
				"type": "uint256"
			},
			{
				"name": "interestRate",
				"type": "uint256"
			},
			{
				"name": "period",
				"type": "uint256"
			},
			{
				"name": "active",
				"type": "bool"
			}
		],
		"payable": false,
		"stateMutability": "view",
		"type": "function"
	}
]);

// update contract address here. Get it under the run section after you deploy the contract.
var contract_at = contract.at('0x1afa7e44fd500da3a87d6615aef47870244618bf');
        console.log(contract_at);

        console.log(contract_at._borrowRequestList(0)[0]);
        console.log(contract_at._borrowRequestList(0)[1]['c'][0]);
        console.log(contract_at._borrowRequestList(0)[2]['c'][0]);
        console.log(contract_at._borrowRequestList(0)[3]['c'][0]);

		$('#button_setup').click(function() {
			contract_at.setAccount($('#name').val());
        })
        $('#button_get').click(function() {
        	contract_at.getAccount(function(error, result){
        		if(!error){
					$("#div").html(result);
        		}
        	});
        })
        $('#button_mint').click(function() {
        	contract_at.mint($('#acc_address').val(), $('#amount').val(), function(error, result){
        		if(!error){
        			alert("result is" + result);
        		}
        	});
        })
