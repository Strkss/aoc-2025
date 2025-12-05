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
    a.append([x for x in line])

adj = []
for i in range(len(a)):
    for j in range(len(a[0])):
        cnt = 0
        for k in range(8):
            if isValid(i + dx[k], len(a)) and isValid(j + dy[k], len(a[0])):
                cnt += (a[i + dx[k]][j + dy[k]] == '@')
        if cnt < 4 and a[i][j] == '@':
            adj.append((i, j))
# Only check cell which is adjacent to newly removed cell
while len(adj) > 0:
    i, j = adj[0][0], adj[0][1]
    adj.pop(0)
    if a[i][j] == '.': continue
    a[i][j] = '.'
    ans += 1
    # Check adjacent cell to the newly removed cell
    for k in range(8):
        newX = i + dx[k]
        newY = j + dy[k]
        cnt = 0
        if isValid(newX, len(a)) and isValid(newY, len(a[0])) and a[newX][newY] == '@':
            for k in range(8):
                if isValid(newX + dx[k], len(a)) and isValid(newY + dy[k], len(a[0])):
                    cnt += (a[newX + dx[k]][newY + dy[k]] == '@')
            # if (newX == 0 and newY == 7):
            #     print(cnt, a[newX][newY])
            if cnt < 4 and a[newX][newY] == '@':
                adj.append((newX, newY))
                # print(i, j)

print(ans)