From: Xie Ziyao <xieziyao@huawei.com>
Date: Tue, 10 Aug 2021 19:00:22 +0800
Subject: [LTP] [PATCH 0/2] Add test for epoll_pwait{04, 05}
Message-ID: <20210810110024.106436-1-xieziyao@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Xie Ziyao (2):
  epoll_pwait: Add invalid sigmask test for epoll_pwait04
  epoll_pwait: Add invalid timespec test for epoll_pwait05

 runtest/syscalls                              |  2 +
 .../kernel/syscalls/epoll_pwait/.gitignore    |  2 +
 .../syscalls/epoll_pwait/epoll_pwait04.c      | 61 ++++++++++++++++
 .../syscalls/epoll_pwait/epoll_pwait05.c      | 70 +++++++++++++++++++
 4 files changed, 135 insertions(+)
 create mode 100644 testcases/kernel/syscalls/epoll_pwait/epoll_pwait04.c
 create mode 100644 testcases/kernel/syscalls/epoll_pwait/epoll_pwait05.c

--
2.17.1

