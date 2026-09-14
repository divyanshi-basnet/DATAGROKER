import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns

sns.set_theme(style="whitegrid")

class BankAccount:
    def __init__(self, account_id: int, holder_name: str, initial_balance: float = 0.0):
        self.account_id = account_id
        self.holder_name = holder_name
        self.__balance = initial_balance
        self.transactions = []  # List of transaction dicts

    def deposit(self, amount: float, category: str):
        if amount <= 0:
            raise ValueError("Deposit must be positive.")
        self.__balance += amount
        self._record_transaction("Deposit", amount, category)

    def withdraw(self, amount: float, category: str):
        if amount <= 0:
            raise ValueError("Withdrawal must be positive.")
        if amount > self.__balance:
            raise ValueError("Insufficient funds.")
        self.__balance -= amount
        self._record_transaction("Withdrawal", amount, category)

    def _record_transaction(self, tx_type: str, amount: float, category: str):
        self.transactions.append({
            "Account_ID": self.account_id,
            "Holder": self.holder_name,
            "Type": tx_type,
            "Amount": amount,
            "Category": category,
            "Balance_After": self.__balance
        })

    def get_balance(self) -> float:
        return self.__balance

class BankSystem:
    def __init__(self):
        self.accounts = {}

    def add_account(self, account: BankAccount):
        self.accounts[account.account_id] = account

    def export_to_dataframe(self) -> pd.DataFrame:
        all_txs = []
        for acc in self.accounts.values():
            all_txs.extend(acc.transactions)
        return pd.DataFrame(all_txs)

def analyze_and_plot(df: pd.DataFrame):
    if df.empty:
        print("No transactions to visualize.")
        return

    df["Signed_Amount"] = df.apply(
        lambda r: r["Amount"] if r["Type"] == "Deposit" else -r["Amount"], axis=1
    )

    fig, axes = plt.subplots(2, 2, figsize=(14, 10))
    fig.suptitle("Bank Ecosystem: Financial Performance & Analytics", fontsize=16, fontweight="bold")

    sns.barplot(
        data=df,
        x="Category",
        y="Amount",
        hue="Type",
        estimator=sum,
        errorbar=None,
        ax=axes[0, 0],
        palette={"Deposit": "#2ecc71", "Withdrawal": "#e74c3c"}
    )
    axes[0, 0].set_title("Total Transaction Volume by Category")
    axes[0, 0].tick_params(axis='x', rotation=30)

    net_balances = df.groupby("Holder")["Signed_Amount"].sum()
    net_balances.plot(
        kind="bar",
        ax=axes[0, 1],
        color=["#3498db" if val >= 0 else "#e74c3c" for val in net_balances]
    )
    axes[0, 1].set_title("Current Net Cash Flow per Customer")
    axes[0, 1].tick_params(axis='x', rotation=0)

    sns.boxplot(
        data=df,
        x="Type",
        y="Amount",
        hue="Type",
        dodge=False,
        ax=axes[1, 0],
        palette={"Deposit": "#2ecc71", "Withdrawal": "#e74c3c"},
        legend=False
    )
    axes[1, 0].set_title("Transaction Amount Distribution")

    for holder, group in df.groupby("Holder"):
        axes[1, 1].plot(range(len(group)), group["Balance_After"], marker='o', label=holder)
    axes[1, 1].set_title("Running Balance Progression")
    axes[1, 1].set_xlabel("Transaction Sequence")
    axes[1, 1].set_ylabel("Balance ($)")
    axes[1, 1].legend()

    plt.tight_layout()
    plt.show()

if __name__ == "__main__":
    # Create Bank System
    bank = BankSystem()

    alice = BankAccount(101, "Alice", initial_balance=200.0)
    bob = BankAccount(102, "Bob", initial_balance=100.0)

    bank.add_account(alice)
    bank.add_account(bob)

    alice.deposit(1200.0, "Salary")
    alice.withdraw(150.0, "Groceries")
    alice.withdraw(300.0, "Utilities")
    alice.deposit(400.0, "Freelance")

    bob.deposit(850.0, "Salary")
    bob.withdraw(200.0, "Entertainment")
    bob.withdraw(100.0, "Groceries")

    df_transactions = bank.export_to_dataframe()

    print("\n--- Processed DataFrame ---")
    print(df_transactions.to_string(index=False))

    analyze_and_plot(df_transactions)