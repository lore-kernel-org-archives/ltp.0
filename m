From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 28 Feb 2019 16:34:23 +0100
Subject: [LTP] [PATCH 0/2 v4] Add mbind and set_mempolicy tests
Message-ID: <20190228153425.10286-1-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Changes from v3 for the set_mempolicy patch follows comments from Jan,
the allocation stays in the library but was made generic enough to
support mbind tests.

The mbind tests are not 100% ready to be merged, but are included to
show that the API is flexible enough now.

Cyril Hrubis (2):
  syscalls: Add set_mempolicy numa tests.
  syscalls/mbind0{2,3,4}: Add basic mbind tests

 include/tst_numa.h                            | 112 ++++++++++
 lib/tst_numa.c                                | 208 ++++++++++++++++++
 runtest/numa                                  |   5 +
 runtest/syscalls                              |   3 +
 testcases/kernel/syscalls/mbind/.gitignore    |   3 +
 testcases/kernel/syscalls/mbind/mbind.h       |  26 +++
 testcases/kernel/syscalls/mbind/mbind02.c     |  99 +++++++++
 testcases/kernel/syscalls/mbind/mbind03.c     | 123 +++++++++++
 testcases/kernel/syscalls/mbind/mbind04.c     | 127 +++++++++++
 .../kernel/syscalls/set_mempolicy/.gitignore  |   4 +
 .../kernel/syscalls/set_mempolicy/Makefile    |   7 +
 .../syscalls/set_mempolicy/set_mempolicy.h    |  21 ++
 .../syscalls/set_mempolicy/set_mempolicy01.c  | 120 ++++++++++
 .../syscalls/set_mempolicy/set_mempolicy02.c  | 117 ++++++++++
 .../syscalls/set_mempolicy/set_mempolicy03.c  | 113 ++++++++++
 .../syscalls/set_mempolicy/set_mempolicy04.c  | 142 ++++++++++++
 16 files changed, 1230 insertions(+)
 create mode 100644 include/tst_numa.h
 create mode 100644 lib/tst_numa.c
 create mode 100644 testcases/kernel/syscalls/mbind/mbind.h
 create mode 100644 testcases/kernel/syscalls/mbind/mbind02.c
 create mode 100644 testcases/kernel/syscalls/mbind/mbind03.c
 create mode 100644 testcases/kernel/syscalls/mbind/mbind04.c
 create mode 100644 testcases/kernel/syscalls/set_mempolicy/.gitignore
 create mode 100644 testcases/kernel/syscalls/set_mempolicy/Makefile
 create mode 100644 testcases/kernel/syscalls/set_mempolicy/set_mempolicy.h
 create mode 100644 testcases/kernel/syscalls/set_mempolicy/set_mempolicy01.c
 create mode 100644 testcases/kernel/syscalls/set_mempolicy/set_mempolicy02.c
 create mode 100644 testcases/kernel/syscalls/set_mempolicy/set_mempolicy03.c
 create mode 100644 testcases/kernel/syscalls/set_mempolicy/set_mempolicy04.c

-- 
2.19.2

