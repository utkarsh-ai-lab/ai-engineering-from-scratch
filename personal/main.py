from datasets import load_dataset

imdb = load_dataset("stanfordnlp/imdb")
train = imdb["train"]

split = train.train_test_split(test_size=0.2, seed=42)
train_val = split["train"].train_test_split(test_size=0.125, seed=42)
train_ds = train_val["train"]
val_ds = train_val["test"]
test_ds = split["test"]
print(f"Train: {len(train_ds)}, Val: {len(val_ds)}, Test: {len(test_ds)}")

train.to_csv("imdb_train.csv")
train.to_json("imdb_train.json")
train.to_parquet("imdb_train.parquet")

print(imdb)
print(train[0])

wiki = load_dataset("wikimedia/wikipedia", "20231101.en", split="train", streaming=True)
for i, example in enumerate(wiki):
    print(example["title"])
    if i >= 4:
        break

