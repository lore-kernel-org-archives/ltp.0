From: Richard Palethorpe <rpalethorpe@suse.com>
Date: Fri, 10 Aug 2018 10:36:52 +0200
Subject: [LTP] [PATCH 0/2] Prevent spurious test timeouts and future changes
Message-ID: <20180810083654.28938-1-rpalethorpe@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This is a minimal change to prevent test timeouts while using the fuzzy sync
library. The patch just modifies the update function to check whether too much
time has elapsed since the test first called it. If so then we exit.

This effects all the tests using the fuzzy sync library except shmctl05 which
does not use the update function. However this should be handled in a future
update.

My current plan is to replace the update function with something like
start_race_a/b (or start_critical) and replace the time_a/b function with
end_race and remove the delay function. Meanwhile the wait functions will
remain the same.

The reasoning being that in all cases where there is a single race condition
between two threads: in each thread there is a section we want to overlap
where the race can happen (the critical section). Ideally all the test writer
should need to do is mark the beginning and end of this section in each
thread.

The fuzzy sync library can then perform as little or as much magic as it needs
to within the start and end functions (or macros).

To begin with I will probably turn the start function into a plain wait plus
the timer code. That is, I will remove the delay code. Meanwhile the end
function will just be a plain wait.

In the future these functions can be expanded to improve exploiting the race
condition. Most likely by introducing some random jitter once the loop
settles.

Richard Palethorpe (2):
  tst_timer: Add tst_timer_state_ms function
  fzsync: Limit execution time to prevent test timeouts

 include/tst_fuzzy_sync.h                      | 43 +++++++++++++------
 include/tst_timer.h                           |  7 +++
 lib/newlib_tests/test16.c                     |  3 +-
 lib/tst_timer.c                               | 11 +++++
 testcases/cve/cve-2014-0196.c                 |  3 +-
 testcases/cve/cve-2016-7117.c                 |  3 +-
 testcases/cve/cve-2017-2671.c                 |  3 +-
 testcases/kernel/syscalls/inotify/inotify09.c |  3 +-
 8 files changed, 58 insertions(+), 18 deletions(-)

-- 
2.18.0

