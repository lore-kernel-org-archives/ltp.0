From: Dejan Jovicevic <dejan.jovicevic@rt-rk.com>
Date: Mon, 10 Oct 2016 17:39:59 +0200
Subject: [LTP] [PATCH v2 0/2] Listxattr related calls: new tests and testcase
Message-ID: <1476114001-24856-1-git-send-email-dejan.jovicevic@rt-rk.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

v1 -> v2:
    - Modified the setup for the new testcase in llistxattr02 and 
    a testcase in listxattr02.
    - Modified commit messages.

In this series, there is a new testcase added in the existing llistxattr02
test. Also, new tests are added for system calls flistxattr(), and listxattr()
which are based on the existing tests for llistxattr.

Dejan Jovicevic (2):
  llistxattr: added a new test case to llistxattr02
  flistxattr and listxattr: added tests

 runtest/syscalls                                   |   8 ++
 testcases/kernel/syscalls/.gitignore               |   6 +
 testcases/kernel/syscalls/flistxattr/Makefile      |  23 ++++
 .../kernel/syscalls/flistxattr/flistxattr01.c      | 124 +++++++++++++++++++++
 .../kernel/syscalls/flistxattr/flistxattr02.c      | 116 +++++++++++++++++++
 .../kernel/syscalls/flistxattr/flistxattr03.c      | 111 ++++++++++++++++++
 testcases/kernel/syscalls/listxattr/Makefile       |  23 ++++
 testcases/kernel/syscalls/listxattr/listxattr01.c  | 115 +++++++++++++++++++
 testcases/kernel/syscalls/listxattr/listxattr02.c  | 119 ++++++++++++++++++++
 testcases/kernel/syscalls/listxattr/listxattr03.c  | 101 +++++++++++++++++
 .../kernel/syscalls/llistxattr/llistxattr02.c      |  11 +-
 11 files changed, 756 insertions(+), 1 deletion(-)
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

