From: Matthew Bobrowski <mbobrowski@mbobrowski.org>
Date: Sat, 20 Apr 2019 22:49:26 +1000
Subject: [LTP] [PATCH v2 0/3] FAN_REPORT_FID and Directory Modification
	Events
Message-ID: <cover.1555763787.git.mbobrowski@mbobrowski.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This patch series contains the changes needed to support and validate the new
FAN_REPORT_FID flag and directory modification event functionality within the
fanotify API.

Changes since version 1:
	* Added new line entries into runtest/syscalls to support newly defined
	  fanotify tests.
	
	* Defined new generic helper function within fanotify.h to remove code
	  duplication that was previsouly found across tests.

	* Added '.all_filesystems = 1' flag within tests fanotify14 and
	  fanotify15.

Matthew Bobrowski (3):
  syscalls/fanotify13: new test to verify FAN_REPORT_FID functionality
  syscalls/fanotify14: new test to validate FAN_REPORT_FID interface
    return     values
  syscalls/fanotify15: verify fid for dirent events

 runtest/syscalls                                |   3 +
 testcases/kernel/syscalls/fanotify/.gitignore   |   3 +
 testcases/kernel/syscalls/fanotify/fanotify.h   |  77 +++++-
 testcases/kernel/syscalls/fanotify/fanotify13.c | 313 ++++++++++++++++++++++++
 testcases/kernel/syscalls/fanotify/fanotify14.c | 171 +++++++++++++
 testcases/kernel/syscalls/fanotify/fanotify15.c | 245 +++++++++++++++++++
 6 files changed, 809 insertions(+), 3 deletions(-)
 create mode 100644 testcases/kernel/syscalls/fanotify/fanotify13.c
 create mode 100644 testcases/kernel/syscalls/fanotify/fanotify14.c
 create mode 100644 testcases/kernel/syscalls/fanotify/fanotify15.c

-- 
1.8.3.1


-- 
Matthew Bobrowski
