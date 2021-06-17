From: Xie Ziyao <xieziyao@huawei.com>
Date: Thu, 17 Jun 2021 18:55:53 +0800
Subject: [LTP] [PATCH 0/3 v2] Cleanup and bugfix for getrusage03
Message-ID: <20210617105556.130869-1-xieziyao@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

1. Cleanup and add tst_process_exit_wait() for tst_process_state.
2. Cleanup and bugfix for getrusage03.

Xie Ziyao (3):
  lib: tst_process_state: Use SPDX and format alignment
  lib: tst_process_state: Add tst_process_exit_wait()
  getrusage: Cleanup and bugfix for getrusage03

 include/tst_process_state.h                   |  35 +-
 lib/tst_process_state.c                       |  52 +--
 .../kernel/syscalls/getrusage/getrusage03.c   | 398 +++++-------------
 .../kernel/syscalls/getrusage/getrusage03.h   |  33 ++
 .../syscalls/getrusage/getrusage03_child.c    | 196 +++------
 5 files changed, 242 insertions(+), 472 deletions(-)
 create mode 100644 testcases/kernel/syscalls/getrusage/getrusage03.h

--
2.17.1

