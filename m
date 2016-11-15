From: Dejan Jovicevic <dejan.jovicevic@rt-rk.com>
Date: Tue, 15 Nov 2016 13:19:32 +0100
Subject: [LTP] [PATCH v5 0/5] listxattr related calls: new tests and test
	case
Message-ID: <1479212377-12830-1-git-send-email-dejan.jovicevic@rt-rk.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

v4 -> v5:
    - Minor changes in llistxattr02.c that were missing in previous version.

v3 -> v4:
    - Fixed code errors from previous series. Fixed merge conflict. Added the
    safe_*setxattr() function prototypes in tst_safe_macros.h. Changed the 
    licence for the new tests to GPLv2+.

v2 -> v3:
    - Removed the unnecessary string termination after the memset() call in
    llistxattr02 and listxattr02.
    - Modified the code to be more readable and maintainable,
    this resulted in creating a new patch that pretty much does
    the same thing for llistxattr() tests.
    - Started usign corresponding safe macros in the setup of all
    of the listxattr related tests. This resulted in a new patch
    that implements these safe macros.

v1 -> v2:
    - Modified the setup for the new test case in llistxattr02 and 
    a testcase in listxattr02.
    - Modified commit messages.

In this series, there is a new test case added in the existing llistxattr02
test. Also, we are moving to safe macros for *setxattr() syscalls.
New tests are added for system calls flistxattr(), and listxattr()
which are based on the existing tests for llistxattr.

Dejan Jovicevic (5):
  safe_macros: add safe_setxattr(), safe_lsetxattr() and
    safe_fsetxattr()
  llistxattr: moved to using safe macros
  llistxattr: improved code readability and stability
  llistxattr: new testcase for long path name
  flistxattr and listxattr: added tests

 include/tst_safe_macros.h                          |  15 +++
 lib/safe_macros.c                                  |  64 ++++++++++++
 runtest/syscalls                                   |   8 ++
 testcases/kernel/syscalls/.gitignore               |   6 ++
 testcases/kernel/syscalls/flistxattr/Makefile      |  23 +++++
 .../kernel/syscalls/flistxattr/flistxattr01.c      | 104 ++++++++++++++++++++
 .../kernel/syscalls/flistxattr/flistxattr02.c      | 104 ++++++++++++++++++++
 .../kernel/syscalls/flistxattr/flistxattr03.c      |  99 +++++++++++++++++++
 testcases/kernel/syscalls/listxattr/Makefile       |  23 +++++
 testcases/kernel/syscalls/listxattr/listxattr01.c  |  96 ++++++++++++++++++
 testcases/kernel/syscalls/listxattr/listxattr02.c  | 107 +++++++++++++++++++++
 testcases/kernel/syscalls/listxattr/listxattr03.c  |  91 ++++++++++++++++++
 .../kernel/syscalls/llistxattr/llistxattr01.c      |  49 +++-------
 .../kernel/syscalls/llistxattr/llistxattr02.c      |  57 ++++++-----
 .../kernel/syscalls/llistxattr/llistxattr03.c      |  24 ++---
 15 files changed, 788 insertions(+), 82 deletions(-)
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

