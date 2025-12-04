inp = input()
inp = inp.split(',')
a = []
for x in inp:
    if x:
        a.append(tuple(map(int, x.split('-'))))
sum = 0
# just a naive solution
for l, r in a:
    for x in range(l, r + 1):
        x = str(x)
        for repLen in range(1, len(x)):
            if (len(x) % repLen == 0 and len(x) / repLen > 1):
                isOk = 1
                repPattern = x[0:repLen]
                for repNum in range(1, int(len(x) / repLen)):
                    isOk &= (repPattern == x[repLen * repNum : repLen * (repNum + 1)])
                if isOk:
                    sum += int(x)
                    break
                    
print(sum)