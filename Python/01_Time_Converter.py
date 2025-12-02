def convert_minutes(m):
    return f"{m//60} hrs {m%60} minutes"

if __name__=='__main__':
    print(convert_minutes(int(input())))