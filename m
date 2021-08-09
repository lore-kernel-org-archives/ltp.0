From: Xie Ziyao <xieziyao@huawei.com>
Date: Mon, 9 Aug 2021 16:38:59 +0800
Subject: [LTP] [PATCH 0/4] epoll_wait: Add test for epoll_wait04 and cleanup
Message-ID: <20210809083903.161596-1-xieziyao@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Xie Ziyao (4):
  epoll_wait: Add docparse formatting and cleanup for epoll_wait01
  epoll_wait: Add docparse formatting and fix warnings from
    checkpatch.pl
  epoll_wait: Convert epoll_wait03 to the new API
  epoll_wait: Add test for epoll_wait04

 runtest/syscalls                              |   1 +
 .../kernel/syscalls/epoll_wait/.gitignore     |   7 +-
 .../kernel/syscalls/epoll_wait/epoll_wait01.c |  29 ++--
 .../kernel/syscalls/epoll_wait/epoll_wait02.c |  13 +-
 .../kernel/syscalls/epoll_wait/epoll_wait03.c | 157 +++++-------------
 .../kernel/syscalls/epoll_wait/epoll_wait04.c |  71 ++++++++
 6 files changed, 140 insertions(+), 138 deletions(-)
 create mode 100644 testcases/kernel/syscalls/epoll_wait/epoll_wait04.c

--
2.17.1

