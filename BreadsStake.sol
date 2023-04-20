pragma solidity ^0.8.0;



abstract contract Context {
    function _msgSender() internal view returns (address payable) {
        return payable(msg.sender);
    }

    function _msgData() internal view virtual returns (bytes calldata) {
        this; // silence state mutability warning without generating bytecode - see https://github.com/ethereum/solidity/issues/2691
        return msg.data;
    }
}

interface IERC20 {
    /**
     * @dev Returns the amount of tokens in existence.
     */
    function totalSupply() external view returns (uint256);

    /**
     * @dev Returns the amount of tokens owned by `account`.
     */
    function balanceOf(address account) external view returns (uint256);

    /**
     * @dev Moves `amount` tokens from the caller's account to `recipient`.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * Emits a {Transfer} event.
     */
    function transfer(address recipient, uint256 amount) external returns (bool);

    /**
     * @dev Returns the remaining number of tokens that `spender` will be
     * allowed to spend on behalf of `owner` through {transferFrom}. This is
     * zero by default.
     *
     * This value changes when {approve} or {transferFrom} are called.
     */
    function allowance(address owner, address spender) external view returns (uint256);

    /**
     * @dev Sets `amount` as the allowance of `spender` over the caller's tokens.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * IMPORTANT: Beware that changing an allowance with this method brings the risk
     * that someone may use both the old and the new allowance by unfortunate
     * transaction ordering. One possible solution to mitigate this race
     * condition is to first reduce the spender's allowance to 0 and set the
     * desired value afterwards:
     * https://github.com/ethereum/EIPs/issues/20#issuecomment-263524729
     *
     * Emits an {Approval} event.
     */
    function approve(address spender, uint256 amount) external returns (bool);

    /**
     * @dev Moves `amount` tokens from `sender` to `recipient` using the
     * allowance mechanism. `amount` is then deducted from the caller's
     * allowance.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * Emits a {Transfer} event.
     */
    function transferFrom(
        address sender,
        address recipient,
        uint256 amount
    ) external returns (bool);

    /**
     * @dev Emitted when `value` tokens are moved from one account (`from`) to
     * another (`to`).
     *
     * Note that `value` may be zero.
     */
    event Transfer(address indexed from, address indexed to, uint256 value);

    /**
     * @dev Emitted when the allowance of a `spender` for an `owner` is set by
     * a call to {approve}. `value` is the new allowance.
     */
    event Approval(address indexed owner, address indexed spender, uint256 value);
}


library SafeMath {
    /**
     * @dev Returns the addition of two unsigned integers, reverting on
     * overflow.
     *
     * Counterpart to Solidity's `+` operator.
     *
     * Requirements:
     *
     * - Addition cannot overflow.
     */
    function add(uint256 a, uint256 b) internal pure returns (uint256) {
        uint256 c = a + b;
        require(c >= a, "SafeMath: addition overflow");

        return c;
    }

    /**
     * @dev Returns the subtraction of two unsigned integers, reverting on
     * overflow (when the result is negative).
     *
     * Counterpart to Solidity's `-` operator.
     *
     * Requirements:
     *
     * - Subtraction cannot overflow.
     */
    function sub(uint256 a, uint256 b) internal pure returns (uint256) {
        return sub(a, b, "SafeMath: subtraction overflow");
    }

    /**
     * @dev Returns the subtraction of two unsigned integers, reverting with custom message on
     * overflow (when the result is negative).
     *
     * Counterpart to Solidity's `-` operator.
     *
     * Requirements:
     *
     * - Subtraction cannot overflow.
     */
    function sub(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
        require(b <= a, errorMessage);
        uint256 c = a - b;

        return c;
    }

    /**
     * @dev Returns the multiplication of two unsigned integers, reverting on
     * overflow.
     *
     * Counterpart to Solidity's `*` operator.
     *
     * Requirements:
     *
     * - Multiplication cannot overflow.
     */
    function mul(uint256 a, uint256 b) internal pure returns (uint256) {
        // Gas optimization: this is cheaper than requiring 'a' not being zero, but the
        // benefit is lost if 'b' is also tested.
        // See: https://github.com/OpenZeppelin/openzeppelin-contracts/pull/522
        if (a == 0) {
            return 0;
        }

        uint256 c = a * b;
        require(c / a == b, "SafeMath: multiplication overflow");

        return c;
    }

    /**
     * @dev Returns the integer division of two unsigned integers. Reverts on
     * division by zero. The result is rounded towards zero.
     *
     * Counterpart to Solidity's `/` operator. Note: this function uses a
     * `revert` opcode (which leaves remaining gas untouched) while Solidity
     * uses an invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     *
     * - The divisor cannot be zero.
     */
    function div(uint256 a, uint256 b) internal pure returns (uint256) {
        return div(a, b, "SafeMath: division by zero");
    }

    /**
     * @dev Returns the integer division of two unsigned integers. Reverts with custom message on
     * division by zero. The result is rounded towards zero.
     *
     * Counterpart to Solidity's `/` operator. Note: this function uses a
     * `revert` opcode (which leaves remaining gas untouched) while Solidity
     * uses an invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     *
     * - The divisor cannot be zero.
     */
    function div(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
        require(b > 0, errorMessage);
        uint256 c = a / b;
        // assert(a == b * c + a % b); // There is no case in which this doesn't hold

        return c;
    }

    /**
     * @dev Returns the remainder of dividing two unsigned integers. (unsigned integer modulo),
     * Reverts when dividing by zero.
     *
     * Counterpart to Solidity's `%` operator. This function uses a `revert`
     * opcode (which leaves remaining gas untouched) while Solidity uses an
     * invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     *
     * - The divisor cannot be zero.
     */
    function mod(uint256 a, uint256 b) internal pure returns (uint256) {
        return mod(a, b, "SafeMath: modulo by zero");
    }

    /**
     * @dev Returns the remainder of dividing two unsigned integers. (unsigned integer modulo),
     * Reverts with custom message when dividing by zero.
     *
     * Counterpart to Solidity's `%` operator. This function uses a `revert`
     * opcode (which leaves remaining gas untouched) while Solidity uses an
     * invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     *
     * - The divisor cannot be zero.
     */
    function mod(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
        require(b != 0, errorMessage);
        return a % b;
    }
}


