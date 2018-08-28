From: Richard Palethorpe <rpalethorpe@suse.com>
Date: Tue, 28 Aug 2018 11:29:57 +0200
Subject: [LTP] [PATCH 0/5] New fuzzy sync library API
Message-ID: <20180828093002.20368-1-rpalethorpe@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This is a major change to how the tst_fuzzy_sync.h library works and how it is
used. Previously I was working on a slightly modified version which just
introduces a timeout, but while I was waiting for that to be reviewed I
started this and had a 'breakthrough'. So I have decided to skip the slightly
modified version and jump straight to this (as Li Wang suggested).

Below are some notes on the timing calculation (addressing Cyril's concerns)
which may make sense after reading the code and docs:

I have tested this on X86 and some ARM systems, including Rasp Pi. It appears
they all have high resolution clocks capable of taking the time measurments
required. To simulate a system with a low resolution clock I used
CLOCK_REALTIME_COARSE. The result was that the time measurement averages which
the algorithm relies on were all close to zero with a large deviation. In this
case the randomised delay is simply never activated, which seems like an
acceptable outcome as the library still functions without it. If the clock has
a low resolution, but the timings are consistently above zero, then a delay
will be calculated which is maybe too large or too small. This may degrade the
performance of the algorithm, but I doubt it will break it.

If the time between end_race_a and end_race_b is less than the clock
resolution or too variable then the algorithm won't be able to calculate the
number of spins required to create a suitable time delay. There are possible
solutions for this, but I haven't thought of any which reduce complexity
instead of increasing it. I have no idea if this will be a problem in
practice. In the common case it won't be, but it needs testing on a very
diverse set of systems.

Richard Palethorpe (5):
  lib: Allow user to easily get LTP_TIMEOUT_MUL value
  tst_timer: Create interface for using multiple timers
  tst_timer: Add nano second conversions
  fzsync: Simplify API with start/end race calls and limit exec time
  Convert tests to use fzsync_{start,end}_race API

 include/tst_fuzzy_sync.h                      | 634 +++++++++++++-----
 include/tst_test.h                            |   1 +
 include/tst_timer.h                           |  62 ++
 lib/newlib_tests/test16.c                     |  24 +-
 lib/tst_test.c                                |  23 +-
 lib/tst_timer.c                               |  21 +
 testcases/cve/cve-2014-0196.c                 |  25 +-
 testcases/cve/cve-2016-7117.c                 |  35 +-
 testcases/cve/cve-2017-2671.c                 |  23 +-
 testcases/kernel/syscalls/inotify/inotify09.c |  23 +-
 .../kernel/syscalls/ipc/shmctl/shmctl05.c     |  28 +-
 11 files changed, 615 insertions(+), 284 deletions(-)

-- 
2.18.0

