From: Matthew Bobrowski <mbobrowski@mbobrowski.org>
Date: Sun, 19 May 2019 15:25:13 +1000
Subject: [LTP] [PATCH v3 0/3] syscalls/fanotify: FAN_REPORT_FID and
 Directory Modification Events
Message-ID: <cover.1558242368.git.mbobrowski@mbobrowski.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This patch series contains the changes needed to validate the new
FAN_REPORT_FID flag and directory modification event functionality
within the fanotify API.

Changes since version 2:
	* Added an ifdef statement within fanotify_get_fid() to check
	  for name_to_handle_at() support.

Matthew Bobrowski (3):
  syscalls/fanotify13: new test to verify FAN_REPORT_FID functionality
  syscalls/fanotify14: new test to validate FAN_REPORT_FID interface
  values
  syscalls/fanotify15: verify fid for dirent events

 configure.ac                                  |   1 +
 runtest/syscalls                              |   3 +
 testcases/kernel/syscalls/fanotify/.gitignore |   3 +
 testcases/kernel/syscalls/fanotify/fanotify.h |  81 ++++-
 .../kernel/syscalls/fanotify/fanotify13.c     | 313 ++++++++++++++++++
 .../kernel/syscalls/fanotify/fanotify14.c     | 171 ++++++++++
 .../kernel/syscalls/fanotify/fanotify15.c     | 245 ++++++++++++++
 7 files changed, 814 insertions(+), 3 deletions(-)
 create mode 100644 testcases/kernel/syscalls/fanotify/fanotify13.c
 create mode 100644 testcases/kernel/syscalls/fanotify/fanotify14.c
 create mode 100644 testcases/kernel/syscalls/fanotify/fanotify15.c

-- 
2.21.0

-- 
Matthew Bobrowski
