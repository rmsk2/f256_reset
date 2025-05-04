import sys

BLOCK_LEN = 8192

with open(sys.argv[1], "rb") as f:
    data_loader = f.read()


pad_bytes = BLOCK_LEN - len(data_loader)

if pad_bytes < 0:
    print("Binary is too large. We need another 8K block.")
    sys.exit(42)

print(f"Bytes to pad in 8K block: {pad_bytes}")

end_pad = bytearray(BLOCK_LEN)
data = data_loader + end_pad[0:pad_bytes]

with open(sys.argv[2], "wb") as f:
    f.write(data)
    
    