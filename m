From: Filip Bozuta <Filip.Bozuta@syrmia.com>
Date: Tue,  4 Aug 2020 16:40:42 +0200
Subject: [LTP] [PATCH 0/3] testcases/kernel/syscalls: Adding new testcases
 for existing tests
Message-ID: <20200804144045.18875-1-Filip.Bozuta@syrmia.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This series introduces new test cases for existing tests for syscalls

    * mq_timedsend()        * sendmmsg()
    * mq_timedreceive()     * recvmmsg()
    * clock_nanosleep()

* First patch in the series introduces bad address test cases for
  'mq_timedsend()' and 'mq_timedreceive()'

* Second patch in the series introduces bad timespec address cases
  for 'clock_nanosleep()'

* Third patch in the series introduces a timeout case and an errno
  test for 'sendmmsg()' and 'recvmmsg()'

More detailed descriptions of these newly added test cases and the
implementation details can be found in this series patch commit
messages.

These new test cases are part of my work of implementation for 2038
safe variants of the above mentioned syscalls in QEMU:

    * mq_timedsend_time64()
    * mq_timedreceive_time64()
    * clock_nanosleep_time64()
    * recvmmsg_time64()

These test cases are needed to make sure that QEMU implementations of
the above mentioned time64 syscalls work properly.

These test cases are also used to fix some minor issues with already
existing implementations of regular variants of these syscalls.

Filip Bozuta (3):
  syscalls/mq_timed{send|receive}: Add test cases for bad address
  syscalls/clock_nanosleep: add a test case for bad timespec address
  syscalls/{send|recv}mmsg: add a test case for timeout and errno test

 runtest/syscalls                              |   1 +
 .../clock_nanosleep/clock_nanosleep01.c       |  27 ++-
 .../mq_timedreceive/mq_timedreceive01.c       |  12 +-
 .../syscalls/mq_timedsend/mq_timedsend01.c    |  23 +-
 testcases/kernel/syscalls/sendmmsg/.gitignore |   1 +
 .../kernel/syscalls/sendmmsg/sendmmsg01.c     |  69 ++++--
 .../kernel/syscalls/sendmmsg/sendmmsg02.c     | 223 ++++++++++++++++++
 testcases/kernel/syscalls/utils/mq_timed.h    |   2 +
 8 files changed, 338 insertions(+), 20 deletions(-)
 create mode 100644 testcases/kernel/syscalls/sendmmsg/sendmmsg02.c

-- 
2.25.1

