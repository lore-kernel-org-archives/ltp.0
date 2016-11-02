From: Dejan Jovicevic <dejan.jovicevic@rt-rk.com>
Date: Wed,  2 Nov 2016 11:59:46 +0100
Subject: [LTP] [PATCH v3 0/5] Listxattr related calls: new tests and testcase
Message-ID: <1478084391-30192-1-git-send-email-dejan.jovicevic@rt-rk.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

v2 -> v3:
    - Removed unnecessary null-termination for longpathname in 
    llistxattr02 new testcase.
    - Modified the code to be more readable and maintainable,
    this resulted in creating a new patch that pretty much does
    the same thing for llistxattr() tests.
    - Started usign corresponding safe macros in the setup of all
    of the listxattr related tests. This resulted in a new patch
    that implements these safe macros.

v1 -> v2:
    - Modified the setup for the new testcase in llistxattr02 and 
    a testcase in listxattr02.
    - Modified commit messages.

This series introduces new testcase for llistxattr02 and tests for
flistxattr() and listxattr(). Safe macros are added for functions
that set extended attribute values, and are being used in appropriate
tests. The code in tests for llistxattr() was slightly modified to be
more readable and easier to maintain, this practice was followed in
creating new tests for flistxattr() and listxattr().

Dejan Jovicevic (5):
  safe_macros: add safe_setxattr(), safe_lsetxattr() and     
    safe_fsetxattr()
  llistxattr: moved to using safe macros
  llistxattr: improved code readability and stability
  llistxattr: new testcase for long path name
  flistxattr and listxattr: added tests

 include/tst_safe_macros.h                          |  12 +++
 lib/safe_macros.c                                  |  66 +++++++++++++
 runtest/syscalls                                   |   8 ++
 testcases/kernel/syscalls/.gitignore               |   6 ++
 testcases/kernel/syscalls/flistxattr/Makefile      |  23 +++++
 .../kernel/syscalls/flistxattr/flistxattr01.c      | 102 ++++++++++++++++++++
 .../kernel/syscalls/flistxattr/flistxattr02.c      | 104 ++++++++++++++++++++
 .../kernel/syscalls/flistxattr/flistxattr03.c      |  97 +++++++++++++++++++
 testcases/kernel/syscalls/listxattr/Makefile       |  23 +++++
 testcases/kernel/syscalls/listxattr/listxattr01.c  |  94 ++++++++++++++++++
 testcases/kernel/syscalls/listxattr/listxattr02.c  | 105 +++++++++++++++++++++
 testcases/kernel/syscalls/listxattr/listxattr03.c  |  89 +++++++++++++++++
 .../kernel/syscalls/llistxattr/llistxattr01.c      |  46 +++------
 .../kernel/syscalls/llistxattr/llistxattr02.c      |  53 +++++------
 .../kernel/syscalls/llistxattr/llistxattr03.c      |  24 ++---
 15 files changed, 773 insertions(+), 79 deletions(-)
 create mode 100644 testcases/kernel/syscalls/flistxattr/Makefile
 create mode 100644 testcases/kernel/syscalls/flistxattr/flistxattr01.c
 create mode 100644 testcases/kernel/syscalls/flistxattr/flistxattr02.c
 create mode 100644 testcases/kernel/syscalls/flistxattr/flistxattr03.c
 create mode 100644 testcases/kernel/syscalls/listxattr/Makefile
 create mode 100644 testcases/kernel/syscalls/listxattr/listxattr01.c
 create mode 100644 testcases/kernel/syscalls/listxattr/listxattr02.c
 create mode 100644 testcases/kernel/syscalls/listxattr/listxattr03.c

-- 
1.9.1

