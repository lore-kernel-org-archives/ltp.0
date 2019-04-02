From: Matthew Bobrowski <mbobrowski@mbobrowski.org>
Date: Tue, 2 Apr 2019 21:01:39 +1100
Subject: [LTP] [PATCH 0/4] fanotify: FAN_REPORT_FID and Directory
 Modification Events
Message-ID: <cover.1554197461.git.mbobrowski@mbobrowski.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This patch series contains the changes needed to support and validate the new
FAN_REPORT_FID flag and directory modification event functionality within the
fanotify API.

Amir Goldstein (1):
  syscalls/fanotify01: add FAN_REPORT_FID test cases

Matthew Bobrowski (3):
  syscalls/fanotify13: new test to verify FAN_REPORT_FID functionality
  syscalls/fanotify14: new test to validate FAN_REPORT_FID interface
    return values
  syscalls/fanotify15: verify fid for dirent events

 testcases/kernel/syscalls/fanotify/.gitignore   |   3 +
 testcases/kernel/syscalls/fanotify/fanotify.h   |  41 +++
 testcases/kernel/syscalls/fanotify/fanotify01.c |  41 ++-
 testcases/kernel/syscalls/fanotify/fanotify13.c | 329 ++++++++++++++++++++++++
 testcases/kernel/syscalls/fanotify/fanotify14.c | 170 ++++++++++++
 testcases/kernel/syscalls/fanotify/fanotify15.c | 256 ++++++++++++++++++
 6 files changed, 838 insertions(+), 2 deletions(-)
 create mode 100644 testcases/kernel/syscalls/fanotify/fanotify13.c
 create mode 100644 testcases/kernel/syscalls/fanotify/fanotify14.c
 create mode 100644 testcases/kernel/syscalls/fanotify/fanotify15.c

-- 
2.16.4


-- 
Matthew Bobrowski
