From: Richard Palethorpe <rpalethorpe@suse.com>
Date: Thu,  3 Aug 2017 17:33:45 +0200
Subject: [LTP] [RFC PATCH 0/4] Synchronising two threads
Message-ID: <20170803153349.32766-1-rpalethorpe@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

As well as fixing a bug, this patch allows two long running threads to be
synchronised at given points using memory barriers. Previously we were
effectively synchronising the threads by restarting one of them each
iteration. However this had a significant overhead and may have caused
greater variation in timings between iterations.

I am using __atomic_* builtins which don't exist on older compilers. I will
probably update tst_atomic.h and introduce some more tst_atomic_* functions.

Richard Palethorpe (4):
  fzsync: Add long running thread support
  Convert cve-2016-7117 test to use long running threads
  fzsync: Correctly handle timestamps across second boundaries
  fzsync: Print info from pair_update

 include/tst_fuzzy_sync.h      | 108 +++++++++++++++++++++++++++++++++++++++++-
 testcases/cve/cve-2016-7117.c |  32 ++++++-------
 2 files changed, 121 insertions(+), 19 deletions(-)

-- 
2.13.3

