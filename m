From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 23 Jun 2020 13:28:25 +0200
Subject: [LTP] [PATCH 0/2] [RFC] Device discovery & UART test
Message-ID: <20200623112827.10744-1-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This is not 100% finished and I do not intend to merge the code as it
is. The main purpose is to show the direction in which I think we should
move in order to include the device drivers in LTP.

Have a look at the "Add support for device discovery" patch that
introduces the important pieces.

Cyril Hrubis (2):
  tst_test: Add support for device discovery
  device_drivers/uart01: Add uart01 test

 device-discovery.sh                           |   5 +
 include/tst_test.h                            |   3 +
 lib/tst_devices.c                             | 228 ++++++++
 lib/tst_devices.h                             |  32 ++
 lib/tst_test.c                                |  60 +-
 runtest/kernel_misc                           |   5 +
 .../kernel/device-drivers/uart/.gitignore     |   1 +
 testcases/kernel/device-drivers/uart/Makefile |   4 +
 testcases/kernel/device-drivers/uart/uart01.c | 522 ++++++++++++++++++
 9 files changed, 853 insertions(+), 7 deletions(-)
 create mode 100755 device-discovery.sh
 create mode 100644 lib/tst_devices.c
 create mode 100644 lib/tst_devices.h
 create mode 100644 testcases/kernel/device-drivers/uart/.gitignore
 create mode 100644 testcases/kernel/device-drivers/uart/Makefile
 create mode 100644 testcases/kernel/device-drivers/uart/uart01.c

-- 
2.26.2

