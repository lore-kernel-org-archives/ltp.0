From: Filip Bozuta <Filip.Bozuta@syrmia.com>
Date: Mon, 17 Aug 2020 12:22:30 +0200
Subject: [LTP] [PATCH v3 0/2] testcases/kernel/syscalls: Adding new
 testcases for existing tests
Message-ID: <20200817102232.5902-1-Filip.Bozuta@syrmia.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This series introduces new test cases for existing tests for syscalls:

    * clock_nanosleep()
    * sendmmsg()
    * recvmmsg()

* First patch in the series introduces bad timespec address cases
  for 'clock_nanosleep()'

* Second patch in the series introduces a timeout case and an errno
  test for 'sendmmsg()' and 'recvmmsg()'

More detailed descriptions of these newly added test cases and the
implementation details can be found in this series patch commit
messages.

These new test cases are part of my work of implementation for 2038
safe variants of the above mentioned syscalls in QEMU:

    * clock_nanosleep_time64()
    * recvmmsg_time64()

These test cases are needed to make sure that QEMU implementations of
the above mentioned time64 syscalls work properly.

These test cases are also used to fix some minor issues with already
existing implementations of regular variants of these syscalls.

v2:

    * Changed bad address values from (void *)1 to using function
      'tst_get_bad_addr()'
    * Removed unnecessary implementation descriptions that can be
      seen from the patches

v3:
    * Removed first patch from the series as it got pushed
    * Moved the bad adrress intilization in the test 'setup()' part

Filip Bozuta (2):
  syscalls/clock_nanosleep: add a test case for bad timespec address
  syscalls/{send|recv}mmsg: add a test case for timeout and errno test

 runtest/syscalls                              |   1 +
 .../clock_nanosleep/clock_nanosleep01.c       |  43 +++-
 testcases/kernel/syscalls/sendmmsg/.gitignore |   1 +
 .../kernel/syscalls/sendmmsg/sendmmsg01.c     |  68 +++--
 .../kernel/syscalls/sendmmsg/sendmmsg02.c     | 235 ++++++++++++++++++
 5 files changed, 329 insertions(+), 19 deletions(-)
 create mode 100644 testcases/kernel/syscalls/sendmmsg/sendmmsg02.c

-- 
2.25.1

