From: Richard Palethorpe <rpalethorpe@suse.com>
Date: Fri, 29 Jan 2021 17:02:58 +0000
Subject: [LTP] [PATCH v4 0/7] Convert CAN tests to new LTP API
Message-ID: <20210129170305.27383-1-rpalethorpe@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello,

This converts the CAN tests to the modern Linux Test Project API and
removes the wrapper script. To be clear, this is a patch-set for the
LTP *not* the kernel tree or can-utils.

I have tried to keep the core test behaviour the same, but (for
example) moving to the SAFE_ functions will naturally introduce some
changes in error checking. Deliberate behavioral changes have been
noted in the commit messages.

FYI, we appear to have 4 CAN tests in LTP including two tests for
SLCAN (pty03, pty04). It appears these could be quite easily extended.

V2: Update e-mail addresses and resend
V3:
* Add COPYING and use dual license SPDX identifier
* Fix compilation issues with can_common.h
V4:
* Remove IFF_ECHO fallback which is not needed with only linux/if.h
* Add missing static to function
* State effect of echo on coverage
* remove shell script from runtest file
* Add various git trailers

Richard Palethorpe (7):
  API: Add FILE_SCANF to new lib
  can: Add can_common.h for vcan device setup
  can: Add COPYING with dual license text
  can_filter: Convert to new library
  can_recv_own_msgs: Convert to new library
  can: Remove obsolete test wrapper script
  can: Update contact details

 include/tst_safe_file_ops.h                   |   3 +
 runtest/can                                   |   4 +-
 testcases/network/can/Makefile                |   2 -
 .../can/filter-tests/00_Descriptions.txt      |   6 +-
 testcases/network/can/filter-tests/COPYING    |  35 ++
 testcases/network/can/filter-tests/INSTALL    |   3 +-
 testcases/network/can/filter-tests/Makefile   |   4 -
 .../network/can/filter-tests/can_common.h     |  71 ++++
 .../network/can/filter-tests/can_filter.c     | 317 +++++++-----------
 .../can/filter-tests/can_rcv_own_msgs.c       | 273 +++++----------
 .../network/can/filter-tests/can_run_tests.sh | 106 ------
 11 files changed, 329 insertions(+), 495 deletions(-)
 create mode 100644 testcases/network/can/filter-tests/COPYING
 create mode 100644 testcases/network/can/filter-tests/can_common.h
 delete mode 100755 testcases/network/can/filter-tests/can_run_tests.sh

-- 
2.30.0

