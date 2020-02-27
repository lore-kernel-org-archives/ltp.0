From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Thu, 27 Feb 2020 10:44:28 +0530
Subject: [LTP] [PATCH V5 00/10] Add new LTP tests related to fsmount family
 of syscalls
Message-ID: <cover.1582779464.git.viresh.kumar@linaro.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello,

Here is the fifth version of my work rebased over the latest changes pushed
around fsmount work by Zorro. This is tested on both ARM and X86 platforms now
and no more errors are seen with it.

V4->V5:
- s/TBROK/TFAIL/ in run(int n) callbacks.
- Many conversions like TEST(fd = fsopen());
- A new implementation of tst_is_mounted().
- fspick.h created to take care of duplicate code.
- tmp directory not removed from code as that will be auto done anyway.
- Other minor improvements.

V3->V4:
- Only the first patch was resent after fixing git log and minor code
  modifications.

V2->V3:
- Fix errors with xfs.
- Add macros to define test names.
- Continue with multiple iteration tests on failures, instead of
  returning early.
- Set value of is_mounted in open_tree patch.
- Rename tst_ismount() and make it return 1 on success.
- Fix various formatting issues.
- Add all reviewed/ack tags.

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
  tst_device: Add tst_is_mounted() helper
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
 lib/tst_device.c                              |  14 ++
 runtest/syscalls                              |  16 +++
 testcases/kernel/syscalls/fsconfig/.gitignore |   2 +
 testcases/kernel/syscalls/fsconfig/Makefile   |   6 +
 .../kernel/syscalls/fsconfig/fsconfig01.c     | 101 ++++++++++++++
 .../kernel/syscalls/fsconfig/fsconfig02.c     |  99 ++++++++++++++
 testcases/kernel/syscalls/fsmount/.gitignore  |   1 +
 testcases/kernel/syscalls/fsmount/fsmount01.c | 123 +++++++++---------
 testcases/kernel/syscalls/fsmount/fsmount02.c |  80 ++++++++++++
 testcases/kernel/syscalls/fsopen/.gitignore   |   2 +
 testcases/kernel/syscalls/fsopen/Makefile     |   6 +
 testcases/kernel/syscalls/fsopen/fsopen01.c   |  80 ++++++++++++
 testcases/kernel/syscalls/fsopen/fsopen02.c   |  58 +++++++++
 testcases/kernel/syscalls/fspick/.gitignore   |   2 +
 testcases/kernel/syscalls/fspick/Makefile     |   6 +
 testcases/kernel/syscalls/fspick/fspick.h     |  60 +++++++++
 testcases/kernel/syscalls/fspick/fspick01.c   |  62 +++++++++
 testcases/kernel/syscalls/fspick/fspick02.c   |  54 ++++++++
 .../kernel/syscalls/move_mount/.gitignore     |   2 +
 testcases/kernel/syscalls/move_mount/Makefile |   6 +
 .../kernel/syscalls/move_mount/move_mount01.c |  83 ++++++++++++
 .../kernel/syscalls/move_mount/move_mount02.c |  92 +++++++++++++
 .../kernel/syscalls/open_tree/.gitignore      |   2 +
 testcases/kernel/syscalls/open_tree/Makefile  |   6 +
 .../kernel/syscalls/open_tree/open_tree01.c   | 108 +++++++++++++++
 .../kernel/syscalls/open_tree/open_tree02.c   | 105 +++++++++++++++
 28 files changed, 1132 insertions(+), 61 deletions(-)
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
 create mode 100644 testcases/kernel/syscalls/fspick/fspick.h
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

