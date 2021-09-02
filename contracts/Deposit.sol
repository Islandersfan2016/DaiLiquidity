pragma solidity ^0.6.12;

// Import interface for ERC20 standard
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@uniswap/v2-periphery/contracts/interfaces/IUniswapV2Router02.sol";

contract Deposit {
   
    // Retrieve LendingPool address
    LendingPoolAddressesProvider provider = LendingPoolAddressesProvider(address(0x24a42fD28C976A61Df5D00D0599C34c4f90748c8)); // mainnet address, for other addresses: https://docs.aave.com/developers/developing-on-aave/deployed-contract-instances

    address daiAddress = address(0x6B175474E89094C44Da98b954EedeAC495271d0F); // mainnet DAI
    uint256 amount = 1000 * 1e18;
    address onBehalfOf = msg.sender;
    uint16 referralCode = 0;

    address private constant FACTORY = 0x5C69bEe701ef814a2B6a3EDD4B1652CB9cc5aA6f;
    address private constant ROUTER = 0x7a250d5630B4cF539739dF2C5dAcb4c659F2488D;

    event deposit (address user, address indexed onBehalfOf, uint256 amount, uint16 indexed referral);
    event transfer (address asset, uint256 amount, address to);
    event log(string message, uint val);

    function deposit(address asset, uint256 amount, address onBehalfOf, uint16 referralCode) external {
        IERC20(daiAddress).approve(address(lendingPool), amount);
        // Deposit 1000 DAI
        lendingPool.deposit(asset, amount, onBehalfOf, referralCode);

        emit deposit(asset, amount, onBehalfOf, referral);

    }

    function transfer(address asset, uint256 amount, address to) external{
        address asset = address(0x6B175474E89094C44Da98b954EedeAC495271d0F); //DAI
        uint256 amount = uint(-1);
        address to = msg.sender;

        lendingPool.withdraw(asset, amount, to);

        emit transfer(asset, amount, to);
    };
    
    function addLiquidity(address _tokenA, address _tokenB, uint _amountA, uint _amountB) external {
        IERC20(_tokenA).transferFrom(msg.sender, address(this), _amountA);
        IERC20(_tokenB).transferFrom(msg.sender, address(this), _amountB);

        IERC20(_tokenA).approve(ROUTER, _amountA);
        IERC20(_tokenB).approve(ROUTER, _amountB);

        (uint amountA, uint amountB, uint liquidity) =
        IUniswapV2Router(ROUTER).addLiquidity(
            _tokenA,
            _tokenB,
            _amountA,
            _amountB,
            1,
            1,
            address(this),
            block.timestamp
      );

        emit Log("amountA", amountA);
        emit Log("amountB", amountB);
        emit Log("liquidity", liquidity);
    }

    function removeLiquidity(address _tokenA, address _tokenB) external {
        address pair = IUniswapV2Factory(FACTORY).getPair(_tokenA, _tokenB);

        uint liquidity = IERC20(pair).balanceOf(address(this));
        IERC20(pair).approve(ROUTER, liquidity);

        (uint amountA, uint amountB) =
            IUniswapV2Router(ROUTER).removeLiquidity(
            _tokenA,
            _tokenB,
            liquidity,
            1,
            1,
            address(this),
            block.timestamp
        );

        emit Log("amountA", amountA);
        emit Log("amountB", amountB);
  }

}