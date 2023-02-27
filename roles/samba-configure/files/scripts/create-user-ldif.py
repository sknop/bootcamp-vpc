# little script to create LDIF files from list of users

import json
import sys
import base64

def create_unicode_password(password):
    with_quotes = '\"' + password + '\"'
    encoded = with_quotes.encode('utf-16le')
    pwd = base64.b64encode(encoded)

    return pwd.decode('utf8')

def create_user(base_dn, realm, principal, cn, password):
    user_attrs = {
        "dn" : f"CN={cn},{base_dn}",
        "objectClass" : "user",
        "accountExpires" : 0,
        "userPrincipalName" : f"{principal}@{realm}",
        "sAMAccountName" : principal,
        "userAccountControl" : 66048,
        "unicodePwd:" : create_unicode_password(password)
    }

    filename = principal + ".ldif"
    with open(filename, 'w') as f:
        for key, value in user_attrs.items():
            print(f"{key}: {value}", file=f)

def create_users(base_dn, realm, user_file):
    for principal, details in user_file.items():
        cn = details[0]
        password = details[1]

        create_user(base_dn, realm, principal, cn, password)

def load_users_file(filename):
    with open(filename) as f:
        content = f.read()

    return json.loads(content)

if __name__ == '__main__':
    if len(sys.argv) < 2:
        print("Usage: " + sys.argv[0] + " <base-dn> <realm> <user-file>", file=sys.stderr)
        sys.exit(1)

    the_base_dn = sys.argv[1]
    the_realm = sys.argv[2]
    user_file = sys.argv[3]

    the_users = load_users_file(user_file)

    create_users(the_base_dn, the_realm, the_users)
