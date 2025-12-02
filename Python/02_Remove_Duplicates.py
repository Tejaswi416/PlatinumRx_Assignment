def remove_duplicates(s):
    r=''
    for c in s:
        if c not in r: r+=c
    return r

if __name__=='__main__':
    print(remove_duplicates(input()))