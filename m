From: gengcixi@gmail.com <gengcixi@gmail.com>
Date: Wed, 23 Dec 2020 11:35:14 +0800
Subject: [LTP] [PATCH 0/3] add rtctime libs and rtc02 case
Message-ID: <20201223033517.1464263-1-gengcixi@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: Cixi Geng <cixi.geng1@unisoc.com>

This file is a implementation for rtc test function
in tst_rtctime lib, support tst_rtc_gettime and tst_rtc_settime;
at the same file, also add rtctime and time_t convert functions.
in tst_wallclock.s, add tst_rtc_save and tst_rtc_restore for testcase
used in SETUP and CLEANUP.

the rtc02 testcase is verify set rtctime a exact timestamp.

Cixi Geng (3):
  lib: add tst_rtctime* for rtc test
  lib: implement rtctime_save and rtctime_restore function
  rtc02: add rtc set time verify case

 include/tst_rtctime.h                         |  15 ++
 include/tst_wallclock.h                       |   4 +
 lib/tst_rtctime.c                             | 161 ++++++++++++++++++
 lib/tst_wallclock.c                           |  42 +++++
 runtest/kernel_misc                           |   1 +
 .../kernel/device-drivers/rtc/.gitignore      |   1 +
 testcases/kernel/device-drivers/rtc/rtc02.c   | 108 ++++++++++++
 7 files changed, 332 insertions(+)
 create mode 100644 include/tst_rtctime.h
 create mode 100644 lib/tst_rtctime.c
 create mode 100644 testcases/kernel/device-drivers/rtc/rtc02.c

-- 
2.25.1

