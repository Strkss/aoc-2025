import sys

def memset(a):
    for i in range(len(a)):
        for j in range(len(a[0])):
            a[i][j] = 0

line = ""
sum = 0
maxN = 200
# dp[i][k] = max(dp[j in [0, i)][k - 1] * 10 + a[i])
dp = [[0 for _ in range(13)] for _ in range(maxN)]
for line in sys.stdin:
    ans = 0
    line = [int(x) for x in line if x >= '0' and x <= '9']
    if len(line) == 0: break
    memset(dp)
    
    for i in range(len(line)):
        for k in range(1, 13):
            if k == 1:
                # print(i, line[i], dp[i][k])
                dp[i][k] = line[i]
                continue
            for j in range(0, i):
                dp[i][k] = max(dp[i][k], dp[j][k - 1] * 10 + line[i])
                ans = max(ans, dp[i][k])
    sum += ans

print(sum)
    