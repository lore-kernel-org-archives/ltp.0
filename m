From: Richard Palethorpe <rpalethorpe@suse.com>
Date: Fri,  5 Mar 2021 15:51:17 +0000
Subject: [LTP] [PATCH 0/6] Fuzzy Sync yielding and validation test
Message-ID: <20210305155123.18199-1-rpalethorpe@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello,

As suggested by Cyril, I have created a validation test so that we do
not have to reproduce a range of different kernel bugs for each change
to Fuzzy Sync.

Also I have built on Leo Yu-Chi Liang's patch to introduce yield. It
seemed to work mostly fine as it was. However I added some extra bits
to be safe (hopefully).

Leo Yu-Chi Liang (1):
  fzsync: Add sched_yield for single core machine

Richard Palethorpe (5):
  fzsync: Add self test
  fzsync: Reset delay bias
  fzsync: Correctly print positive lower delay range bound
  fzsync: Move yield check out of loop and add yield to delay
  fzsync: Check processor affinity

 include/tst_fuzzy_sync.h            | 119 +++++++++++---
 lib/newlib_tests/.gitignore         |   1 +
 lib/newlib_tests/test16.c           |   2 +
 lib/newlib_tests/tst_fuzzy_sync01.c | 233 ++++++++++++++++++++++++++++
 4 files changed, 331 insertions(+), 24 deletions(-)
 create mode 100644 lib/newlib_tests/tst_fuzzy_sync01.c

-- 
2.30.1

