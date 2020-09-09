From: Amir Goldstein <amir73il@gmail.com>
Date: Wed,  9 Sep 2020 20:56:57 +0300
Subject: [LTP] [PATCH 00/10] Fanotify tests for v5.9
Message-ID: <20200909175707.10670-1-amir73il@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Petr,

Following are the tests that were used to develop the upcoming fanotify
features in v5.9.

The inotify/dnotify tests and fanotify09 test case are regression tests
for a mid series bug that has been fixed before the merge.

fanotify10 gets another set of test cases to catch yet another ignored
mask logic bug. The fix commit will be too hard to backport IMO, so
perhaps these test cases should go into a new test with .min_kver = "5.9".

Thanks,
Amir.

Amir Goldstein (10):
  syscalls/fanotify14: Test cases for FAN_REPORT_DFID_NAME
  syscalls/fanotify16: Adjust test to use FAN_REPORT_DFID_NAME
  syscalls/fanotify16: Test more event types with name
  syscalls/fanotify16: Add test cases more init flag combinations
  syscalls/fanotify16: Verify child fid info
  syscalls/fcntl: New test for F_NOTIFY (dnotify)
  syscalls/inotify: New test for watches on both parent and child
  syscalls/fanotify09: Add test case with parent and subdir marks
  syscalls/fanotify10: Test with group flag FAN_REPORT_NAME
  syscalls/fanotify10: Add test cases for merge with ignored mask on
    directory

 runtest/syscalls                              |   3 +
 testcases/kernel/syscalls/fanotify/fanotify.h |  29 +-
 .../kernel/syscalls/fanotify/fanotify09.c     |  57 ++--
 .../kernel/syscalls/fanotify/fanotify10.c     | 181 ++++++++---
 .../kernel/syscalls/fanotify/fanotify14.c     |  10 +-
 .../kernel/syscalls/fanotify/fanotify16.c     | 306 ++++++++++++++----
 testcases/kernel/syscalls/fcntl/fcntl38.c     |  96 ++++++
 testcases/kernel/syscalls/inotify/.gitignore  |   1 +
 testcases/kernel/syscalls/inotify/inotify10.c | 149 +++++++++
 9 files changed, 712 insertions(+), 120 deletions(-)
 create mode 100644 testcases/kernel/syscalls/fcntl/fcntl38.c
 create mode 100644 testcases/kernel/syscalls/inotify/inotify10.c

-- 
2.17.1

