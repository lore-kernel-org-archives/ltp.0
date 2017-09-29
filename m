From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 29 Sep 2017 17:31:24 +0200
Subject: [LTP] [ANNOUNCE] The Linux Test Project has been released for
 SEPTEMBER 2017
Message-ID: <20170929153123.GB1886@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Good news everyone,

the Linux Test Project test suite stable release for *September 2017* has been
released.

Since the last release 290 patches by 39 authors were merged.


Notable changes for this release include:
-----------------------------------------

* New tests for:
  - copy_file_range()
  - splice() between pipes and sockets
  - splice() between two pipes
  - clone() with CLONE_NEWNET
  - msync() with mmaped file
  - getsockopt() with SO_PEERCRED
  - fanotify() with FAN_CLOEXEC
  - dynamic_debug tracing
  - basic gdb test
  - combination of OFD and POSIX locks on a file

* New regression tests for:
  - fanotify() 96d41019e3ac and 05f0e38724e8
  - add_key() 5649645d725c
  - fcntl() 086e774a57fb
  - sched/autogroup 18f649ef3441
  - memcg https://bugzilla.redhat.com/show_bug.cgi?id=1168185
  - vdso permissions b6558c4a2378 and e5b97dde514f
  - keyctl() 63a0b0509e70
  - numa MPOL_PREFERRED policy 0867a57c

* Removed tests:
  - long broken dmapi testsuite

* 66 testcases were cleaned up and converted to the new test library

* KSM (kernel samepage merging) test should be race-free now

* So far if only small part of a test reported skipped status the overall test
  status was reported as skipped as well. Now if test reports both sucessful and
  skipped results the overall status is reported as suscessful.

* Timer mesurement library code was introduced
  - all syscalls that use kernel timers are measured in a unified way
  - we take much more samples and use discarded mean to get rid of outliners
  - the threshold is now defined in the library and can be easily adjusted
  - for more information see:
    https://github.com/linux-test-project/ltp/commit/c459654db64cd29177a382ab178fdd5ad59664e4

* Also effort to convert CVE reproducers into LTP testcases started to gain
  momentum

  - It starts by introducing thread synchronization library that auto-tunes a
    spin-in-a-place delay so that we execute two critical sections of code at
    the same time, which makes tests based on races much faster and stable in
    reproducing the bugs.

  - So far implemented CVE tests include:
    - CVE-2011-0999 transparent hugepages used wrongly for args/env
    - CVE-2011-2183 NULL pointer dereference in ksm_do_scan()
    - CVE-2011-2496 address overflow in mremap()
    - CVE-2012-0957 uname26 memory leak
    - CVE-2014-0196 PTY echo race
    - CVE-2015-0235 buffer overflow in gethostbyname_r()
    - CVE-2015-7550 race between keyctl_read() and keyctl_revoke()
    - CVE-2016-4470 uninitialized variable in key_reject_and_link()
    - CVE-2016-5195 aka dirtyc0w
    - CVE-2016-7042 crash in /proc/keys show function
    - CVE-2016-7117 use after free between recvmmsg() and close()
    - CVE-2016-10044 mark AIO pseudo-fs noexec
    - CVE-2017-2618 off-by-one in setprocattr
    - CVE-2017-2671 missing rwlock in ping_unhashed()
    - CVE-2017-5669 NULL page mapped with shmat() and SHM_RND
    - CVE-2017-6951 NULL dereference in request_key()
    - CVE-2017-7472 thread keyring memory leak
    - CVE-2017-1000364 aka stack_clash

    Note that a few of the testcases were implemented in the previous
    release as well but these were not counted as CVE related.

* The ltp-pan testrunner that executes LTP testcases marks test start in kernel
  log, which helps with pairing LTP testcase with a kernel trace.

* There is new step-by-step C test tutorial at:
  https://github.com/linux-test-project/ltp/wiki/C-Test-Case-Tutorial

* A few EROFS related testcases now use read-only tmpfs instead of the loopback
  based device, which saves up to half of a minute of runtime per such testcase.
  The rest of such testcases will be converted after the release.

* The nfsv4 locktest source has been translated from French.

* Many fixes in numa testcases.

* Many fixes in network testcases.

+ The usuall amount of fixes all over the codebase


What havent't made it to this release:
--------------------------------------

* A patchset that adds test library support to allow for filesystem related
  syscalls, such as fallocate(), to be executed against all supported
  filesystems.

* Fixes and speed ups for the CVE synchronization library and a few CVE
  reproducers.


Downloads and links:
--------------------

The latest version of the test-suite contains 3000+ tests for the Linux
and can be downloaded at:

https://github.com/linux-test-project/ltp/releases/tag/20170930

The project pages as well as GIT repository are hosted on GitHub:

https://github.com/linux-test-project/ltp
http://linux-test-project.github.io/

If you ever wondered how to write a LTP testcase, don't miss our developer
documentation at:

https://github.com/linux-test-project/ltp/wiki/C-Test-Case-Tutorial
https://github.com/linux-test-project/ltp/wiki/Test-Writing-Guidelines
https://github.com/linux-test-project/ltp/wiki/BuildSystem

Patches, new tests, bugs, comments or questions should go to to our mailing
list at ltp@lists.linux.it.

-- 
Cyril Hrubis
chrubis@suse.cz
