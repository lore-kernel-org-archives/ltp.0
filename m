From: Xie Ziyao <ziyaoxie@outlook.com>
Date: Wed, 25 Aug 2021 15:39:28 +0000
Subject: [LTP] [PATCH 0/4 v2] epoll: Add tests for epoll_{create, ctl}
Message-ID: <OSZP286MB08710D473C99D3B97231379ECCC69@OSZP286MB0871.JPNP286.PROD.OUTLOOK.COM>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: "Xie Ziyao" <ziyaoxie@outlook.com>

v1->v2:
1. Add a IS_BIT_SET() macro to check whether the n-th bit of val is set.
2. Use TST_EXP_FD() to check whether fd is valid in epoll_create01.

"Xie Ziyao" (4):
  api: Add a IS_BIT_SET() macro in tst_bitmap.h
  epoll_ctl: Add test for epoll_ctl03
  epoll_create: Add test for epoll_create01
  epoll_create: Add test for epoll_create02

 include/tst_bitmap.h                          | 15 ++++
 runtest/syscalls                              |  3 +
 .../kernel/syscalls/epoll_create/.gitignore   |  2 +
 .../kernel/syscalls/epoll_create/Makefile     |  9 +++
 .../syscalls/epoll_create/epoll_create01.c    | 37 +++++++++
 .../syscalls/epoll_create/epoll_create02.c    | 37 +++++++++
 .../kernel/syscalls/epoll_ctl/.gitignore      |  5 +-
 .../kernel/syscalls/epoll_ctl/epoll_ctl03.c   | 78 +++++++++++++++++++
 8 files changed, 184 insertions(+), 2 deletions(-)
 create mode 100644 include/tst_bitmap.h
 create mode 100644 testcases/kernel/syscalls/epoll_create/.gitignore
 create mode 100644 testcases/kernel/syscalls/epoll_create/Makefile
 create mode 100644 testcases/kernel/syscalls/epoll_create/epoll_create01.c
 create mode 100644 testcases/kernel/syscalls/epoll_create/epoll_create02.c
 create mode 100644 testcases/kernel/syscalls/epoll_ctl/epoll_ctl03.c

--
2.25.1