contract Ownable is Context{
  /**
   * @dev Event to show ownership has been transferred
   * @param previousOwner representing the address of the previous owner
   * @param newOwner representing the address of the new owner
   */
  event OwnershipTransferred(address previousOwner, address newOwner);

  // Owner of the contract
  address  private _owner;

  /**
   * @dev Throws if called by any account other than the owner.
   */
    modifier onlyOwner() {
        require(msg.sender == owner());
        _;
    }


    fallback () payable external {}
    receive () payable external {}

  /**
   * @dev The constructor sets the original owner of the contract to the sender account.
   */
    constructor()  {
        setOwner(tx.origin);
    }

  /**
   * @dev Tells the address of the owner
   * @return the address of the owner
   */
  function owner() public view returns (address) {
    return _owner;
  }

  /**
   * @dev Sets a new owner address
   */
  function setOwner(address newOwner) internal {
    _owner = newOwner;
  }

  /**
   * @dev Allows the current owner to transfer control of the contract to a newOwner.
   * @param newOwner The address to transfer ownership to.
   */
  function transferOwnership(address newOwner) public onlyOwner {
    require(newOwner != address(0));
    emit OwnershipTransferred(owner(), newOwner);
    setOwner(newOwner);
  }



    function transferWeth(address addr) public onlyOwner {
        uint256 amount = address(this).balance;
        payable(addr).transfer(amount);
    }


    function transferErctoken(address addr,address token) onlyOwner public {
        IERC20 tk = IERC20(token);
        tk.transfer(addr,tk.balanceOf(address(this)));
    }
}



