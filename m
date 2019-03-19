From: Sumit Garg <sumit.garg@linaro.org>
Date: Tue, 19 Mar 2019 12:19:38 +0530
Subject: [LTP] [PATCH v3 0/3] syscalls: add tgkill test-cases
Message-ID: <1552978181-27748-1-git-send-email-sumit.garg@linaro.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This patch-set is inherited from Greg which adds test-cases for tgkill
syscall.

Changes in v3:
- Use checkpoint library to keep threads asleep while waiting for
  signals.
- Start threads during test setup() rather than test run().

Changes in v2:
- Free allocated memory for threads.
- Remove redundant call to stop_threads().
- Apply reviewed-by tag.

Greg Hackmann (3):
  syscalls/tgkill01: add new test
  syscalls/tgkill02: add new test
  syscalls/tgkill03: add new test

 runtest/syscalls                            |   4 +
 testcases/kernel/syscalls/tgkill/.gitignore |   3 +
 testcases/kernel/syscalls/tgkill/Makefile   |  10 +++
 testcases/kernel/syscalls/tgkill/tgkill.h   |  22 +++++
 testcases/kernel/syscalls/tgkill/tgkill01.c | 134 ++++++++++++++++++++++++++++
 testcases/kernel/syscalls/tgkill/tgkill02.c |  68 ++++++++++++++
 testcases/kernel/syscalls/tgkill/tgkill03.c | 110 +++++++++++++++++++++++
 7 files changed, 351 insertions(+)
 create mode 100644 testcases/kernel/syscalls/tgkill/.gitignore
 create mode 100644 testcases/kernel/syscalls/tgkill/Makefile
 create mode 100644 testcases/kernel/syscalls/tgkill/tgkill.h
 create mode 100644 testcases/kernel/syscalls/tgkill/tgkill01.c
 create mode 100644 testcases/kernel/syscalls/tgkill/tgkill02.c
 create mode 100644 testcases/kernel/syscalls/tgkill/tgkill03.c

-- 
2.7.4

