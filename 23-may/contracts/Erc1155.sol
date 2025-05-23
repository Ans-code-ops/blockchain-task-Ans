// SPDX-License-Identifier: MIT
pragma solidity 0.8.30;
contract ERC1155Basic {
    string public TokenName = "Games";
    string public symbol = "GM";
    

    mapping(uint256 => mapping(address => uint256)) public balances;
    mapping(address => mapping(address => bool)) public isApprovedForAll;
    mapping(uint256 => string) private _uris;

    
    event TransferSingle(address indexed operator,address indexed from,address indexed to,uint256 id,uint256 value);
    event TransferBatch(address indexed operator,address indexed from,address indexed to,uint256[] ids,uint256[] values);
    event ApprovalForAll(address indexed account,address indexed operator,bool approved);
    event URI(string value, uint256 indexed id);

    // Returns balance of specific token for an account
    function balanceOf(address account, uint256 id) public view returns (uint256) {
        require(account != address(0), "Address zero");
        return balances[id][account];
    }

    // Returns balances for multiple accounts/tokens
    function balanceOfBatch(address[] calldata accounts, uint256[] calldata ids)external view returns (uint256[] memory)
    {
        require(accounts.length == ids.length, "Length mismatch");
        
        uint256[] memory batchBalances = new uint256[](accounts.length);
        
        for (uint256 i = 0; i < accounts.length; ++i) {
            batchBalances[i] = balances[ids[i]][accounts[i]];
        }
        
        return batchBalances;
    }

    // Approves or disapproves an operator
    function setApprovalForAll(address operator, bool approved) external {
        require(msg.sender != operator, "Self approval");
        isApprovedForAll[msg.sender][operator] = approved;
        emit ApprovalForAll(msg.sender, operator, approved);
    }

    // Transfers tokens between accounts
    function safeTransferFrom(address from,address to,uint256 id,uint256 amount,bytes calldata data) external {
        require(
            from == msg.sender || isApprovedForAll[from][msg.sender],
            "Not approved"
        );
        require(to != address(0), "Transfer to zero");
        
        balances[id][from] -= amount;
        balances[id][to] += amount;
        
        emit TransferSingle(msg.sender, from, to, id, amount);
        
        if (to.code.length > 0) {
            try IERC1155Receiver(to).onERC1155Received(msg.sender, from, id, amount, data) 
                returns (bytes4 response) {
                if (response != IERC1155Receiver.onERC1155Received.selector) {
                    revert("Receiver rejected");
                }
            } catch {
                revert("Transfer to non-receiver");
            }
        }
    }

    // Batch transfer tokens
    function safeBatchTransferFrom(address from,address to,uint256[] calldata ids,uint256[] calldata amounts,bytes calldata data) external {
        require(
            from == msg.sender || isApprovedForAll[from][msg.sender],
            "Not approved"
        );
        require(to != address(0), "Transfer to zero");
        require(ids.length == amounts.length, "Length mismatch");
        
        for (uint256 i = 0; i < ids.length; ++i) {
            balances[ids[i]][from] -= amounts[i];
            balances[ids[i]][to] += amounts[i];
        }
        
        emit TransferBatch(msg.sender, from, to, ids, amounts);
        
        if (to.code.length > 0) {
            try IERC1155Receiver(to).onERC1155BatchReceived(msg.sender, from, ids, amounts, data)
                returns (bytes4 response) {
                if (response != IERC1155Receiver.onERC1155BatchReceived.selector) {
                    revert("Receiver rejected");
                }
            } catch {
                revert("Transfer to non-receiver");
            }
        }
    }

    // Mint new tokens (public for demo - usually restricted)
    function mint(address to,uint256 id,uint256 amount,bytes calldata data) external {
        require(to != address(0), "Mint to zero");
        
        balances[id][to] += amount;
        emit TransferSingle(msg.sender, address(0), to, id, amount);
        
        if (to.code.length > 0) {
            try IERC1155Receiver(to).onERC1155Received(msg.sender, address(0), id, amount, data)
                returns (bytes4 response) {
                if (response != IERC1155Receiver.onERC1155Received.selector) {
                    revert("Receiver rejected");
                }
            } catch {
                revert("Transfer to non-receiver");
            }
        }
    }

    // Burn tokens
    function burn(address from,uint256 id,uint256 amount) external {
        require(
            from == msg.sender || isApprovedForAll[from][msg.sender],
            "Not approved"
        );
        
        balances[id][from] -= amount;
        emit TransferSingle(msg.sender, from, address(0), id, amount);
    }
}

interface IERC1155Receiver {
    function onERC1155Received(
        address operator,
        address from,
        uint256 id,
        uint256 amount,
        bytes calldata data
    ) external returns (bytes4);

    function onERC1155BatchReceived(
        address operator,
        address from,
        uint256[] calldata ids,
        uint256[] calldata amounts,
        bytes calldata data
    ) external returns (bytes4);
}