From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 16 Jan 2017 17:03:41 +0100
Subject: [LTP] [ANNOUNCE] The Linux Test Project has been released for
 JANUARY 2017
Message-ID: <20170116160340.GA2586@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Good news everyone,

the Linux Test Project test suite stable release for *January 2017*
has been released.

Since the last release 211 patches by 28 authors were merged.

Notable changes:

    o New testcases for:
      - flistxattr()
      - listxattr()
      - llistxattr()
      - getpriority()
      - setpriority()
      - sendto()
      - dirtyc0w
      - vti and geneve tunnel tests (network tests)

    o New shell test library was added and many old and broken tests were
      rewritten to make use of it

    o 36 syscall testcases were converted to the new library

    o Many cases of bashism were fixed

    o Experimental support for network namespaces has been added into network
      tests, which means that these test can now be optionally executed on a
      single testing machine

    o LTP compiled for 32bit should now run flawlessly on 64bit kernel
      which is useful for testing the 32bit compat syscall interface

    + Usuall amount of cleanups, fixes and speedups.

Another bit worth mentioning is that LTP now uses travis to compile test latest
git head.

The latest version of the test-suite contains 3000+ tests for the Linux
and can be downloaded at:

https://github.com/linux-test-project/ltp/releases/tag/20170116

The project pages as well as GIT repository are hosted on GitHub:

https://github.com/linux-test-project/ltp
http://linux-test-project.github.io/

If you ever wondered how to write LTP testcase, don't miss documentation at:

https://github.com/linux-test-project/ltp/wiki/Test-Writing-Guidelines
https://github.com/linux-test-project/ltp/wiki/BuildSystem

Patches, new tests, bugs, comments or questions should go to to our
mailing list at ltp@lists.linux.it.

-- 
Cyril Hrubis
chrubis@suse.cz
