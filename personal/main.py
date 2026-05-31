from datasets import load_dataset

dataset = load_dataset("stanfordnlp/imdb", split="train")

dataset.to_csv("imdb_train.csv")
dataset.to_json("imdb_train.json")
dataset.to_parquet("imdb_train.parquet")

full = load_dataset("stanfordnlp/imdb")
print(full)
print(full["train"][0])

wiki = load_dataset("wikimedia/wikipedia", "20231101.en", split="train", streaming=True)

for i, example in enumerate(wiki):
    print(example["title"])
    if i >= 4:
        break
