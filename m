From: Xie Ziyao <xieziyao@huawei.com>
Date: Thu, 29 Apr 2021 19:50:18 +0800
Subject: [LTP] [PATCH 0/3] syscalls/aio: Convert libaio wrapper function to
 kernel syscall
Message-ID: <20210429115021.24128-1-xieziyao@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Instead of using the libaio wrapper function, the system call is changed to be invoked via syscall(2).

Xie Ziyao (3):
  syscalls/io_destroy: Convert libaio wrapper function to kernel syscall
  syscalls/io_setup: Convert libaio wrapper function to kernel syscall
  syscalls/io_submit: Convert libaio wrapper function to kernel syscall

 .../kernel/syscalls/io_destroy/io_destroy01.c |  49 ++------
 .../kernel/syscalls/io_setup/io_setup01.c     |  94 +++++----------
 .../kernel/syscalls/io_submit/io_submit01.c   | 110 ++++++++----------
 3 files changed, 86 insertions(+), 167 deletions(-)

--
2.17.1

