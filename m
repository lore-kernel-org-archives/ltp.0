From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 16 May 2017 17:56:09 +0200
Subject: [LTP] [ANNOUNCE] The Linux Test Project has been released for May
	2017
Message-ID: <20170516155609.GA26861@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Good news everyone,

the Linux Test Project test suite stable release for *May 2017*
has been released.

Since the last release 264 patches by 28 authors were merged.

Notable changes are:

o New tests for:
  - quotaclt() regression test
  - quotactl() Q_XGETNEXTQUOTA
  - lseek() SEEK_HOLE and SEEK_DATA
  - keyctl() regression tests
  - memfd_create() tests
  - madvise() MADV_FREE, MADV_DONTDUMP, MADV_HWPOISON
  - recvmsg() regression test
  - getxattr() regression test
  - ioctl() BLKGETSIZE/BLKGETSIZE64, BLKRAGET/BLKRASET, BLKROSET/BLKROGET
  - move_pages() regression test

o Additional 47 testcases were cleaned up and converted to the new test library.

o SAFE_MACROS() can now be used in test cleanup which significantly simplifies
  test cleanup functions.

o Numa memory migration testcases were cleaned up and fixed.

o Minimal testing device size was bumped to 256MB in order to support modern
  filesystems.

o Initiall ANDROID support was merged in.

o Test output is now colorized in case that we print to terminal.

+ The usuall amount of fixes all around the place

The latest version of the test-suite contains 3000+ tests for the Linux
and can be downloaded at:

https://github.com/linux-test-project/ltp/releases/tag/20170516

The project pages as well as GIT repository are hosted on GitHub:

https://github.com/linux-test-project/ltp
http://linux-test-project.github.io/

If you ever wondered how to write a LTP testcase, don't miss our
developer documentation at:

https://github.com/linux-test-project/ltp/wiki/Test-Writing-Guidelines
https://github.com/linux-test-project/ltp/wiki/BuildSystem

Patches, new tests, bugs, comments or questions should go to to our
mailing list at ltp@lists.linux.it.

-- 
Cyril Hrubis
chrubis@suse.cz
