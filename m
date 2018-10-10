From: Richard Palethorpe <rpalethorpe@suse.com>
Date: Wed, 10 Oct 2018 16:04:01 +0200
Subject: [LTP] [PATCH v3 0/4] New Fuzzy Sync library API
Message-ID: <20181010140405.24496-1-rpalethorpe@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Changes from V2 -> v3:
 Add warning if test times out before sampling has finished
 Take timestamp after delay so bias is not included during sampling
 Use absolute max dev ratio
 Don't discard stats after delay bias change
 Correct default exec time
 Fix some documentation typos
 Drop atomic store of exit
 Use NULL instead of 0 in pthread_join
 include range bounds
 Use static inline instead of unused

Richard Palethorpe (4):
  tst_timer: Add nano second conversions
  fzsync: Simplify API with start/end race calls and limit exec time
  Convert tests to use fzsync_{start,end}_race API
  fzsync: Add delay bias for difficult races

 include/tst_fuzzy_sync.h                      | 785 ++++++++++++++----
 include/tst_timer.h                           |  11 +
 lib/newlib_tests/test16.c                     |  62 +-
 testcases/cve/cve-2014-0196.c                 |  37 +-
 testcases/cve/cve-2016-7117.c                 |  59 +-
 testcases/cve/cve-2017-2671.c                 |  32 +-
 testcases/kernel/syscalls/inotify/inotify09.c |  33 +-
 .../kernel/syscalls/ipc/shmctl/shmctl05.c     |  30 +-
 8 files changed, 725 insertions(+), 324 deletions(-)

-- 
2.18.0

