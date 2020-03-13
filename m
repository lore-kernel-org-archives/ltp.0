From: Vikas Kumar <vikas.kumar2@arm.com>
Date: Fri, 13 Mar 2020 11:50:57 +0530
Subject: [LTP] [PATCH 0/1] Added Refrence for Linux Asynchronous IO APIs in
 LTP
Message-ID: <20200313062058.7058-1-vikas.kumar2@arm.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

    Enabled Linux Asynchronous IO(AIO) family of APIs in LTP
    AIO API: io_uring_setup(), io_uring_register(), io_uring_enter()
    
    Refrences for Linux AIO-
    
    https://lwn.net/Articles/776703/
    https://kernel.dk/io_uring.pdf
    https://www.mankier.com/2/io_uring_setup
    https://www.mankier.com/2/io_uring_register
    https://www.mankier.com/2/io_uring_enter
    
    Signed-off-by: Vikas Kumar <vikas.kumar2@arm.com>

---

Vikas Kumar (1):
  Added Refrence for Linux Asynchronous IO APIs in LTP

 configure.ac                                  |   3 +
 include/lapi/io_uring.h                       | 180 ++++++++++++++++++
 testcases/kernel/syscalls/io_uring/.gitignore |   1 +
 testcases/kernel/syscalls/io_uring/Makefile   |  25 +++
 .../kernel/syscalls/io_uring/io_uring01.c     |  85 +++++++++
 5 files changed, 294 insertions(+)
 create mode 100644 include/lapi/io_uring.h
 create mode 100644 testcases/kernel/syscalls/io_uring/.gitignore
 create mode 100644 testcases/kernel/syscalls/io_uring/Makefile
 create mode 100644 testcases/kernel/syscalls/io_uring/io_uring01.c

-- 
2.17.1

