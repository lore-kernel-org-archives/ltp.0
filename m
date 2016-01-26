From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 26 Jan 2016 14:02:27 +0100
Subject: [LTP] [ANNOUNCE] The Linux Test Project has been released for
	JANUARY 2016
Message-ID: <20160126130227.GA18139@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Good news everyone,

the Linux Test Project test suite stable release for *January 2016*
has been released.

Since the last release 191 patches by 29 authors were merged.

Notable changes are:

* Rewritten and new cgroup tests for cpuacct and pids controllers

* Rewritten basic cgroup functional and stress tests

* New userns07 test for user namespaces

* New syscall tests for:
  - renameat2()
  - sched_getattr()
  - sched_setattr()
  - kcmp()
  - fcntl(fd, F_SETLEASE)
  - preadv()
  - pwritev()

* New regression tests for:
  - signal()
  - mmap() + hugepages,
  - shmget()/shmat() + hugepages

* Open Posix pthread_create() tests were partially rewritten and
  no longer fail on machines with > 4 CPUS

* New tests for mkfs, mkswap, and which utilities

* New tests for kernel input stack (utilizing uinput)

* Fixes in nfs tests and IPV6 support

* New test for dctcp congestion control algorithm


The latest version of the test-suite contains 3000+ tests for the Linux
and can be downloaded at:

https://github.com/linux-test-project/ltp/releases/tag/20160126

The project pages as well as GIT repository are hosted on GitHub:

https://github.com/linux-test-project/ltp
http://linux-test-project.github.io/

If you ever wondered how to write a LTP testcase, don't miss our
(continuously updated) developer documentation at:

https://github.com/linux-test-project/ltp/wiki/Test-Writing-Guidelines
https://github.com/linux-test-project/ltp/wiki/BuildSystem

Patches, new tests, bugs, comments or questions should go to to our
new mailing list at ltp@lists.linux.it

PS: Special thanks to Italian Linux Society (www.ils.org) that provides us with
    rock solid mailing list hosting. This release wouldn't be possible without
    their kind help.

-- 
Cyril Hrubis
chrubis@suse.cz
