From: Matthew Bobrowski <mbobrowski@mbobrowski.org>
Date: Thu, 20 Jun 2019 19:57:38 +1000
Subject: [LTP] [PATCH v5 0/4] syscalls/fanotify: FAN_REPORT_FID and
 Directory Modification Events
Message-ID: <cover.1561018312.git.mbobrowski@mbobrowski.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This patch series contains the changes needed to validate the new
FAN_REPORT_FID flag and directory modification event functionality
within the fanotify API.

Changes since version 4:
	* Fixed problems with unbalanced file descriptor close.
	* Reorded functions in the test files fanotify13, fanotify14 and
	  fanotify15 so that they all follow a basic template i.e.

	  test()
	  ...
	  do_setup()
	  do_cleanup()

Thank you Amir for your feedback. 

Amir Goldstein (1):
  syscalls/fanotify13: add test coverage for fsid cache bug

Matthew Bobrowski (3):
  syscalls/fanotify13: new test to verify FAN_REPORT_FID functionality
  syscalls/fanotify14: new test to validate FAN_REPORT_FID interface
    return values
  syscalls/fanotify15: verify fid for dirent events

 configure.ac                                    |   1 +
 runtest/syscalls                                |   3 +
 testcases/kernel/syscalls/fanotify/.gitignore   |   3 +
 testcases/kernel/syscalls/fanotify/fanotify.h   |  81 +++++-
 testcases/kernel/syscalls/fanotify/fanotify05.c |   1 +
 testcases/kernel/syscalls/fanotify/fanotify13.c | 328 ++++++++++++++++++++++++
 testcases/kernel/syscalls/fanotify/fanotify14.c | 176 +++++++++++++
 testcases/kernel/syscalls/fanotify/fanotify15.c | 246 ++++++++++++++++++
 8 files changed, 836 insertions(+), 3 deletions(-)
 create mode 100644 testcases/kernel/syscalls/fanotify/fanotify13.c
 create mode 100644 testcases/kernel/syscalls/fanotify/fanotify14.c
 create mode 100644 testcases/kernel/syscalls/fanotify/fanotify15.c

-- 
2.16.4


-- 
Matthew Bobrowski
