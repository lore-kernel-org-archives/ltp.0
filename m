From: Li Wang <liwang@redhat.com>
Date: Fri, 21 Jun 2019 18:26:25 +0800
Subject: [LTP] [PATCH v2 0/3] Test for Memory Protection Key
Message-ID: <20190621102628.4800-1-liwang@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Change log: 
    v1 --> v2
    * correct syscall numbers in aarch64.in
    * handle ENOSPC error in check_pkey_support
    * avoid getting cores from pkey01 children
    * add pkey02 to test with more different memory

Li Wang (3):
  pkey: add syscall numbers for pkey
  pkey: add test for memory protection keys
  pkey: add pkey02 test

 configure.ac                               |   1 +
 include/lapi/syscalls/aarch64.in           |   3 +
 include/lapi/syscalls/arm.in               |   3 +
 include/lapi/syscalls/i386.in              |   3 +
 include/lapi/syscalls/ia64.in              |   3 +
 include/lapi/syscalls/powerpc.in           |   3 +
 include/lapi/syscalls/powerpc64.in         |   3 +
 include/lapi/syscalls/s390.in              |   3 +
 include/lapi/syscalls/s390x.in             |   3 +
 include/lapi/syscalls/sparc.in             |   3 +
 include/lapi/syscalls/sparc64.in           |   3 +
 include/lapi/syscalls/x86_64.in            |   3 +
 runtest/syscalls                           |   3 +
 testcases/kernel/syscalls/pkeys/.gitignore |   2 +
 testcases/kernel/syscalls/pkeys/Makefile   |   8 ++
 testcases/kernel/syscalls/pkeys/pkey.h     |  50 ++++++++
 testcases/kernel/syscalls/pkeys/pkey01.c   | 126 +++++++++++++++++++
 testcases/kernel/syscalls/pkeys/pkey02.c   | 134 +++++++++++++++++++++
 18 files changed, 357 insertions(+)
 create mode 100644 testcases/kernel/syscalls/pkeys/.gitignore
 create mode 100644 testcases/kernel/syscalls/pkeys/Makefile
 create mode 100644 testcases/kernel/syscalls/pkeys/pkey.h
 create mode 100644 testcases/kernel/syscalls/pkeys/pkey01.c
 create mode 100644 testcases/kernel/syscalls/pkeys/pkey02.c

-- 
2.20.1

