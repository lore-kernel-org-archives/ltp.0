From: Jakub Racek <jracek@redhat.com>
Date: Wed,  8 Mar 2017 18:44:10 +0100
Subject: [LTP] [PATCH v3 0/6] Added memfd_create() testsuite
Message-ID: <1488995056-7705-1-git-send-email-jracek@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

memfd_create() is a syscall that creates an anonymous file. This syscall was
originally introduced in "File Sealing & memfd_create()" patchset by
David Herrmann <dh.herrmann@gmail.com>.
My patchset is a partial port of memfd_create() testsuite to LTP, with lapi
extended as necessary. Code that runs _dup, _mmap and _open tests in 
multi-threaded environment was not ported yet.

V2: fixed LTP style problems, added syscall numbers for each arch
V3: fixed more style problems, moved fallocate.h to include/lapi

Jakub Racek (6):
  Added syscall numbers for memfd_create
  Added memfd_create() lapi flags
  Added fcntl() lapi flags
  move fallocate.h to lapi
  syscalls: added memfd_create dir and memfd_create/memfd_create01.c
  syscalls/memfd_create02.c: added new test

 include/lapi/fallocate.h                           |  66 +++++
 include/lapi/fcntl.h                               |  25 ++
 include/lapi/memfd.h                               |  27 ++
 runtest/syscalls                                   |   3 +
 testcases/kernel/include/aarch64.in                |   1 +
 testcases/kernel/include/arm.in                    |   1 +
 testcases/kernel/include/hppa.in                   |   1 +
 testcases/kernel/include/i386.in                   |   1 +
 testcases/kernel/include/ia64.in                   |   1 +
 testcases/kernel/include/powerpc.in                |   1 +
 testcases/kernel/include/powerpc64.in              |   1 +
 testcases/kernel/include/s390.in                   |   1 +
 testcases/kernel/include/s390x.in                  |   1 +
 testcases/kernel/include/sh.in                     |   1 +
 testcases/kernel/include/sparc.in                  |   1 +
 testcases/kernel/include/sparc64.in                |   1 +
 testcases/kernel/include/x86_64.in                 |   1 +
 testcases/kernel/syscalls/.gitignore               |   2 +
 testcases/kernel/syscalls/fallocate/fallocate.h    |  70 -----
 testcases/kernel/syscalls/fallocate/fallocate01.c  |   2 +-
 testcases/kernel/syscalls/fallocate/fallocate02.c  |   2 +-
 testcases/kernel/syscalls/fallocate/fallocate03.c  |   2 +-
 testcases/kernel/syscalls/fallocate/fallocate04.c  |   2 +-
 testcases/kernel/syscalls/memfd_create/Makefile    |  19 ++
 .../kernel/syscalls/memfd_create/memfd_create01.c  | 284 ++++++++++++++++++
 .../kernel/syscalls/memfd_create/memfd_create02.c  |  92 ++++++
 .../syscalls/memfd_create/memfd_create_common.h    | 323 +++++++++++++++++++++
 27 files changed, 858 insertions(+), 74 deletions(-)
 create mode 100644 include/lapi/fallocate.h
 create mode 100644 include/lapi/memfd.h
 delete mode 100644 testcases/kernel/syscalls/fallocate/fallocate.h
 create mode 100644 testcases/kernel/syscalls/memfd_create/Makefile
 create mode 100644 testcases/kernel/syscalls/memfd_create/memfd_create01.c
 create mode 100644 testcases/kernel/syscalls/memfd_create/memfd_create02.c
 create mode 100644 testcases/kernel/syscalls/memfd_create/memfd_create_common.h

-- 
1.8.3.1

