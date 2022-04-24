const {expect} = require("chai");
const {ethers} = require("hardhat");

let alpha;
let bravo;
let volcano;
let totalSupply;

//create a test
describe("Volcano Coin test ", () =>{
    beforeEach( async () => {
        [alpha, bravo] = await ethers.getSigners();
        const Volcano = await ethers.getContractFactory("ERC20VolcanoCoin");
        volcano = await Volcano.deploy();
        //mine the contract
        await volcano.deployed();
        
    });
    
    describe("Initial values", ()=>{
        it("Should setup a correct name", async () => {
            expect(await volcano.name()).equal("VolcanoCoin");
        });
        
        it("Should setup a correct symbol", async () => {
            expect(await volcano.symbol()).equal("VLC");
        });
    
        it("Should setup a correct total Supply", async () => {
            expect(await volcano.totalSupply()).equal(100000);
        });
    })

    describe("A correct Payment", () =>{ 
        it("Should transfer the correct amount from A to B securely", async () => {
            let balance = await volcano.balanceOf(alpha.address); //100k
            // A sends B , 100 tokens
            await volcano.allowance(alpha.address, bravo.address);
            await volcano.approve(bravo.address, 100);
            await volcano.transfer(bravo.address, 100);
            expect(await volcano.balanceOf(bravo.address)).equal(100);
            totalSupply = await volcano.totalSupply();
            expect(await volcano.balanceOf(alpha.address)).equal(totalSupply - 100);
        });
       
    })
    //it should addTotalsupply ony as an owner
    //it should allow to transfer money from owner to sender
    //it should record a payment when transfer function is invoked
    //it should return a payment from our payments mapping 

    //it should reduce owners balance when a payment happen
    //it should emit a corresponding event when totalSupply changes
})