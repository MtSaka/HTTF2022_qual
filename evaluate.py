import os

path = "score.txt"
res = 0
cnt = 0
min_score = 3000
max_score = 0
with open(path) as f:
  string = f.readlines()
  for line in string:
    now=int(line.split()[2])
    res += now
    cnt += 1
    max_score=max(max_score,now)
    min_score=min(min_score,now)
print(f"合計: {res}")
print(f"平均: {res / cnt}")
print(f"最低得点: {min_score}")
print(f"最高得点: {max_score}")