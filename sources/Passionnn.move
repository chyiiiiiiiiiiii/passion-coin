module passionnn::pas {

    use std::option;
    use sui::coin::{Self, Coin, TreasuryCap};
    use sui::transfer;
    use sui::tx_context::{Self, TxContext};

    /// Name of the coin. By convention, this type has the same name as its parent module
    /// and has no fields. The full type of the coin defined by this module will be `COIN<PAS>`.
    public struct PAS has drop {}

    /// Register the PAS currency to acquire its `TreasuryCap`. Because
    /// this is a module initializer, it ensures the currency only gets
    /// registered once.
    fun init(witness: PAS, ctx: &mut TxContext) {
        // Get a treasury cap for the coin and give it to the transaction sender
        let (treasury_cap, metadata) = coin::create_currency<PAS>(witness, 2, b"PAS", b"PAS", b"", option::none(), ctx);
        transfer::public_freeze_object(metadata);
        transfer::public_transfer(treasury_cap, tx_context::sender(ctx))
    }

    /// Manager can mint new coins
    public fun mint(
        treasury_cap: &mut TreasuryCap<PAS>, amount: u64, recipient: address, ctx: &mut TxContext
    ) {
        coin::mint_and_transfer(treasury_cap, amount, recipient, ctx)
    }

    /// Manager can burn coins
    public fun burn(treasury_cap: &mut TreasuryCap<PAS>, coin: Coin<PAS>) {
        coin::burn(treasury_cap, coin);
    }

    #[test_only]
    /// Wrapper of module initializer for testing
    public fun test_init(ctx: &mut TxContext) {
        init(PAS {}, ctx)
    }
}