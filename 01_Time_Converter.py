def minutes_to_human(total_minutes: int) -> str:
    
    if total_minutes < 0:
        raise ValueError("Minutes cannot be negative")
    hours = total_minutes // 60
    minutes = total_minutes % 60
    parts = []
    if hours == 1:
        parts.append(f"{hours} hr")
    elif hours > 1:
        parts.append(f"{hours} hrs")
    if minutes == 1:
        parts.append(f"{minutes} minute")
    elif minutes > 1 or minutes == 0:
        parts.append(f"{minutes} minutes")
    return ' '.join(parts)




if __name__ == '__main__':
    try:
        val = input("Enter total minutes (integer): ")
        total = int(val.strip())
        print(minutes_to_human(total))
    except Exception as e:
        print("Error:", e)