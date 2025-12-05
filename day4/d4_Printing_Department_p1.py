import sys

def isValid(x, bound):
    return x < bound and x >= 0

line = ""
ans = 0
a = []
dx = [-1, -1, -1, 1, 1, 1, 0, 0]
dy = [-1, 1, 0, -1, 1, 0, -1, 1]

for line in sys.stdin:
    if line == "": break
    line = line.strip()
    a.append(line)

for i in range(len(a)):
    for j in range(len(a[0])):
        cnt = 0
        for k in range(8):
            if isValid(i + dx[k], len(a)) and isValid(j + dy[k], len(a[0])):
                cnt += (a[i + dx[k]][j + dy[k]] == '@')
        if cnt < 4 and a[i][j] == '@':
            ans += 1
print(ans)