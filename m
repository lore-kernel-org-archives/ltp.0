From: Xie Ziyao <xieziyao@huawei.com>
Date: Fri, 18 Jun 2021 17:42:03 +0800
Subject: [LTP] [PATCH 0/7] syscalls/aio: Add tests for libaio and docparse
 formatting
Message-ID: <20210618094210.183027-1-xieziyao@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Xie Ziyao (7):
  io_cancel02: Add io_cancel02 test for libaio
  io_cancel01: Add .needs_kconfigs and more detailed description
  io_destroy01: Add docparse formatting and more detailed description
  io_getevents01: Add .needs_kconfigs and more detailed description
  io_getevents02: Add io_getevents02 test for libaio
  io_setup: Add docparse formatting and more detailed description
  io_submit01: Add docparse formatting and more detailed description

 runtest/syscalls                              |  2 +
 .../kernel/syscalls/io_cancel/.gitignore      |  1 +
 .../kernel/syscalls/io_cancel/io_cancel01.c   |  9 +++-
 .../kernel/syscalls/io_cancel/io_cancel02.c   | 51 +++++++++++++++++++
 .../kernel/syscalls/io_destroy/io_destroy01.c | 15 +++---
 .../kernel/syscalls/io_getevents/.gitignore   |  1 +
 .../syscalls/io_getevents/io_getevents01.c    |  8 ++-
 .../syscalls/io_getevents/io_getevents02.c    | 51 +++++++++++++++++++
 .../kernel/syscalls/io_setup/io_setup01.c     | 24 +++++----
 .../kernel/syscalls/io_setup/io_setup02.c     |  8 +--
 .../kernel/syscalls/io_submit/io_submit01.c   | 15 +++++-
 11 files changed, 158 insertions(+), 27 deletions(-)
 create mode 100644 testcases/kernel/syscalls/io_cancel/io_cancel02.c
 create mode 100644 testcases/kernel/syscalls/io_getevents/io_getevents02.c

--
2.17.1

