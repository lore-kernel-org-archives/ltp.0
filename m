From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 27 Mar 2020 14:47:05 +0100
Subject: [LTP] [PATCH 0/2] [RFC] Add needs_devices && basic uart test
Message-ID: <20200327134707.4532-1-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This is not yet finished and work-in-progress, but it shows the
directions I think the device drivers should take.

This series adds a .needs_devices array of strings to the tst_test
structure which is expected to hold well defined list of environment
variables with well known names. In this case its UART_RX and UART_TX
which should be obvious. Other tests may need I2C_ADDR etc.

The value of these depends on a particular hardware/lab settings so
apart from checking that these are defined the test libary does not
attempt to do anything about these. The expectation here is that in the
future the test description format I'm working on would be parsed by the
test execution framework, which would then call a user defined helper
script to get the values for these variables. For now we would have to
run these scripts prior the LTP run to get these variables defined.

Cyril Hrubis (2):
  tst_test: Add support for needs_devices
  device_drivers/uart01: Add uart01 test

 include/tst_test.h                            |   3 +
 lib/tst_test.c                                |  32 ++
 runtest/kernel_misc                           |   5 +
 .../kernel/device-drivers/uart/.gitignore     |   1 +
 testcases/kernel/device-drivers/uart/Makefile |   4 +
 testcases/kernel/device-drivers/uart/uart01.c | 522 ++++++++++++++++++
 6 files changed, 567 insertions(+)
 create mode 100644 testcases/kernel/device-drivers/uart/.gitignore
 create mode 100644 testcases/kernel/device-drivers/uart/Makefile
 create mode 100644 testcases/kernel/device-drivers/uart/uart01.c

-- 
2.24.1

