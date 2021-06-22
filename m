From: Xie Ziyao <xieziyao@huawei.com>
Date: Tue, 22 Jun 2021 17:11:06 +0800
Subject: [LTP] [PATCH 0/2 v2] Add tests for libaio
Message-ID: <20210622091108.249098-1-xieziyao@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

v1->v2:
1. Modification of the output format.

Xie Ziyao (2):
  io_cancel02: Add io_cancel02 test for libaio
  io_getevents02: Add io_getevents02 test for libaio

 runtest/syscalls                              |  2 +
 .../kernel/syscalls/io_cancel/.gitignore      |  1 +
 .../kernel/syscalls/io_cancel/io_cancel02.c   | 54 +++++++++++++++++++
 .../kernel/syscalls/io_getevents/.gitignore   |  1 +
 .../syscalls/io_getevents/io_getevents02.c    | 53 ++++++++++++++++++
 5 files changed, 111 insertions(+)
 create mode 100644 testcases/kernel/syscalls/io_cancel/io_cancel02.c
 create mode 100644 testcases/kernel/syscalls/io_getevents/io_getevents02.c

--
2.17.1

