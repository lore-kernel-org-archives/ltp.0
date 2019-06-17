From: Matthew Bobrowski <mbobrowski@mbobrowski.org>
Date: Mon, 17 Jun 2019 20:34:55 +1000
Subject: [LTP] [PATCH v4 0/3] syscalls/fanotify: FAN_REPORT_FID and
 Directory Modification Events
Message-ID: <cover.1560766652.git.mbobrowski@mbobrowski.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This patch series contains the changes needed to validate the new
FAN_REPORT_FID flag and directory modification event functionality
within the fanotify API.

Changes since version 3:
        * Added missing _GNU_SOURCE feature macro from
          syscalls/fanotify05.
	* Moved fanotify_get_fid() in fanotify.h outside #ifndef
	  FAN_REPORT_FID to accommodate for the situation where LTP is
	  built on a system that has newer (5.1 >) kernel headers
	  installed.

Thanks for your help Amir and Jan.

Matthew Bobrowski (3):
  syscalls/fanotify13: new test to verify FAN_REPORT_FID functionality
  syscalls/fanotify14: new test to validate FAN_REPORT_FID interface
    return values
  syscalls/fanotify15: verify fid for dirent events

 configure.ac                                  |   1 +
 runtest/syscalls                              |   3 +
 testcases/kernel/syscalls/fanotify/.gitignore |   3 +
 testcases/kernel/syscalls/fanotify/fanotify.h |  81 ++++-
 .../kernel/syscalls/fanotify/fanotify05.c     |   1 +
 .../kernel/syscalls/fanotify/fanotify13.c     | 313 ++++++++++++++++++
 .../kernel/syscalls/fanotify/fanotify14.c     | 171 ++++++++++
 .../kernel/syscalls/fanotify/fanotify15.c     | 245 ++++++++++++++
 8 files changed, 815 insertions(+), 3 deletions(-)
 create mode 100644 testcases/kernel/syscalls/fanotify/fanotify13.c
 create mode 100644 testcases/kernel/syscalls/fanotify/fanotify14.c
 create mode 100644 testcases/kernel/syscalls/fanotify/fanotify15.c

-- 
2.21.0


-- 
Matthew Bobrowski
