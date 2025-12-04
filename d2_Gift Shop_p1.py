def solve(idx, ze, hi, lo):
    idx2 = idx + int((maxDigit - ze) / 2)
    if idx2 == maxDigit:
        if ze == maxDigit: return 0
        elif ze % 2 != 0: return 0
        elif idx2 == idx: return 0
        elif lo <= hi:
            # print(lo, hi)
            cnt[idx][ze][hi][lo] = 1
            return 1
        else: return 0
    if dp[idx][ze][hi][lo] != -1:
        return dp[idx][ze][hi][lo]
    
    cnt[idx][ze][hi][lo] = 0
    res = 0
    for num in range(0, 10):
        hi2, lo2 = hi, lo
        le = 0
        if ze == idx and num == 0: le = 1
        if (not le or idx >= boundZe):
            if num > bound[idx] and hi2 > idx: hi2 = idx
            if num < bound[idx] and lo2 > idx: lo2 = idx
            # if (idx == 14 and num == 1):
            #     print(num, idx, idx2, bound[idx], hi, lo, hi2, lo2, num < bound[idx], ze, idx + 1 + int((maxDigit - ze) / 2))
            # if (idx == 15 and num == 0):
            #     print(num, idx, idx2, bound[idx], hi, lo, hi2, lo2, num < bound[idx], ze, idx + 1 + int((maxDigit - ze) / 2))
        
            if num > bound[idx2] and hi2 > idx2: hi2 = idx2
            if num < bound[idx2] and lo2 > idx2: lo2 = idx2
            # if (idx == 14 and num == 1):
            #     print(num, idx, idx2, bound[idx], hi, lo, hi2, lo2, num < bound[idx], ze, idx + 1 + int((maxDigit - ze) / 2))
            # if (idx == 15 and num == 0):
            #     print(num, idx, idx2, bound[idx], hi, lo, hi2, lo2, num < bound[idx], ze, idx + 1 + int((maxDigit - ze) / 2))
        
        resFromSolve = solve(idx + 1, ze + le, hi2, lo2)
        if (idx == 16 and resFromSolve):
            # print(num, bound[idx], bound[idx2])
            pass
        if (cnt[idx + 1][ze + le][hi2][lo2] > 0):
            cnt[idx][ze][hi][lo] += cnt[idx + 1][ze + le][hi2][lo2]
            if (idx2 + 1 != maxDigit): res += resFromSolve
            if le:
                pass
            else:
                res += cnt[idx + 1][ze + le][hi2][lo2] * (num * (10**(maxDigit - idx - 1) + 10**(maxDigit - idx2 - 1)))
                # if (num == 1 and idx == 14):
                #     print(res, num, (10**(maxDigit - idx - 1) + 10**(maxDigit - idx2 - 1)))
    dp[idx][ze][hi][lo] = res
    return res
            
def memset(a):
    for idx in range(len(a)):
        for ze in range(len(a[0])):
            for hi in range(len(a[0][0])):
                for lo in range(len(a[0][0][0])):
                    a[idx][ze][hi][lo] = -1

inp = input()
inp = inp.split(',')
a = []
for x in inp:
    if x:
        a.append(tuple(map(int, x.split('-'))))
maxDigit = 18
maxAllocated = 20
bound = []
boundZe = 0
sum = 0
# dp[digit][leading_zeroes][zeroes][hi][lo], all 18 digits to be safe
dp = [[[[-1 for _ in range(maxAllocated)] for _ in range(maxAllocated)] 
        for _ in range(maxAllocated)] for _ in range(maxAllocated)]
cnt = [[[[-1 for _ in range(maxAllocated)] for _ in range(maxAllocated)] 
        for _ in range(maxAllocated)] for _ in range(maxAllocated)]

for l, r in a:
    memset(dp)
    memset(cnt)
    bound = [0 for x in range(maxDigit - len(str(l - 1)))]
    boundZe = len(bound)
    bound.extend(int(x) for x in str(l - 1))
    sum -= solve(0, 0, 18, 18)
    memset(dp)
    memset(cnt)
    bound = [0 for x in range(maxDigit - len(str(r)))]
    boundZe = len(bound)
    bound.extend(int(x) for x in str(r))
    sum += solve(0, 0, 18, 18)
print(sum)