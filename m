From: Richard Palethorpe <rpalethorpe@suse.com>
Date: Mon,  5 Nov 2018 16:42:13 +0100
Subject: [LTP] [PATCH v4 0/4] New Fuzzy Sync library API
Message-ID: <20181105154217.18879-1-rpalethorpe@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Changes for V4:

* Increase fzsync timeout to 50% of the overall LTP test timeout
* Increase default iterations to 3 million
* Set cve-2014-0196 iterations to 50,000
* Increase sample iterations for cve-2016-7117

With these defaults almost all of the tests should reliably trigger their
bugs while not taking more than 30 seconds to execute on server grade
hardware. On slow embedded systems the tests should also be fairly reliable,
however will take up to 150 seconds.

Hopefully none of the tests will exit with a warning on slow systems because
they failed to complete the sampling phase. However on a very slow system
cve-2016-7117 will probably not have time to finish the sampling phase, but
this bug is simply very difficult to reproduce[1] on some kernels and a long
sampling time is required to get the optimal delay bias.

[1] To be more accurate, it is very difficult to cause a visible fault on some
kernels. The bug may always be riably triggered with the test, but the
probability of an illegal memory access are low.

Richard Palethorpe (4):
  tst_timer: Add nano second conversions
  fzsync: Simplify API with start/end race calls and limit exec time
  Convert tests to use fzsync_{start,end}_race API
  fzsync: Add delay bias for difficult races

 include/tst_fuzzy_sync.h                      | 781 ++++++++++++++----
 include/tst_timer.h                           |  11 +
 lib/newlib_tests/test16.c                     |  62 +-
 testcases/cve/cve-2014-0196.c                 |  39 +-
 testcases/cve/cve-2016-7117.c                 |  61 +-
 testcases/cve/cve-2017-2671.c                 |  32 +-
 testcases/kernel/syscalls/inotify/inotify09.c |  33 +-
 .../kernel/syscalls/ipc/shmctl/shmctl05.c     |  30 +-
 8 files changed, 725 insertions(+), 324 deletions(-)

-- 
2.18.0

