From: Richard Palethorpe <rpalethorpe@suse.com>
Date: Thu, 24 Aug 2017 13:07:56 +0200
Subject: [LTP] [PATCH 0/6] Add long running thread support to fuzzy sync and
	update atomics
Message-ID: <20170824110803.9994-1-rpalethorpe@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello,

There is still atleast one feature I would like to add to the fuzzy sync
library (sliding window for the delay), but I think this is enough for now. I
have made quite a number of additions to the atomics fallbacks. I have updated
all the existing architectures, except ARC, and added SPARC. I have nothing
against ARC, I just don't have any hardware or an emulator to hand.

Thank you,
Richard.

Richard Palethorpe (6):
  tst_atomic: Add load, store, cmpxchg and use __atomic builtins
  tst_atomic: Add atomic store, load and cmpxchg tests
  fzsync: Add long running thread support and deviation stats
  Convert cve-2016-7117 test to use long running threads
  Convert cve-2014-0196 to use long running threads
  Convert cve-2017-2671 to use long running threads

 configure.ac                  |   1 +
 include/tst_atomic.h          | 381 ++++++++++++++++++++++++++++++++++++++----
 include/tst_fuzzy_sync.h      | 224 ++++++++++++++++++++++---
 lib/newlib_tests/.gitignore   |   1 +
 lib/newlib_tests/Makefile     |   1 +
 lib/newlib_tests/test15.c     | 160 ++++++++++++++++++
 m4/ltp-atomic.m4              |  34 ++++
 testcases/cve/cve-2014-0196.c |  50 +++---
 testcases/cve/cve-2016-7117.c |  43 +++--
 testcases/cve/cve-2017-2671.c |  30 ++--
 10 files changed, 826 insertions(+), 99 deletions(-)
 create mode 100644 lib/newlib_tests/test15.c
 create mode 100644 m4/ltp-atomic.m4

-- 
2.14.1

