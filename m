From: Richard Palethorpe <rpalethorpe@suse.com>
Date: Mon, 10 Sep 2018 10:44:38 +0200
Subject: [LTP] [PATCH v2 0/4] New Fuzzy Sync library API
Message-ID: <20180910084442.17720-1-rpalethorpe@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This second version is significantly different from the first. Amongst other
things I have dropped the new timer API I created in favor of Jan's timeout
function. The exit variable is now only checked and set in a single place
which has simplified the spin wait and the API usage.

However I have also had to introduce some extra complexity for the sake of
cve-2016-7117. After making some seemingly unrelated code changes (I guess the
main one was removing the exit flag check from the spin wait) the dominant
chronological order and therefor timings of the racing syscalls changed. To
fix this I added a delay bias to coerce the syscalls into the correct
order. This appears to work, but requires the test author to figure out a way
of setting the delay bias (easy enough for cve-2016-7117). I also attempted
simply expanding the delay range, but this was not effective. The test
requires a high level accuracy when setting the delay range, otherwise we will
not hit the race condition in a reasonable amount of time.

Another approach, which would be transparent to the test author, but require
even more complexity within the library. Would be to continue collecting
timing statistics once the random delays have been introduced to look for
statistically significant changes in the syscall timings caused by the
delay. If we can identify groups (clusters) of similar timings then we could
automatically create new delay ranges based on these timings. However I think
there is lower hanging fruit to be had before attempting anything like this.

Richard Palethorpe (4):
  tst_timer: Add nano second conversions
  fzsync: Simplify API with start/end race calls and limit exec time
  Convert tests to use fzsync_{start,end}_race API
  Add delay bias for difficult races

 include/tst_fuzzy_sync.h                      | 787 ++++++++++++++----
 include/tst_timer.h                           |  11 +
 lib/newlib_tests/test16.c                     |  62 +-
 testcases/cve/cve-2014-0196.c                 |  37 +-
 testcases/cve/cve-2016-7117.c                 |  59 +-
 testcases/cve/cve-2017-2671.c                 |  32 +-
 testcases/kernel/syscalls/inotify/inotify09.c |  33 +-
 .../kernel/syscalls/ipc/shmctl/shmctl05.c     |  30 +-
 8 files changed, 727 insertions(+), 324 deletions(-)

-- 
2.18.0

