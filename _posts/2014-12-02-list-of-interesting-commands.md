---
layout: post
title: List of interesting commands
categories: cli gnulinux
---

SSH Keys
-----------

* rsa keys with openssl

      # Write the public part of a RSA key in OpenSSH format (basically
      # just prefix it with 'ssh-rsa' and collapse everything. Also remove
      # the ASCII guards.
      openssl pkey -in file.pem -pubout | sed -ne :a -e '1d;$!{H;n;ba;}' \
        -e 'x;s/\n//g;s/^/ssh-rsa /p'

      # Generate a RSA private SSH key, using OpenSSL's genpkey command
      # (4096 bits)
      openssl genpkey -out file.pem -outform PEM -algorithm rsa \
        -pkeyopt rsa_keygen_bits:4096


Bash
----

* group files by extension with associative arrays

      # Read a list of files with sizes and group them by extension, adding
      # the size.
      
      declare -A files=();
      while read -r size filename; do
        basename=${filename##*/}; ((files["${basename##*.}"]+=size));
      done <<<  $'10 foo/bar/baz.ext\n20 foo/bar/bleh.ext\n40 music/some/song.mp3'
      declare -p files
      
      Output:
      > declare -A files='([mp3]="40" [ext]="30" )'


Git
---

* branches

      # Delete a branch in a remote
      git push <remote> :branch_name

      # Update a remote, considering also deleted branches
      git remote update -p # -p comes from 'prune'
