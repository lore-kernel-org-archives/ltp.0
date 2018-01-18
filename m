From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 18 Jan 2018 15:53:35 +0100
Subject: [LTP] [ANNOUNCE] The Linux Test Project has been released for
 JANUARY 2018
Message-ID: <20180118145335.GA20730@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Good news everyone,

the Linux Test Project test suite stable release for *January 2018* has been
released.

Since the last release 278 patches by 35 authors were merged.

Notable changes for this release include:
-----------------------------------------

* New tests for:
  - unshare(1) command
  - ioctl07 test for RNDGETENTCNT ioctl()
  - new network MACsec testcases
  - new network IPsec SCTP and DCCP testcases

* New regression tests for:
  - CVE-2017-5754 aka meltdown
  - CVE-2017-12193 (test add_key04)
  - CVE-2017-15299 and CVE-2017-15951 (test request_key03)
  - CVE-2017-7308 (test setsockopt02)
  - CVE-2016-9604 (test keyctl08)
  - CVE-2017-15537 (test ptrace07)
  - CVE-2017-12192 (test keyctl07)
  - add_key03 regression test for kernel commit 237bbd29f7a0
  - keyctl06 regression test for kernel commit e645016abc80

* Fixed tests:
  - brk01 (test rewritten from scratch)
  - sigwaitinfo01 (fixed and enabled)
  - openposix aio testcases (uninitialized aiocb)
  + many smaller fixes

* Removed tests:
  - invalid openposix pthread_barrier_wait_6-1 test
  - tcp_cmds tests for rwho, echo, finger, and rdist.

* The test library gained support to run a particular test against
  different filesystems including FUSE filesystems such as NTFS or exFAT. The
  mkfs and kernel/FUSE support for a particular filesystem must be in-place
  otherwise the tests will skip it automatically.

  Some of the filesystem specific syscall tests such as fallocate() are
  executed this way now. We also have a new test that fills up filesystem
  using several threads and expects the syscalls to fail gracefully.

* The fuzzy synchronization library that is used to trigger races mostly in CVE
  testcases was rewritten to use one thread instead of starting a thread on
  each iteration, which is not only faster but also more stable since we
  introduce less random jitter to the timing measurements this way.

* Various fixes and enhancements for the network testcases.

* Support for NUMA API older than v2 was dropped from the testcases.

* The configure script now correctly detects devel libraries on -m32 build.

* Another large scale cleanup using coccinelle was done on the code base.

  We transformed patterns such as:

  if (scall(...) < 0)
          tst_brkm(TBROK, ...);

  into:

  SAFE_SCALL();

  Which will produce unified and more verbose error reporting in case
  that the call to scall() will fail.

* The runltp script now lists test skipped by the skipfile parameter as skipped
  in the testrun results, these were missing from it previously.

* 24 testcases were cleaned up and converted to the new test library

+ The usual amount of fixes all over the code base


Downloads and links:
--------------------

The latest version of the test-suite contains 3000+ tests for the Linux
and can be downloaded at:

https://github.com/linux-test-project/ltp/releases/tag/20180118

The project pages as well as GIT repository are hosted on GitHub:

https://github.com/linux-test-project/ltp
http://linux-test-project.github.io/

If you ever wondered how to write a LTP testcase, don't miss our developer
documentation at:

https://github.com/linux-test-project/ltp/wiki/C-Test-Case-Tutorial
https://github.com/linux-test-project/ltp/wiki/Test-Writing-Guidelines
https://github.com/linux-test-project/ltp/wiki/BuildSystem

Patches, new tests, bugs, comments or questions should go to to our mailing
list@ltp@lists.linux.it.

-- 
Cyril Hrubis
chrubis@suse.cz
