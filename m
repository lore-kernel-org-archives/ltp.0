From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Thu, 19 Mar 2020 17:28:37 +0530
Subject: [LTP] [PATCH V2 0/2] syscalls/clone3: New tests
Message-ID: <cover.1584618969.git.viresh.kumar@linaro.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello,

Here is the second attempt at adding clone3() related tests.

--
viresh

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
 .../lapi}/pidfd_send_signal.h                 |   8 +-
 runtest/syscalls                              |   3 +
 testcases/kernel/syscalls/clone3/.gitignore   |   2 +
 testcases/kernel/syscalls/clone3/Makefile     |   7 +
 testcases/kernel/syscalls/clone3/clone301.c   | 152 ++++++++++++++++++
 testcases/kernel/syscalls/clone3/clone302.c   | 101 ++++++++++++
 .../pidfd_send_signal/pidfd_send_signal01.c   |   2 +-
 .../pidfd_send_signal/pidfd_send_signal02.c   |   2 +-
 .../pidfd_send_signal/pidfd_send_signal03.c   |   2 +-
 11 files changed, 320 insertions(+), 9 deletions(-)
 create mode 100644 include/lapi/clone.h
 rename {testcases/kernel/syscalls/pidfd_send_signal => include/lapi}/pidfd_send_signal.h (73%)
 create mode 100644 testcases/kernel/syscalls/clone3/.gitignore
 create mode 100644 testcases/kernel/syscalls/clone3/Makefile
 create mode 100644 testcases/kernel/syscalls/clone3/clone301.c
 create mode 100644 testcases/kernel/syscalls/clone3/clone302.c

-- 
2.21.0.rc0.269.g1a574e7a288b

