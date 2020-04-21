From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 21 Apr 2020 09:49:58 +0300
Subject: [LTP] [PATCH 0/4] fanotify ltp tests for v5.7-rc1
Message-ID: <20200421065002.12417-1-amir73il@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,

Following patches test kernel code merged to v5.7-rc1.

Patch 1,3 test fanotify minor bug fixes, which could be backported
to stable kernels.

Patch 2 makes test fanotify15 more robust, by making less assumptions,
in preparation for adding a test case.

Patch 4 adds a new test for the new event type FAN_MODIFY_DIR, which
carries a new event format (parent fid + name).

Thanks,
Amir.

Amir Goldstein (4):
  syscalls/fanotify09: Check merging of events on directories
  syscalls/fanotify15: Minor corrections
  syscalls/fanotify15: Add a test case for inode marks
  syscalls/fanotify: New test for FAN_MODIFY_DIR

 runtest/syscalls                              |   1 +
 testcases/kernel/syscalls/fanotify/.gitignore |   1 +
 testcases/kernel/syscalls/fanotify/fanotify.h |  15 +-
 .../kernel/syscalls/fanotify/fanotify09.c     |  46 +-
 .../kernel/syscalls/fanotify/fanotify15.c     | 128 ++++-
 .../kernel/syscalls/fanotify/fanotify16.c     | 441 ++++++++++++++++++
 6 files changed, 595 insertions(+), 37 deletions(-)
 create mode 100644 testcases/kernel/syscalls/fanotify/fanotify16.c

-- 
2.17.1

