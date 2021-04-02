From: Xie Ziyao <xieziyao@huawei.com>
Date: Fri, 2 Apr 2021 11:46:10 +0800
Subject: [LTP] [PATCH 0/2] cleanup: Modify incorrect use of test macros and
 annotation style
Message-ID: <20210402034612.127912-1-xieziyao@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

- modify incorrect use of test macros;
- unify the annotation style and remove Redundant code.

Xie Ziyao (2):
  Modify incorrect use of TERRNO and replace functions with safe_macros
  Unify the annotation style and remove Redundant code

 testcases/kernel/syscalls/bpf/bpf_map01.c     |  2 +-
 .../syscalls/clock_gettime/clock_gettime03.c  | 20 +++++++------------
 .../clock_nanosleep/clock_nanosleep01.c       |  2 +-
 .../clock_nanosleep/clock_nanosleep03.c       | 18 +++++++----------
 testcases/kernel/syscalls/clone3/clone301.c   |  5 +++++
 testcases/kernel/syscalls/clone3/clone302.c   |  5 +++++
 .../copy_file_range/copy_file_range02.c       |  2 +-
 .../copy_file_range/copy_file_range03.c       |  2 +-
 testcases/kernel/syscalls/dup/dup03.c         |  4 ++--
 testcases/kernel/syscalls/execle/Makefile     | 19 +++---------------
 testcases/kernel/syscalls/execlp/Makefile     | 19 +++---------------
 testcases/kernel/syscalls/execve/execve02.c   |  4 ++--
 testcases/kernel/syscalls/execvp/Makefile     | 20 +++----------------
 .../kernel/syscalls/fallocate/fallocate04.c   |  2 +-
 testcases/kernel/syscalls/getcwd/getcwd01.c   |  4 ++--
 testcases/kernel/syscalls/getcwd/getcwd02.c   |  2 +-
 .../syscalls/init_module/init_module01.c      |  2 +-
 .../syscalls/init_module/init_module02.c      |  2 +-
 .../kernel/syscalls/io_uring/io_uring02.c     | 10 +++++-----
 testcases/kernel/syscalls/ioctl/ioctl04.c     |  4 ++--
 testcases/kernel/syscalls/ioperm/ioperm01.c   |  2 +-
 testcases/kernel/syscalls/lgetxattr/Makefile  | 16 +--------------
 22 files changed, 56 insertions(+), 110 deletions(-)

--
2.17.1

