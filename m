From: Xie Ziyao <xieziyao@huawei.com>
Date: Wed, 16 Jun 2021 17:36:03 +0800
Subject: [LTP] [PATCH 0/3] Cleanup and bugfix for getrusage{01, 03}
Message-ID: <20210616093606.214856-1-xieziyao@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

1. Add tst_process_release_wait() which returns a value indicating if
the process is released with checking whether "/proc/%i" exists.
2. Cleanup and bugfix for getrusage{01, 03}.

Xie Ziyao (3):
  lib: tst_process_state: Add tst_process_release_wait()
  syscalls/getrusage: Cleanup and bugfix for getrusage03
  syscalls/getrusage: Convert getrusage01 to the new API

 include/tst_process_state.h                   |  41 +-
 lib/tst_process_state.c                       |  52 +--
 .../kernel/syscalls/getrusage/getrusage01.c   | 132 ++----
 .../kernel/syscalls/getrusage/getrusage03.c   | 385 +++++-------------
 .../kernel/syscalls/getrusage/getrusage03.h   |  35 ++
 .../syscalls/getrusage/getrusage03_child.c    | 187 ++-------
 6 files changed, 257 insertions(+), 575 deletions(-)
 create mode 100644 testcases/kernel/syscalls/getrusage/getrusage03.h

--
2.17.1

