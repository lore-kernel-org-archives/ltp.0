From: Jakub Racek <jracek@redhat.com>
Date: Tue, 28 Feb 2017 12:59:53 +0100
Subject: [LTP] [PATCH 0/3] Added memfd_create() testsuite
Message-ID: <1488283196-11397-1-git-send-email-jracek@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

memfd_create() is a syscall that creates an anonymous file. This syscall was
originally introduced in "File Sealing & memfd_create()" patchset by
David Herrmann <dh.herrmann@gmail.com>.
My patchset is a port of memfd_create() testsuite to LTP, with lapi
extended as necessary.

Jakub Racek (3):
  Added memfd_create lapi flags
  Added fcntl() and fallocate() lapi flags
  Added port of memfd_create testsuite

 include/lapi/fcntl.h                               |  49 +++
 include/lapi/memfd_create.h                        |  30 ++
 runtest/syscalls                                   |   2 +
 testcases/kernel/syscalls/.gitignore               |   1 +
 testcases/kernel/syscalls/memfd_create/Makefile    |  23 +
 testcases/kernel/syscalls/memfd_create/fallocate.h |  43 ++
 .../kernel/syscalls/memfd_create/memfd_create01.c  | 465 +++++++++++++++++++++
 .../syscalls/memfd_create/memfd_create_common.h    | 424 +++++++++++++++++++
 8 files changed, 1037 insertions(+)
 create mode 100644 include/lapi/memfd_create.h
 create mode 100644 testcases/kernel/syscalls/memfd_create/Makefile
 create mode 100644 testcases/kernel/syscalls/memfd_create/fallocate.h
 create mode 100644 testcases/kernel/syscalls/memfd_create/memfd_create01.c
 create mode 100644 testcases/kernel/syscalls/memfd_create/memfd_create_common.h

-- 
1.8.3.1

