From: gengcixi@gmail.com <gengcixi@gmail.com>
Date: Mon, 11 Jan 2021 16:37:07 +0800
Subject: [LTP] [PATCH V2 0/3] add rtctime libs and rtc02 case
Message-ID: <20210111083711.1715851-1-gengcixi@gmail.com>
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

V2 changes:
1. add passing rtd_dev int tst_rtc_gettime, tst_rtc_settime, 
  tst_rtc_clock_save and tst_rtc_clock_restore functions.
  
2. move check device exist functions from lib into testcase

3. rename tst_rtctime_save|tst_rtctime_restore to tst_rtc_clock_save|
  tst_rtc_clock_restore

4. test description and identifiers format issues.

NO chanages:
1. keep tst_rtc_gettime and tst_rtc_settime no change to "static 
   inline"(V1) for some compile warning and referring to 
   tst_clock_gettime in tst_clocks.h

2. in .h, use identifiers format "/* XXX /*" rather than "// XXX" 
   for kernel checkpatch "WARNING" as follow:

```
WARNING: Improper SPDX comment style for 'include/tst_rtctime.h', please use '/*' instead
\#26: FILE: include/tst_rtctime.h:1:
+// SPDX-License-Identifier: GPL-2.0-or-later

WARNING: Missing or malformed SPDX-License-Identifier tag in line 1
\#26: FILE: include/tst_rtctime.h:1:
+// SPDX-License-Identifier: GPL-2.0-or-later
```

Cixi Geng (3):
  lib: add tst_rtctime* for rtc test
  lib: implement rtc_clock_save and rtc_clock_restore function
  device-drivers/rtc: add verify rtc set time case

 include/tst_rtctime.h                         |  15 ++
 include/tst_wallclock.h                       |   4 +
 lib/tst_rtctime.c                             | 159 ++++++++++++++++++
 lib/tst_wallclock.c                           |  44 +++++
 runtest/kernel_misc                           |   1 +
 .../kernel/device-drivers/rtc/.gitignore      |   1 +
 testcases/kernel/device-drivers/rtc/rtc02.c   | 111 ++++++++++++
 7 files changed, 335 insertions(+)
 create mode 100644 include/tst_rtctime.h
 create mode 100644 lib/tst_rtctime.c
 create mode 100644 testcases/kernel/device-drivers/rtc/rtc02.c

-- 
2.25.1

