From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Fri, 20 Mar 2020 09:54:00 +0530
Subject: [LTP] [PATCH V3 0/2] syscalls/clone3: New tests
Message-ID: <cover.1584677993.git.viresh.kumar@linaro.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello,

Here is the second attempt at adding clone3() related tests.

--
viresh

V2->V3:
- Rename check_syscall_support() and make it a routine.
- Don't print messages from signal handlers.
- Don't allocate structures at runtime unnecessarily.
- Initialize invalid_args to an invalid address instead of NULL.

V1->V2:
- Relocated pidfd_send_signal.h, as clone3() needs to use the syscall.
- clone301.c is now sending and verifying signals between parent/child
  processes.
- More failure tests to validate remaining fields.

Viresh Kumar (2):
  syscalls/pidfd_send_signal: Move pidfd_send_signal.h to include/lapi/
  syscalls/clone3: New tests

 configure.ac                                  |   1 +
 include/lapi/clone.h                          |  49 ++++++
 .../lapi}/pidfd_send_signal.h                 |   3 +-
 runtest/syscalls                              |   3 +
 testcases/kernel/syscalls/clone3/.gitignore   |   2 +
 testcases/kernel/syscalls/clone3/Makefile     |   7 +
 testcases/kernel/syscalls/clone3/clone301.c   | 150 ++++++++++++++++++
 testcases/kernel/syscalls/clone3/clone302.c   | 102 ++++++++++++
 .../pidfd_send_signal/pidfd_send_signal01.c   |   4 +-
 .../pidfd_send_signal/pidfd_send_signal02.c   |   4 +-
 .../pidfd_send_signal/pidfd_send_signal03.c   |   4 +-
 11 files changed, 321 insertions(+), 8 deletions(-)
 create mode 100644 include/lapi/clone.h
 rename {testcases/kernel/syscalls/pidfd_send_signal => include/lapi}/pidfd_send_signal.h (85%)
 create mode 100644 testcases/kernel/syscalls/clone3/.gitignore
 create mode 100644 testcases/kernel/syscalls/clone3/Makefile
 create mode 100644 testcases/kernel/syscalls/clone3/clone301.c
 create mode 100644 testcases/kernel/syscalls/clone3/clone302.c

-- 
2.21.0.rc0.269.g1a574e7a288b