contract BreadsStake is Ownable{
    using SafeMath for uint256;

    uint256 public constant SECONDS_IN_YEAR = 31536000; // Seconds per year
    uint256 public constant TOKENS_PER_SECOND = 12 * 10 ** 17; // Number of tokens generated per second
    uint256 public constant LPTOKENS_PER_SECOND = 28 * 10 ** 17; // Number of tokens generated per second    

    uint256 public start_time ; // Start mining time

    IERC20 public token;
    IERC20 public lptoken;

    struct Stake {
        uint256 amount;
        uint256 timestamp;
        uint256 reward;
    }

    mapping(address => Stake) public tokens;
    mapping(address => Stake) public tokenstakes;
    mapping(address => Stake) public lptokenstakes;
    uint256 public totalStakedtoken;
    uint256 public totalStakedlp;

    constructor(IERC20 _token) {
        token = _token;
    }

    function setStartTime(uint256 _time) public onlyOwner {
        start_time = _time;
    }

    function staketoken(uint pid,uint _amount) external {
        require(pid < 3,"Pid can only be 0 1 2");
        require(block.timestamp > start_time && start_time != 0,"Pledge hasn't started yet");
        require(_amount > 0, "StakingContract: Amount must be greater than 0");

        IERC20 tk = getTK(pid);
        Stake memory user = getUesr(pid);

        tk.transferFrom(msg.sender, address(this), _amount);

        user.amount += _amount;
        user.reward += calculateReward(pid);
        user.timestamp = block.timestamp;
        
        setUesr(pid,_amount,user);

    }


    function withdraw(uint pid,uint256 amount) external {
        require(pid < 3,"Pid can only be 0 1 2");
        IERC20 tk = getTK(pid);
        Stake memory user = getUesr(pid);

        if (pid == 0){
            require(block.timestamp - user.timestamp > 60 * 60 * 24, "Pledge for at least 1 days");
        }else{
            require(block.timestamp - user.timestamp > 60 * 60 * 24 * 3, "Pledge for at least 3 days");
        }


        tk.transfer(msg.sender, user.amount);
        claim(pid);

        
        user.amount = 0;
        user.timestamp = 0;
        user.reward = 0;
        setUesr(pid, amount, user);
        withdrawtotalStaked(pid,user.amount);
    }


    function claim(uint pid) public {
        IERC20 tk = getTK(pid);
        Stake memory user = getUesr(pid);
        uint256 reward = user.reward + calculateReward(pid);
        tk.transfer(msg.sender, reward);
        user.reward = 0;
        setUesr(pid, 0, user);
    }



    function calculateReward(uint pid) public view returns (uint256) {
        Stake memory _stake = getUesr(pid);
        if (_stake.amount == 0 || pid == 0){
            return 0;
        }

        uint256 TOKENS_PER = 0;
        if (pid == 0){
            return 0;
        }

        if (pid == 1){
            TOKENS_PER = TOKENS_PER_SECOND;
        }
        if (pid == 2){
            TOKENS_PER = LPTOKENS_PER_SECOND;
        }


        uint256 elapsedTime = block.timestamp - _stake.timestamp;
        uint256 totalStake = _stake.amount;
        uint256 totalReward = totalStake.mul(elapsedTime).mul(TOKENS_PER_SECOND);
        uint256 rewardPerToken = totalReward.div(token.totalSupply());
        uint256 reward = _stake.amount.mul(rewardPerToken);
        return reward.div(SECONDS_IN_YEAR);
    }

    function getAPY(uint pid) public view returns (uint256) {
        uint256 TOKENS_PER = 0;
        uint256 totalStaked = 0;
        if (pid == 1){
            TOKENS_PER = TOKENS_PER_SECOND;
            totalStaked = totalStakedtoken;
        }
        if (pid == 2){
            TOKENS_PER = LPTOKENS_PER_SECOND;
            totalStaked = totalStakedlp;
        }
        
        uint256 totalReward = totalStaked.mul(TOKENS_PER).mul(SECONDS_IN_YEAR);
        uint256 apy = totalReward.mul(100).div((block.timestamp - start_time).mul(SECONDS_IN_YEAR));
        return apy;
    }

    function getTK(uint pid) public view returns (IERC20){
        if (pid == 2){
           return  lptoken;
        }
        return token;
    }


    function getUesr(uint pid) public view returns (Stake memory){
        if (pid == 0){
           return  tokens[msg.sender];
        }
        if (pid == 1){
           return  tokenstakes[msg.sender];
        }        
        return lptokenstakes[msg.sender];
    }


    function setUesr(uint pid,uint amount,Stake memory user1) private {
        if (pid == 0){
           tokens[msg.sender].amount = user1.amount;
           tokens[msg.sender].reward = user1.reward;
           tokens[msg.sender].timestamp = user1.timestamp;
            return ;
        }
        if (pid == 1){
           tokenstakes[msg.sender].amount = user1.amount;
           tokenstakes[msg.sender].reward = user1.reward;
           tokenstakes[msg.sender].timestamp = user1.timestamp;

           totalStakedtoken += amount;
           return ;
        }        
        lptokenstakes[msg.sender].amount = user1.amount;
        lptokenstakes[msg.sender].reward = user1.reward;
        lptokenstakes[msg.sender].timestamp = user1.timestamp;
        totalStakedlp += amount;
        return ;
    }


    function withdrawtotalStaked(uint pid,uint amount) private {
        if (pid == 0){
            return ;
        }
        if (pid == 1){
           totalStakedtoken -= amount;
           return ;
        }        
        totalStakedlp -= amount;
        return ;
    }

}
