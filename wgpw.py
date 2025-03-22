import bcrypt
import sys

def generate_hash(password: str):
    salt = bcrypt.gensalt(12)
    hash = bcrypt.hashpw(password.encode(), salt)
    print(hash.decode())

def compare_password(password: str, hash: str):
    if bcrypt.checkpw(password.encode(), hash.encode()):
        print("Password matches the hash!")
    else:
        print("Password does not match the hash.")

if __name__ == "__main__":
    args = sys.argv[1:]

    if len(args) > 2 or len(args) < 1:
        print("Usage: python bcrypt.py YOUR_PASSWORD [HASH]")
        sys.exit(1)

    password = args[0]
    if len(args) == 2:
        compare_password(password, args[1])
    else:
        generate_hash(password)
