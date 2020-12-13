From: Filip Bozuta <Filip.Bozuta@syrmia.com>
Date: Sun, 13 Dec 2020 23:47:28 +0100
Subject: [LTP] [PATCH v5 0/1] Adding new testcases for existing tests
Message-ID: <20201213224729.17974-1-Filip.Bozuta@syrmia.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This series introduces new test cases for existing tests for syscalls:

    * sendmmsg()
    * recvmmsg()

These new test cases are part of my work of implementation for 2038
safe variants of the above mentioned 'recvmmsg()':

    * recvmmsg_time64()

These test cases are needed to make sure that QEMU implementation of
the above mentioned time64 syscall works properly.

v5:

    * Fixed the compilation error in 'recvmmsg01.c'
    * Created a separate setup for each test
    * Removed useless 'retval' variable

Filip Bozuta (1):
  syscalls/{send|recv}mmsg: add a test case for timeout and errno test

 runtest/syscalls                              |   3 +
 testcases/kernel/syscalls/recvmmsg/Makefile   |   7 +
 .../kernel/syscalls/recvmmsg/recvmmsg01.c     | 146 ++++++++++++++++++
 testcases/kernel/syscalls/sendmmsg/.gitignore |   1 +
 testcases/kernel/syscalls/sendmmsg/sendmmsg.h |  45 ++++++
 .../kernel/syscalls/sendmmsg/sendmmsg01.c     | 111 ++++++-------
 .../kernel/syscalls/sendmmsg/sendmmsg02.c     |  87 +++++++++++
 7 files changed, 347 insertions(+), 53 deletions(-)
 create mode 100644 testcases/kernel/syscalls/recvmmsg/Makefile
 create mode 100644 testcases/kernel/syscalls/recvmmsg/recvmmsg01.c
 create mode 100644 testcases/kernel/syscalls/sendmmsg/sendmmsg.h
 create mode 100644 testcases/kernel/syscalls/sendmmsg/sendmmsg02.c

-- 
2.25.1

