From: Richard Palethorpe <rpalethorpe@suse.com>
Date: Mon, 18 Jan 2021 15:56:23 +0000
Subject: [LTP] [PATCH 0/5] Convert CAN tests to new LTP API
Message-ID: <20210118155628.9248-1-rpalethorpe@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello,

This is an attempt to convert the CAN tests to the (modern) LTP API
and removes the wrapper script. I have tried to keep the core test
behaviour the same, but (for example) moving to the SAFE_ functions
will naturally introduce some changes in error checking. Deliberate
behavioral changes have been noted in the commit messages.

Richard Palethorpe (5):
  API: Add FILE_SCANF to new lib
  can: Add can_common.h for vcan device setup
  can_filter: Convert to new library
  can_recv_own_msgs: Convert to new library
  can: Remove obsolete test wrapper script

 include/tst_safe_file_ops.h                   |   3 +
 testcases/network/can/Makefile                |   2 -
 .../can/filter-tests/00_Descriptions.txt      |   1 +
 testcases/network/can/filter-tests/INSTALL    |   3 +-
 testcases/network/can/filter-tests/Makefile   |   2 -
 .../network/can/filter-tests/can_common.h     |  70 ++++
 .../network/can/filter-tests/can_filter.c     | 317 +++++++-----------
 .../can/filter-tests/can_rcv_own_msgs.c       | 273 +++++----------
 .../network/can/filter-tests/can_run_tests.sh | 106 ------
 9 files changed, 288 insertions(+), 489 deletions(-)
 create mode 100644 testcases/network/can/filter-tests/can_common.h
 delete mode 100755 testcases/network/can/filter-tests/can_run_tests.sh

-- 
2.29.2

