Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1XMxiG-0003JU-8W
	for ltp-list@lists.sourceforge.net; Thu, 28 Aug 2014 11:17:56 +0000
Date: Thu, 28 Aug 2014 13:17:47 +0200
From: chrubis@suse.cz
Message-ID: <20140828111746.GA23303@rei.suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
Subject: [LTP] [ANNOUNCE] The Linux Test Project has been released for
 AUGUST 2014
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net, linux-kernel@vger.kernel.org, libc-alpha@sourceware.org
Cc: lwn@lwn.net, akpm@linux-foundation.org, torvalds@linux-foundation.org

Good news everyone,

the Linux Test Project test suite stable release for *August 2014* has
been released.

Since the last release 311 patches by 24 authors were merged.

Notable changes are:

* New testcases and improved coverage for: madvise, waitid, timerfd_*,
  getcwd, sched_setaffinity, sendfile, vmsplice, rename, renameat, open,
  openat, readlink, readlinkat, utime, wait, utimes, truncate, fstatfs,
  statvfs, statfs, splice, tee, setpgid, sbrk, readdir, setresgid,
  setresuid, rmdir, perf_event_open, ...

* Continued effort to cleanup old code:
  - many CRAY, SGI, ... ifdefs were removed
  - the test library headers were cleaned up a bit
  - several testcases were cleaned up or rewritten from a scratch

* The TCONF (testcase not appropriate for current configuration) test
  status is now propagated to the test exit value and included in
  the testrun results. (previously it was reported as passed)

* Testcases utilizing a block device can now prepare a loopback device
  automatically in the test setup.

* LTP test library has gained API to easily propagate test result from a
  child process to a parent process.

* Linux containers testcases were cleaned up.

* The can network test were fixed and cleaned up.

* The isofs testcases were fixed and cleaned up.

* Test messages for failures now contain source code filename and line.

* If test gets an unexpected signal the message contains not only the
  signal number but also symbolic name such as SIGINT.

* Various fixes for failures on Btrfs filesystem, on PPC64 LE, SPARC64
  and inside of KVM virtual machine.

* And many more smaller fixes and enhancements.

The latest version of the test-suite contains 3000+ tests for the Linux
and can be downloaded at:

http://sourceforge.net/projects/ltp/files/LTP%20Source/ltp-20140828/

The project pages as well as GIT repository are hosted on GitHub for
quite some time now:

https://github.com/linux-test-project/ltp
http://linux-test-project.github.io/

If you ever wondered how to write a LTP testcase, don't miss our
(continuously updated) developer documentation at:

https://github.com/linux-test-project/ltp/wiki/Test-Writing-Guidelines
https://github.com/linux-test-project/ltp/wiki/BuildSystem

Patches, new tests, bugs, comments or questions should go to
to our mailing list at ltp-list@lists.sf.net.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Slashdot TV.  
Video for Nerds.  Stuff that matters.
http://tv.slashdot.org/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
