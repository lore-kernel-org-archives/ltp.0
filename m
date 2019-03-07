From: Sumit Garg <sumit.garg@linaro.org>
Date: Thu,  7 Mar 2019 12:58:45 +0530
Subject: [LTP] [PATCH 0/3] syscalls: add tgkill test-cases
Message-ID: <1551943728-16222-1-git-send-email-sumit.garg@linaro.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This patch-set is inherited from Greg which adds test-cases for tgkill
syscall.

Greg Hackmann (3):
  syscalls/tgkill01: add new test
  syscalls/tgkill02: add new test
  syscalls/tgkill03: add new test

 runtest/syscalls                            |   4 +
 testcases/kernel/syscalls/tgkill/.gitignore |   3 +
 testcases/kernel/syscalls/tgkill/Makefile   |  10 ++
 testcases/kernel/syscalls/tgkill/tgkill.h   |  22 +++++
 testcases/kernel/syscalls/tgkill/tgkill01.c | 138 ++++++++++++++++++++++++++++
 testcases/kernel/syscalls/tgkill/tgkill02.c |  80 ++++++++++++++++
 testcases/kernel/syscalls/tgkill/tgkill03.c | 122 ++++++++++++++++++++++++
 7 files changed, 379 insertions(+)
 create mode 100644 testcases/kernel/syscalls/tgkill/.gitignore
 create mode 100644 testcases/kernel/syscalls/tgkill/Makefile
 create mode 100644 testcases/kernel/syscalls/tgkill/tgkill.h
 create mode 100644 testcases/kernel/syscalls/tgkill/tgkill01.c
 create mode 100644 testcases/kernel/syscalls/tgkill/tgkill02.c
 create mode 100644 testcases/kernel/syscalls/tgkill/tgkill03.c

-- 
2.7.4

