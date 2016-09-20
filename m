From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 20 Sep 2016 11:11:33 +0200
Subject: [LTP] [ANNOUNCE] The Linux Test Project has been released for
 SEPTEMBER 2016
Message-ID: <20160920091133.GA17956@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Good news everyone,

the Linux Test Project test suite stable release for *September 2016*
has been released.

Since the last release 236 patches by 28 authors were merged.

Notable changes are:

o New testcases
  - tracepath, clockdiff, arpping, ping, wc, insmod
  - ftrace
  - access()
  - fallocate() FALLOC_FL_INSTERT_RANGE
  - kcmp()
  - lgetxattr()
  - sched_setscheduler()
  - epoll_ctl()
  - sbrk() regression test
  - dio_sparse added direct I/O regression test
    (https://patchwork.ozlabs.org/patch/622065/)

o Rewritten/cleaned up tests
  - waitpid syscall testcases
  - NFS tests
  - ftrace tests

o More work on memory cgroup testcases
  - a lot of cleanups, big tests were split into smaller ones
  - implemented proper synchronization primitives between processes
    which saves a few minutes on the test execution time

o More work on the new test API
  - test is executed in child processes, parent process watches for timeout,
    does cleanup, reports results, etc.
  - Ctrl+C kills all subprocesses correctly and the parent process runs cleanup
  - new command line option parsing helpers
  - 25 testcases were cleaned up and rewritten to use the new test API

o New EXPECT_PASS and EXPECT_FAIL helpers in shell library

o New shell wrappers for checkpoint (futex based) synchronization primitives

o New tst_su wrapper (that makes sure that path to LTP binaries is in $PATH)

o Open Posix Testsuite changes
  - parallel build has been fixed
  - the build process now uses the top level configure parameters
    (CC, CFLAGS, LDLIBS, LDFLAGS)

+ The usuall amount of cleanups, fixes, and speedups.

The latest version of the test-suite contains 3000+ tests for the Linux
and can be downloaded at:

https://github.com/linux-test-project/ltp/releases/tag/20160920

The project pages as well as GIT repository are hosted on GitHub:

https://github.com/linux-test-project/ltp
http://linux-test-project.github.io/

If you ever wondered how to write a LTP testcase, don't miss our
(continuously updated) developer documentation at:

https://github.com/linux-test-project/ltp/wiki/Test-Writing-Guidelines
https://github.com/linux-test-project/ltp/wiki/BuildSystem

Patches, new tests, bugs, comments or questions should go to to our
mailing list at ltp-list@lists.linux.it

-- 
Cyril Hrubis
chrubis@suse.cz
