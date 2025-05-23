 // SPDX-License-Identifier: MIT
pragma solidity 0.8.30;

contract ERC721 {

    event Transfer(address indexed from, address indexed to, uint256 indexed tokenId);
    event Approval(address indexed owner, address indexed approved, uint256 indexed tokenId);
    event ApprovalForAll(address indexed owner, address indexed operator, bool approved);

    string public _name = "Blockchain";
    uint256 private nextTokenId = 1;
    string public _symbol = "BLk";
    string public _uri ;

    mapping(uint256 => address) private _owners;
    mapping(address => uint256) private _balances;
    mapping(uint256 => address) private _tokenApprovals;
    mapping(address => mapping(address => bool)) private _operatorApprovals;
    mapping(uint256 => string) private _tokenURIs;

    
    
     function mint(address to,string memory uri ) public returns (uint256) {
        require(to != address(0), "mint to the zero address");
        
        uint256 tokenId = nextTokenId++;
        _balances[to] += 1;
        _owners[tokenId] = to;
         _setTokenURI(tokenId, uri);
        
        emit Transfer(address(0), to, tokenId);
        return tokenId;
    }
    function tokenURI(uint256 tokenId) public view returns (string memory) {
    require(_owners[tokenId] != address(0), "Token does not exist");
    return _tokenURIs[tokenId];
}
    function _setTokenURI(uint256 tokenId, string memory uri) internal {
    require(_owners[tokenId] != address(0), "Token does not exist");
    _tokenURIs[tokenId] = uri;
}

    function balanceOf(address owner) public view returns (uint256) {
        require(owner != address(0), "invalid address");
        return _balances[owner];
    }

    function ownerOf(uint256 tokenId) public view returns (address) {
        address owner = _owners[tokenId];
        require(owner != address(0), "invalid token ID");
        return owner;
    }

    function approve(address to, uint256 tokenId) public {
        address owner = ownerOf(tokenId);
        require(to != owner, "approval to current owner");
        require(
            msg.sender == owner || isApprovedForAll(owner, msg.sender),
            "approve caller is not owner nor approved for all"
        );

        _tokenApprovals[tokenId] = to;
        emit Approval(owner, to, tokenId);
    }

    function getApproved(uint256 tokenId) public view returns (address) {
        require(_owners[tokenId] != address(0), "invalid token ID");
        return _tokenApprovals[tokenId];
    }

    function setApprovalForAll(address operator, bool approved) public {
        require(operator != msg.sender, "approve to caller");
        _operatorApprovals[msg.sender][operator] = approved;
        emit ApprovalForAll(msg.sender, operator, approved);
    }

    function isApprovedForAll(address owner, address operator) public view returns (bool) {
        return _operatorApprovals[owner][operator];
    }

    function transferFrom(address from, address to, uint256 tokenId) public {
        // Check if sender is approved or owner
        address owner = ownerOf(tokenId);
        require(
            msg.sender == owner || 
            isApprovedForAll(owner, msg.sender) || 
            getApproved(tokenId) == msg.sender,
            "caller is not token owner nor approved"
        );

        require(owner == from, "transfer from incorrect owner");
        require(to != address(0), "transfer to the zero address");

        _tokenApprovals[tokenId] = address(0);
        emit Approval(owner, address(0), tokenId);

        _balances[from] -= 1;
        _balances[to] += 1;
        _owners[tokenId] = to;

        emit Transfer(from, to, tokenId);
    }

    function safeTransferFrom(address from, address to, uint256 tokenId) public {
        safeTransferFrom(from, to, tokenId, "");
    }

   function safeTransferFrom(address from, address to, uint256 tokenId, bytes memory data) public {
    address owner = ownerOf(tokenId);
    require(
        msg.sender == owner || 
        isApprovedForAll(owner, msg.sender) || 
        getApproved(tokenId) == msg.sender,
        "caller is not token owner nor approved"
    );

    require(owner == from, "transfer from incorrect owner");
    require(to != address(0), "transfer to the zero address");

    _tokenApprovals[tokenId] = address(0);
    emit Approval(owner, address(0), tokenId);

    _balances[from] -= 1;
    _balances[to] += 1;
    _owners[tokenId] = to;

    emit Transfer(from, to, tokenId);

    // Check if recipient is a contract
    if (to.code.length > 0)  {
        try ERC721TokenReceiver(to).onERC721Received(msg.sender, from, tokenId, data) returns (bytes4 retval) {
            require(retval == ERC721TokenReceiver.onERC721Received.selector, "transfer to non ERC721Receiver implementer");
        } catch (bytes memory reason) {
            if (reason.length == 0) {
                revert("transfer to non ERC721Receiver implementer");
            } else {
                assembly {
                    revert(add(32, reason), mload(reason))
                }
            }
        }
    }
}
}
interface ERC721TokenReceiver {
    function onERC721Received(
        address operator,
        address from,
        uint256 tokenId,
        bytes calldata data
    ) external returns (bytes4);
}

