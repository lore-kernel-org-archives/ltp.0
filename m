From: Filip Bozuta <Filip.Bozuta@syrmia.com>
Date: Sun, 20 Sep 2020 17:46:32 +0200
Subject: [LTP] [PATCH v4 0/1] Adding new testcases for existing tests
Message-ID: <20200920154633.27255-1-Filip.Bozuta@syrmia.com>
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

v4:

    * Changed the timeout test to make the second message be received
      after the timeout so that it doesn't brake the test with option
      '-i n'
    * Created a separate 'recvmmsg01.c' where the errno test cases for
      'recvmmsg()' are moved
    * Create a common header 'sendmmsg.h' where all the other necessary
      headers along with the 'test_variants' array, test 'setup()' and
      'test_cleanup()' for files 'sendmmsg01.c', 'sendmmsg02.c',
      'recvmmsg01.c'

Filip Bozuta (1):
  syscalls/{send|recv}mmsg: add a test case for timeout and errno test

 runtest/syscalls                              |   3 +
 testcases/kernel/syscalls/recvmmsg/Makefile   |   7 +
 .../kernel/syscalls/recvmmsg/recvmmsg01.c     | 127 ++++++++++++++++
 testcases/kernel/syscalls/sendmmsg/.gitignore |   1 +
 testcases/kernel/syscalls/sendmmsg/sendmmsg.h |  81 ++++++++++
 .../kernel/syscalls/sendmmsg/sendmmsg01.c     | 142 +++++++-----------
 .../kernel/syscalls/sendmmsg/sendmmsg02.c     |  80 ++++++++++
 7 files changed, 356 insertions(+), 85 deletions(-)
 create mode 100644 testcases/kernel/syscalls/recvmmsg/Makefile
 create mode 100644 testcases/kernel/syscalls/recvmmsg/recvmmsg01.c
 create mode 100644 testcases/kernel/syscalls/sendmmsg/sendmmsg.h
 create mode 100644 testcases/kernel/syscalls/sendmmsg/sendmmsg02.c

-- 
2.27.0

