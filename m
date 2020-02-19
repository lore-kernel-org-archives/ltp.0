From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Wed, 19 Feb 2020 14:57:56 +0530
Subject: [LTP] [PATCH V2 00/10] Add new LTP tests related to fsmount family
 of syscalls
Message-ID: <cover.1582104018.git.viresh.kumar@linaro.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello,

Here is the second version of my work rebased over the latest changes
pushed around fsmount work by Zorro.

V1->V2:
- Lots of changes, really :)
- Rebased over Zorro's work with fsmount.
- The success tests are modified to test all possible flags, attributes
  as well.
- Create tst_ismount() and fsopen_supported_by_kernel() helpers.
- Verify if mount is successful or not using tst_ismount().
- Remove min_kver and instead check if older kernels have patches
  backported or not.
- Test on multiple filesystems.
- Better handling of failures during setup/run callbacks.
- One of the patches around fsmount.h is already merged, dropped it now.
- Other minor cleanups.

Viresh Kumar (10):
  tst_device: Add tst_ismount() helper
  lapi/fsmount.h: Add fsopen_supported_by_kernel()
  lapi/fsmount.h: Include "lapi/fcntl.h"
  syscalls/fsopen: New tests
  syscalls/fsconfig: New tests
  syscalls/fsmount: Improve fsmount01 test
  syscalls/fsmount: Add failure tests
  syscalls/move_mount: New tests
  syscalls/fspick: New tests
  syscalls/open_tree: New tests

 include/lapi/fsmount.h                        |  11 +-
 include/tst_device.h                          |   6 +
 lib/tst_device.c                              |  25 ++++
 runtest/syscalls                              |  16 +++
 testcases/kernel/syscalls/fsconfig/.gitignore |   2 +
 testcases/kernel/syscalls/fsconfig/Makefile   |   6 +
 .../kernel/syscalls/fsconfig/fsconfig01.c     | 110 +++++++++++++++++
 .../kernel/syscalls/fsconfig/fsconfig02.c     | 100 +++++++++++++++
 testcases/kernel/syscalls/fsmount/.gitignore  |   1 +
 testcases/kernel/syscalls/fsmount/fsmount01.c | 114 ++++++++---------
 testcases/kernel/syscalls/fsmount/fsmount02.c |  81 ++++++++++++
 testcases/kernel/syscalls/fsopen/.gitignore   |   2 +
 testcases/kernel/syscalls/fsopen/Makefile     |   6 +
 testcases/kernel/syscalls/fsopen/fsopen01.c   |  85 +++++++++++++
 testcases/kernel/syscalls/fsopen/fsopen02.c   |  57 +++++++++
 testcases/kernel/syscalls/fspick/.gitignore   |   2 +
 testcases/kernel/syscalls/fspick/Makefile     |   6 +
 testcases/kernel/syscalls/fspick/fspick01.c   | 112 +++++++++++++++++
 testcases/kernel/syscalls/fspick/fspick02.c   | 107 ++++++++++++++++
 .../kernel/syscalls/move_mount/.gitignore     |   2 +
 testcases/kernel/syscalls/move_mount/Makefile |   6 +
 .../kernel/syscalls/move_mount/move_mount01.c |  82 +++++++++++++
 .../kernel/syscalls/move_mount/move_mount02.c |  93 ++++++++++++++
 .../kernel/syscalls/open_tree/.gitignore      |   2 +
 testcases/kernel/syscalls/open_tree/Makefile  |   6 +
 .../kernel/syscalls/open_tree/open_tree01.c   | 115 ++++++++++++++++++
 .../kernel/syscalls/open_tree/open_tree02.c   | 104 ++++++++++++++++
 27 files changed, 1203 insertions(+), 56 deletions(-)
 create mode 100644 testcases/kernel/syscalls/fsconfig/.gitignore
 create mode 100644 testcases/kernel/syscalls/fsconfig/Makefile
 create mode 100644 testcases/kernel/syscalls/fsconfig/fsconfig01.c
 create mode 100644 testcases/kernel/syscalls/fsconfig/fsconfig02.c
 create mode 100644 testcases/kernel/syscalls/fsmount/fsmount02.c
 create mode 100644 testcases/kernel/syscalls/fsopen/.gitignore
 create mode 100644 testcases/kernel/syscalls/fsopen/Makefile
 create mode 100644 testcases/kernel/syscalls/fsopen/fsopen01.c
 create mode 100644 testcases/kernel/syscalls/fsopen/fsopen02.c
 create mode 100644 testcases/kernel/syscalls/fspick/.gitignore
 create mode 100644 testcases/kernel/syscalls/fspick/Makefile
 create mode 100644 testcases/kernel/syscalls/fspick/fspick01.c
 create mode 100644 testcases/kernel/syscalls/fspick/fspick02.c
 create mode 100644 testcases/kernel/syscalls/move_mount/.gitignore
 create mode 100644 testcases/kernel/syscalls/move_mount/Makefile
 create mode 100644 testcases/kernel/syscalls/move_mount/move_mount01.c
 create mode 100644 testcases/kernel/syscalls/move_mount/move_mount02.c
 create mode 100644 testcases/kernel/syscalls/open_tree/.gitignore
 create mode 100644 testcases/kernel/syscalls/open_tree/Makefile
 create mode 100644 testcases/kernel/syscalls/open_tree/open_tree01.c
 create mode 100644 testcases/kernel/syscalls/open_tree/open_tree02.c

-- 
2.21.0.rc0.269.g1a574e7a288b

