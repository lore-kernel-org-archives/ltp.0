From: Xie Ziyao <xieziyao@huawei.com>
Date: Fri, 7 May 2021 16:33:18 +0800
Subject: [LTP] [PATCH 0/3] syscalls/aio: Add testcases for native AIO
Message-ID: <20210507083321.167998-1-xieziyao@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Test io_destroy, io_setup, io_submit invoked via syscall(2).

Xie Ziyao (3):
  syscalls/io_destroy: Add io_destroy02 test for native AIO
  syscalls/io_setup: Add io_setup02 test for native AIO
  syscalls/io_submit: Add io_submit02 test for native AIO

 runtest/syscalls                              |   3 +
 .../kernel/syscalls/io_destroy/.gitignore     |   1 +
 .../kernel/syscalls/io_destroy/io_destroy02.c |  32 +++++
 testcases/kernel/syscalls/io_setup/.gitignore |   1 +
 .../kernel/syscalls/io_setup/io_setup02.c     |  52 ++++++++
 .../kernel/syscalls/io_submit/.gitignore      |   1 +
 .../kernel/syscalls/io_submit/io_submit02.c   | 119 ++++++++++++++++++
 7 files changed, 209 insertions(+)
 create mode 100644 testcases/kernel/syscalls/io_destroy/io_destroy02.c
 create mode 100644 testcases/kernel/syscalls/io_setup/io_setup02.c
 create mode 100644 testcases/kernel/syscalls/io_submit/io_submit02.c

--
2.17.1

