From: Xie Ziyao <ziyaoxie@outlook.com>
Date: Mon, 30 Aug 2021 19:16:35 +0800
Subject: [LTP] [PATCH 0/3] epoll: Add new testcases for epoll_ctl
Message-ID: <OSZP286MB0871850A0D09CD5926C0C55FCCCB9@OSZP286MB0871.JPNP286.PROD.OUTLOOK.COM>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Xie Ziyao (3):
  epoll_ctl: Add test for epoll_ctl04
  epoll_ctl: Add test for epoll_ctl05
  epoll_ctl02: Add test for fd not supporting epoll

 runtest/syscalls                              |  2 +
 .../kernel/syscalls/epoll_ctl/.gitignore      |  2 +
 .../kernel/syscalls/epoll_ctl/epoll_ctl02.c   |  8 ++-
 .../kernel/syscalls/epoll_ctl/epoll_ctl04.c   | 69 ++++++++++++++++++
 .../kernel/syscalls/epoll_ctl/epoll_ctl05.c   | 71 +++++++++++++++++++
 5 files changed, 150 insertions(+), 2 deletions(-)
 create mode 100644 testcases/kernel/syscalls/epoll_ctl/epoll_ctl04.c
 create mode 100644 testcases/kernel/syscalls/epoll_ctl/epoll_ctl05.c

--
2.25.1

