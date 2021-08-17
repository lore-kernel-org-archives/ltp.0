From: Xie Ziyao <xieziyao@huawei.com>
Date: Tue, 17 Aug 2021 14:49:17 +0800
Subject: [LTP] [PATCH 0/7] epoll: Add more basic test for epoll_{create,
 create1, ctl}
Message-ID: <20210817064924.127970-1-xieziyao@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Xie Ziyao (7):
  epoll_ctl: Add docparse formatting and cleanup for epoll_ctl01
  epoll_ctl: Add docparse formatting and cleanup for epoll_ctl02
  epoll_ctl: Add test for epoll_ctl03
  epoll_create1: Add docparse formatting and cleanup for
    epoll_create1_01
  epoll_create1: Add test for epoll_create1_02
  epoll_create: Add test for epoll_create01
  epoll_create: Add test for epoll_create02

 runtest/syscalls                              |  4 +
 .../kernel/syscalls/epoll_create/.gitignore   |  2 +
 .../kernel/syscalls/epoll_create/Makefile     |  9 ++
 .../syscalls/epoll_create/epoll_create01.c    | 40 +++++++++
 .../syscalls/epoll_create/epoll_create02.c    | 37 ++++++++
 .../kernel/syscalls/epoll_create1/.gitignore  |  3 +-
 .../syscalls/epoll_create1/epoll_create1_01.c | 53 ++++++-----
 .../syscalls/epoll_create1/epoll_create1_02.c | 38 ++++++++
 .../kernel/syscalls/epoll_ctl/.gitignore      |  5 +-
 .../kernel/syscalls/epoll_ctl/epoll_ctl01.c   | 28 +++---
 .../kernel/syscalls/epoll_ctl/epoll_ctl02.c   | 87 +++++++------------
 .../kernel/syscalls/epoll_ctl/epoll_ctl03.c   | 75 ++++++++++++++++
 12 files changed, 280 insertions(+), 101 deletions(-)
 create mode 100644 testcases/kernel/syscalls/epoll_create/.gitignore
 create mode 100644 testcases/kernel/syscalls/epoll_create/Makefile
 create mode 100644 testcases/kernel/syscalls/epoll_create/epoll_create01.c
 create mode 100644 testcases/kernel/syscalls/epoll_create/epoll_create02.c
 create mode 100644 testcases/kernel/syscalls/epoll_create1/epoll_create1_02.c
 create mode 100644 testcases/kernel/syscalls/epoll_ctl/epoll_ctl03.c

--
2.17.1

