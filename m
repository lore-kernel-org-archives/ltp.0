From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 10 May 2016 14:45:01 +0200
Subject: [LTP] [ANNOUNCE] The Linux Test Project has been released for MAY
 2016
Message-ID: <20160510124501.GA11038@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Good news everyone,

the Linux Test Project test suite stable release for *May 2016*
has been released.

Since the last release 169 patches by 24 authors were merged.

Notable changes are:

* New C library test API that significantly eases test writing

  This is the end result of last few years of cleanups and fixes. Most of the
  common code has been moved to the library which both helps to avoid common
  mistakes and lets the programmer concentrate on test itself. It also fixed
  long standing problems with thread safety, simplified test result propagation
  from child processes, fixed problems with cleanup callback, etc. If you ever
  given up on writing a LTP testcase because the test API was incomplete and
  difficult to use you should really reconsider now.

  The old and new test API will coexistent for a while until all old testcases
  are converted, which will take quite some time. New test are written using
  the new API only.

  You can have a quick look at new/converted tests to get a feel for the new API:

  https://github.com/linux-test-project/ltp/blob/master/testcases/kernel/syscalls/recvmsg/recvmsg02.c
  https://github.com/linux-test-project/ltp/blob/master/testcases/kernel/syscalls/creat/creat06.c

  Or have a look at updated documentation at:

  https://github.com/linux-test-project/ltp/wiki/Test-Writing-Guidelines#22-writing-a-test-in-c

* New syscall tests for:
  - request_key()
  - preadv()
  - pwritev(),
  - fcntl() + F_OFD_* locks
  - personality()
  - removexattr()
  - llistxattr()
  - epoll_pwait(),
  - epoll_wait()
  - open() + O_TMPFILE

  And regression tests for:
  - madvise() + MADV_WILLNEED
  - recvmsg() + MSG_PEEK

* Rewritten network stress tests

* New test for lsmod

* Usual amount of fixes
  - fixed file corruptions with ltp-pan
  - added a few return value checks for fork() where the value is later passed
    to kill() resulting in call to kill(-1, ...) if fork() failed
  - a few more skipped test on Btrfs on unsupported/unimplemented functionality
  - fixed test result propagation in five fcntl testcases
  + much more...

The latest version of the test-suite contains 3000+ tests for the Linux
and can be downloaded at:

https://github.com/linux-test-project/ltp/releases/tag/20160510

The project pages as well as GIT repository are hosted on GitHub:

https://github.com/linux-test-project/ltp
http://linux-test-project.github.io/

If you ever wondered how to write a LTP testcase, don't miss our
(continuously updated) developer documentation at:

https://github.com/linux-test-project/ltp/wiki/Test-Writing-Guidelines
https://github.com/linux-test-project/ltp/wiki/BuildSystem

Patches, new tests, bugs, comments or questions should go to to our
mailing list at ltp@lists.linux.it.

-- 
Cyril Hrubis
chrubis@suse.cz
