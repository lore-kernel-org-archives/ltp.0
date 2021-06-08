From: Xie Ziyao <xieziyao@huawei.com>
Date: Tue, 8 Jun 2021 21:57:14 +0800
Subject: [LTP] [PATCH 0/4 v2] syscalls/aio: Add testcases for native AIO
Message-ID: <20210608135718.36579-1-xieziyao@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

1. Split io_submit02 into two, one for negative and one for positive cases.
2. Add .needs_kconfig in this test.
3. Print values not variable names in TST_EXP_PASS/FAIL().

Xie Ziyao (4):
  syscalls/io_destroy: Add io_destroy02 test for native AIO
  syscalls/io_setup: Add io_setup02 test for native AIO
  syscalls/io_submit: Add io_submit02 test for native AIO
  syscalls/io_submit: Add io_submit03 test for native AIO

 runtest/syscalls                              |   4 +
 .../kernel/syscalls/io_destroy/.gitignore     |   1 +
 .../kernel/syscalls/io_destroy/io_destroy02.c |  38 ++++++
 testcases/kernel/syscalls/io_setup/.gitignore |   1 +
 .../kernel/syscalls/io_setup/io_setup02.c     |  64 ++++++++++
 .../kernel/syscalls/io_submit/.gitignore      |   2 +
 .../kernel/syscalls/io_submit/io_submit02.c   |  89 +++++++++++++
 .../kernel/syscalls/io_submit/io_submit03.c   | 118 ++++++++++++++++++
 8 files changed, 317 insertions(+)
 create mode 100644 testcases/kernel/syscalls/io_destroy/io_destroy02.c
 create mode 100644 testcases/kernel/syscalls/io_setup/io_setup02.c
 create mode 100644 testcases/kernel/syscalls/io_submit/io_submit02.c
 create mode 100644 testcases/kernel/syscalls/io_submit/io_submit03.c

--
2.17.1

