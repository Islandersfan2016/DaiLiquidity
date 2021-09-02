const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("deposit", function () {
  it("Deposits Dai to Aave LendingPool", async function () {
    const Deposit = await ethers.getContractFactory();
    const deposit = await Deposit.deploy();
    await deposit.deployed();

    expect(await deposit.greet()).to.equal();

    const setDepositTx = await deposit.setDeposit();

    // wait until the transaction is mined
    await setDepositTx.wait();

    expect(await deposit.deposit()).to.equal();
  });

describe("Transfer", function () {
  it("Transfer DAI to Uniswap", async function () {
    const Transfer = await ethers.getContractFactory();
    const transfer = await Transfer.deploy();
    await transfer.deployed();

    expect(await transfer.transfer()).to.equal();

    const setTransferTx = await transfer.setTransfer();

    // wait until the transaction is mined
    await setTransferTx.wait();

    expect(await transfer.transfer()).to.equal();
  });

describe("addLiqudity", function () {
  it("Adds Liquidity to Uniswap", async function () {
    const addLiquidity = await ethers.getContractFactory();
    const addLiquidity = await addLiquidity.deploy();
    await addLiquidity.deployed();

    expect(await addLiquidity.addLiquidity()).to.equal();

    const setAddLiquidityTx = await addLiquidity.setAddLiquidity();

    // wait until the transaction is mined
    await setAddLiquidityTx.wait();

    expect(await addLiquidity.addLiquidity()).to.equal();
  });
});