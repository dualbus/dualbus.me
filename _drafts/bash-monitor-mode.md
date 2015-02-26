http://www.gnu.org/software/bash/manual/html_node/Job-Control-Basics.html#Job-Control-Basics

When monitor mode is enabled, bash uses two different process groups: one for
the foreground jobs, and another one for the background jobs.

When monitor mode is disabled, bash uses the same group for both, and just
ignores signals in the backgrounded processes.
