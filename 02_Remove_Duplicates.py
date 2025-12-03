def remove_duplicates(s: str) -> str:
    seen = set()
    result_chars = []
    for ch in s:
        if ch not in seen:
            seen.add(ch)
            result_chars.append(ch)
    return ''.join(result_chars)




if __name__ == '__main__':
    test_strings = ["banana", "aabbcc", "hello world", "1122334455"]
    for t in test_strings:
        print(t, '->', remove_duplicates(t))


# CLI mode
s = input('Enter a string to remove duplicate characters: ')
print(remove_duplicates(s))