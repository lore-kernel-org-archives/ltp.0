From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 17 Feb 2020 09:46:18 +0100
Subject: [LTP] [PATCH v7 0/4] Add test for new mount API v5.2
Message-ID: <20200217084622.11199-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

hopefully the final version we can merge (so we can continue with Viresh
Kumar tests).

Checked with travis [2].

Changes v6->v7
* replaced Zorro's lapi/fsmount.h with Viresh's (1st commit from [1]),
added autotools checks for his commit.
* add lapi/fcntl.h to fix AT_FDCWD

Kind regards,
Petr

[1] https://patchwork.ozlabs.org/patch/1237986/
[2] https://travis-ci.org/pevik/ltp/builds/651376895

Petr Vorel (2):
  tst_umount: Fail immediately when errno != EBUSY
  safe_macros: Use tst_umount() in safe_umount()

Viresh Kumar (1):
  lapi/fsmount: Add definitions for fsmount related syscalls

Zorro Lang (1):
  syscalls/fsmount01: Add test for fsmount series API

 configure.ac                                  |   8 +-
 include/lapi/fsmount.h                        | 134 ++++++++++++++++++
 include/lapi/syscalls/powerpc64.in            |   4 +
 lib/safe_macros.c                             |   2 +-
 lib/tst_device.c                              |   9 +-
 runtest/syscalls                              |   2 +
 testcases/kernel/syscalls/fsmount/.gitignore  |   1 +
 testcases/kernel/syscalls/fsmount/Makefile    |   8 ++
 testcases/kernel/syscalls/fsmount/fsmount01.c |  95 +++++++++++++
 9 files changed, 260 insertions(+), 3 deletions(-)
 create mode 100644 include/lapi/fsmount.h
 create mode 100644 testcases/kernel/syscalls/fsmount/.gitignore
 create mode 100644 testcases/kernel/syscalls/fsmount/Makefile
 create mode 100644 testcases/kernel/syscalls/fsmount/fsmount01.c

-- 
2.25.0

