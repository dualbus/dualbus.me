---
layout: post
title: GNU Bash bugs
categories: bash linux
---

This is a list of the bugs in GNU Bash that I've reported:

* [Improper array name validation for the 'mapfile' builtin](
   https://lists.gnu.org/archive/html/bug-bash/2014-11/msg00097.html)

* [Segmentation fault when running recursive traps](
   https://lists.gnu.org/archive/html/bug-bash/2014-11/msg00092.html)

* [Issue when using job control and SIGCHLD with bash 4.3 (trap is not being
   run)](
   https://lists.gnu.org/archive/html/bug-bash/2014-04/msg00051.html)

* [Bash does not follow POSIX when return is called during the action of a trap](
   http://lists.gnu.org/archive/html/bug-bash/2014-03/msg00053.html)

* [Executing 'return' inside RETURN trap causes function to recurse infinitely](
   http://lists.gnu.org/archive/html/bug-bash/2014-03/msg00033.html)
  
  `f(){ trap return RETURN; }; f`

* [Parent shell gets stopped when a child shell is created with job control but
   not interactive (bash -mc)](
   http://lists.gnu.org/archive/html/bug-bash/2014-02/msg00091.html)

  `bash -s <<< 'for i in . .; do (bash -mc ": & wait") ; done'`

* [Invalid byte sequence under UTF-8 locale generates a segmentation fault when
   using printf %q (ansic_quote)](
   http://lists.gnu.org/archive/html/bug-bash/2014-02/msg00052.html)

      $ cat command-name 
      payload=$'\065\247\100\063\231\053\306\123\070\237\242\352\263'
      "$payload"
      
      $ cat printf-q 
      payload=$'\065\247\100\063\231\053\306\123\070\237\242\352\263'
      printf %q "$payload"
      
      $ cat set-x 
      payload=$'\065\247\100\063\231\053\306\123\070\237\242\352\263'
      (set -x; : "$payload")

* [DEL character treated specially when preceded by a backslash when used in
   the RHS of the regex operator (`[[ $'\177' =~ $'\\\177' ]]`)](
   http://lists.gnu.org/archive/html/bug-bash/2014-01/msg00091.html)

      for c in $'\001' $'\a' $'\177' $'\377'; do
          for r in "$c" "\\$c" "\\[$c]"; do
              [[ $c =~ $r ]];
              printf '[[ %q =~ %q ]] -> %d\n' "$c" "$r" "$?";
          done; printf %s\\n ---;
      done;

* [Unexpected behavior of single quotes when used in the patsub PE](
   http://lists.gnu.org/archive/html/bug-bash/2013-03/msg00099.html)

      #!/usr/bin/env bash
      for shell in bash mksh ksh zsh; do
      "$shell" <<'EOF'
        t() {
          printf '%s  |  %s\n' "$1" "$2"
        }
        v="'"       # v <- '
      
        printf '===\n%s %s\n---\n' \
          "$0" \
          "$BASH_VERSION"
      
        #--
        t "${v/$'\''/$'\''}"        "'"
        t  ${v/$'\''/$'\''}         "'"
        t "${v/$'\''/x}"            "x"
        t  ${v/$'\''/x}             "x"
        t "${v/x/$'\''}"            "'"
        t  ${v/x/$'\''}             "'"
        t "${v/x/$'\x5c\''}"        "'" #< I would actually expect these to
        t  ${v/x/$'\x5c\''}         "'" #< be \'
        t "${v/\'/\'}"              "'"
        t  ${v/\'/\'}               "'"
      EOF
      done

* [Behaviour of brace expansion is different in devel branch](
   http://lists.gnu.org/archive/html/bug-bash/2013-01/msg00037.html)

   `echo x{,}`

* [Segmentation fault in arithmetical expression when mixing array
   variables](
   http://lists.gnu.org/archive/html/bug-bash/2013-01/msg00036.html)
  
       #!/bin/bash
       
       echo "$BASH_VERSION"
       echo $(( a=(y[0] + y[1]) & 0xff, b=(y[2] + y[3]) & 0xff, a << 8 | b))
       
       # simpler
       ( y=(1 2); (( _ = y[0], _ = 1 )) ) # crash

* [%(fmt)T fails with large times in 64-bit linux](
   http://lists.gnu.org/archive/html/bug-bash/2012-09/msg00049.html)

       for i in {56..63}; do
           printf '%s ' $i;
           bash -c 'printf %\(%s\)T\\n $((2**$1))' _ $i;
       done
