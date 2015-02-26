dualbus@ubuntu:~$ mkdir .gnupg/private-keys-v1.d/
dualbus@ubuntu:~$ ls -la .gnupg/
total 976
drwx------  3 dualbus dualbus   4096 sep 21 10:22 .
drwxr-xr-x 19 dualbus dualbus   4096 sep 21 10:11 ..
-rwx------  1 dualbus dualbus   7888 feb 27  2013 gpg.conf
-rw-r--r--  1 dualbus dualbus      0 sep 21 10:21 .gpg-v21-migrated
drwxr-xr-x  2 dualbus dualbus   4096 sep 21 10:22 private-keys-v1.d
-rwx------  1 dualbus dualbus 481844 sep 21 10:13 pubring.gpg
-rwx------  1 dualbus dualbus 481525 sep 21 10:11 pubring.gpg~
-rwx------  1 dualbus dualbus    600 mar 25  2016 random_seed
-rw-------  1 dualbus dualbus   2985 oct 10  2013 secring.gpg
-rwx------  1 dualbus dualbus   2560 sep 21 10:11 trustdb.gpg
dualbus@ubuntu:~$ gpg2   -v --batch --import .gnupg/secring.gpg 
gpg: sec  rsa2048/F4CB141A407BA4CF 2013-02-27   Eduardo Alán Bustamante López (dualbus) <dualbus@gmail.com>
gpg: pub  rsa2048/F4CB141A407BA4CF 2013-02-27  Eduardo Alán Bustamante López (dualbus) <dualbus@gmail.com>
gpg: key F4CB141A407BA4CF: "Eduardo Alan Bustamante López (https://dualbus.me) <is@dualbus.me>" not changed
gpg: key F4CB141A407BA4CF/F4CB141A407BA4CF: secret key imported
gpg: key F4CB141A407BA4CF/6A0315BB1F92550C: secret key imported
gpg: key F4CB141A407BA4CF: secret key imported
gpg: Total number processed: 1
gpg:              unchanged: 1
gpg:       secret keys read: 1
gpg:   secret keys imported: 1
