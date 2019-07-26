From: Christian Amann <camann@suse.com>
Date: Fri, 26 Jul 2019 08:13:16 +0200
Subject: [LTP] [PATCH v1] Moved timer tests to syscall directory
Message-ID: <20190726061316.9183-1-camann@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

- Moved all timer tests to the syscall directory and made the numbers
  start from 1 again (e.g timer_create02 -> timer_create01).
- Moved common_timers.h to lapi include directory.
- Moved the contents of the runtest/timers file into the
  runtest/syscalls file
- Moved leapsec_timer test to the other clock_gettime tests

Signed-off-by: Christian Amann <camann@suse.com>
---
 .../include => include/lapi}/common_timers.h       |  1 -
 runtest/syscalls                                   | 10 ++++++++
 runtest/timers                                     |  8 -------
 testcases/kernel/syscalls/clock_gettime/.gitignore |  1 +
 .../clock_gettime/clock_gettime03.c}               |  2 +-
 .../{timers => syscalls}/timer_create/.gitignore   |  2 +-
 .../{timers => syscalls}/timer_create/Makefile     |  0
 .../timer_create/timer_create01.c}                 |  2 +-
 .../timer_create/timer_create02.c}                 |  2 +-
 .../{timers => syscalls}/timer_delete/.gitignore   |  2 +-
 .../{timers => syscalls}/timer_delete/Makefile     |  0
 .../timer_delete/timer_delete01.c}                 |  2 +-
 .../timer_delete/timer_delete02.c}                 |  2 +-
 .../{timers => syscalls}/timer_settime/.gitignore  |  2 +-
 .../{timers => syscalls}/timer_settime/Makefile    |  0
 .../timer_settime/timer_settime01.c}               |  2 +-
 .../timer_settime/timer_settime02.c}               |  2 +-
 testcases/kernel/timers/Makefile                   | 27 ----------------------
 testcases/kernel/timers/leapsec/.gitignore         |  1 -
 testcases/kernel/timers/leapsec/Makefile           | 27 ----------------------
 20 files changed, 21 insertions(+), 74 deletions(-)
 rename {testcases/kernel/timers/include => include/lapi}/common_timers.h (98%)
 delete mode 100644 runtest/timers
 rename testcases/kernel/{timers/leapsec/leapsec_timer.c => syscalls/clock_gettime/clock_gettime03.c} (99%)
 rename testcases/kernel/{timers => syscalls}/timer_create/.gitignore (50%)
 rename testcases/kernel/{timers => syscalls}/timer_create/Makefile (100%)
 rename testcases/kernel/{timers/timer_create/timer_create02.c => syscalls/timer_create/timer_create01.c} (98%)
 rename testcases/kernel/{timers/timer_create/timer_create04.c => syscalls/timer_create/timer_create02.c} (98%)
 rename testcases/kernel/{timers => syscalls}/timer_delete/.gitignore (50%)
 rename testcases/kernel/{timers => syscalls}/timer_delete/Makefile (100%)
 rename testcases/kernel/{timers/timer_delete/timer_delete02.c => syscalls/timer_delete/timer_delete01.c} (97%)
 rename testcases/kernel/{timers/timer_delete/timer_delete03.c => syscalls/timer_delete/timer_delete02.c} (96%)
 rename testcases/kernel/{timers => syscalls}/timer_settime/.gitignore (50%)
 rename testcases/kernel/{timers => syscalls}/timer_settime/Makefile (100%)
 rename testcases/kernel/{timers/timer_settime/timer_settime02.c => syscalls/timer_settime/timer_settime01.c} (98%)
 rename testcases/kernel/{timers/timer_settime/timer_settime03.c => syscalls/timer_settime/timer_settime02.c} (99%)
 delete mode 100644 testcases/kernel/timers/Makefile
 delete mode 100644 testcases/kernel/timers/leapsec/.gitignore
 delete mode 100644 testcases/kernel/timers/leapsec/Makefile

diff --git a/testcases/kernel/timers/include/common_timers.h b/include/lapi/common_timers.h
similarity index 98%
rename from testcases/kernel/timers/include/common_timers.h
rename to include/lapi/common_timers.h
index 154be670f..df4196eeb 100644
--- a/testcases/kernel/timers/include/common_timers.h
+++ b/include/lapi/common_timers.h
@@ -7,7 +7,6 @@
 #ifndef __COMMON_TIMERS_H__
 #define __COMMON_TIMERS_H__
 
-#define CLEANUP cleanup
 #include "config.h"
 #include "lapi/syscalls.h"
 #include "lapi/posix_clocks.h"
diff --git a/runtest/syscalls b/runtest/syscalls
index 67dfed661..79a6a0bb6 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -83,6 +83,7 @@ clock_nanosleep2_01 clock_nanosleep2_01
 
 clock_gettime01 clock_gettime01
 clock_gettime02 clock_gettime02
+clock_gettime03 clock_gettime03
 
 clock_settime01 clock_settime01
 clock_settime02 clock_settime02
@@ -1438,9 +1439,18 @@ timerfd_create01 timerfd_create01
 timerfd_gettime01 timerfd_gettime01
 timerfd_settime01 timerfd_settime01
 
+timer_create01 timer_create01
+timer_create02 timer_create02
+
+timer_delete01 timer_delete01
+timer_delete02 timer_delete02
+
 timer_getoverrun01 timer_getoverrun01
 timer_gettime01 timer_gettime01
 
+timer_settime01 timer_settime01
+timer_settime02 timer_settime02
+
 tkill01 tkill01
 tkill02 tkill02
 
diff --git a/runtest/timers b/runtest/timers
deleted file mode 100644
index 54467fa78..000000000
--- a/runtest/timers
+++ /dev/null
@@ -1,8 +0,0 @@
-#DESCRIPTION:Posix Timer Tests
-timer_create02 timer_create02
-timer_create04 timer_create04
-timer_delete02 timer_delete02
-timer_delete03 timer_delete03
-timer_settime02 timer_settime02
-timer_settime03 timer_settime03
-leapsec_timer leapsec_timer
diff --git a/testcases/kernel/syscalls/clock_gettime/.gitignore b/testcases/kernel/syscalls/clock_gettime/.gitignore
index 0f9b24ab6..eb42add38 100644
--- a/testcases/kernel/syscalls/clock_gettime/.gitignore
+++ b/testcases/kernel/syscalls/clock_gettime/.gitignore
@@ -1,2 +1,3 @@
 clock_gettime01
 clock_gettime02
+clock_gettime03
diff --git a/testcases/kernel/timers/leapsec/leapsec_timer.c b/testcases/kernel/syscalls/clock_gettime/clock_gettime03.c
similarity index 99%
rename from testcases/kernel/timers/leapsec/leapsec_timer.c
rename to testcases/kernel/syscalls/clock_gettime/clock_gettime03.c
index 1d18f6433..633fea712 100644
--- a/testcases/kernel/timers/leapsec/leapsec_timer.c
+++ b/testcases/kernel/syscalls/clock_gettime/clock_gettime03.c
@@ -30,7 +30,7 @@
 #include <stdlib.h>
 #include <time.h>
 #include "test.h"
-#include "common_timers.h"
+#include "lapi/common_timers.h"
 
 #define SECONDS_BEFORE_LEAP 2
 #define SECONDS_AFTER_LEAP 2
diff --git a/testcases/kernel/timers/timer_create/.gitignore b/testcases/kernel/syscalls/timer_create/.gitignore
similarity index 50%
rename from testcases/kernel/timers/timer_create/.gitignore
rename to testcases/kernel/syscalls/timer_create/.gitignore
index a04bba838..5fd2c303e 100644
--- a/testcases/kernel/timers/timer_create/.gitignore
+++ b/testcases/kernel/syscalls/timer_create/.gitignore
@@ -1,2 +1,2 @@
+/timer_create01
 /timer_create02
-/timer_create04
diff --git a/testcases/kernel/timers/timer_create/Makefile b/testcases/kernel/syscalls/timer_create/Makefile
similarity index 100%
rename from testcases/kernel/timers/timer_create/Makefile
rename to testcases/kernel/syscalls/timer_create/Makefile
diff --git a/testcases/kernel/timers/timer_create/timer_create02.c b/testcases/kernel/syscalls/timer_create/timer_create01.c
similarity index 98%
rename from testcases/kernel/timers/timer_create/timer_create02.c
rename to testcases/kernel/syscalls/timer_create/timer_create01.c
index 4f52dafcf..258b6444c 100644
--- a/testcases/kernel/timers/timer_create/timer_create02.c
+++ b/testcases/kernel/syscalls/timer_create/timer_create01.c
@@ -24,7 +24,7 @@
 #include <time.h>
 #include "tst_test.h"
 #include "tst_safe_macros.h"
-#include "common_timers.h"
+#include "lapi/common_timers.h"
 
 static struct notif_type {
 	int		sigev_signo;
diff --git a/testcases/kernel/timers/timer_create/timer_create04.c b/testcases/kernel/syscalls/timer_create/timer_create02.c
similarity index 98%
rename from testcases/kernel/timers/timer_create/timer_create04.c
rename to testcases/kernel/syscalls/timer_create/timer_create02.c
index 1e403881d..1920f0874 100644
--- a/testcases/kernel/timers/timer_create/timer_create04.c
+++ b/testcases/kernel/syscalls/timer_create/timer_create02.c
@@ -24,7 +24,7 @@
 #include <time.h>
 #include <signal.h>
 #include "tst_test.h"
-#include "common_timers.h"
+#include "lapi/common_timers.h"
 
 static struct sigevent sig_ev = {
 	.sigev_notify = SIGEV_NONE,
diff --git a/testcases/kernel/timers/timer_delete/.gitignore b/testcases/kernel/syscalls/timer_delete/.gitignore
similarity index 50%
rename from testcases/kernel/timers/timer_delete/.gitignore
rename to testcases/kernel/syscalls/timer_delete/.gitignore
index fe1a28113..2524d3695 100644
--- a/testcases/kernel/timers/timer_delete/.gitignore
+++ b/testcases/kernel/syscalls/timer_delete/.gitignore
@@ -1,2 +1,2 @@
+/timer_delete01
 /timer_delete02
-/timer_delete03
diff --git a/testcases/kernel/timers/timer_delete/Makefile b/testcases/kernel/syscalls/timer_delete/Makefile
similarity index 100%
rename from testcases/kernel/timers/timer_delete/Makefile
rename to testcases/kernel/syscalls/timer_delete/Makefile
diff --git a/testcases/kernel/timers/timer_delete/timer_delete02.c b/testcases/kernel/syscalls/timer_delete/timer_delete01.c
similarity index 97%
rename from testcases/kernel/timers/timer_delete/timer_delete02.c
rename to testcases/kernel/syscalls/timer_delete/timer_delete01.c
index 6380a34cf..16e50ccec 100644
--- a/testcases/kernel/timers/timer_delete/timer_delete02.c
+++ b/testcases/kernel/syscalls/timer_delete/timer_delete01.c
@@ -17,7 +17,7 @@
 #include <errno.h>
 #include <time.h>
 #include "tst_test.h"
-#include "common_timers.h"
+#include "lapi/common_timers.h"
 
 static void run(void)
 {
diff --git a/testcases/kernel/timers/timer_delete/timer_delete03.c b/testcases/kernel/syscalls/timer_delete/timer_delete02.c
similarity index 96%
rename from testcases/kernel/timers/timer_delete/timer_delete03.c
rename to testcases/kernel/syscalls/timer_delete/timer_delete02.c
index 748c23c0f..29614f62e 100644
--- a/testcases/kernel/timers/timer_delete/timer_delete03.c
+++ b/testcases/kernel/syscalls/timer_delete/timer_delete02.c
@@ -17,7 +17,7 @@
 #include <errno.h>
 #include <time.h>
 #include "tst_test.h"
-#include "common_timers.h"
+#include "lapi/common_timers.h"
 
 #define INVALID_ID ((kernel_timer_t)-1)
 
diff --git a/testcases/kernel/timers/timer_settime/.gitignore b/testcases/kernel/syscalls/timer_settime/.gitignore
similarity index 50%
rename from testcases/kernel/timers/timer_settime/.gitignore
rename to testcases/kernel/syscalls/timer_settime/.gitignore
index 7741c630e..e1ed3ef17 100644
--- a/testcases/kernel/timers/timer_settime/.gitignore
+++ b/testcases/kernel/syscalls/timer_settime/.gitignore
@@ -1,2 +1,2 @@
+/timer_settime01
 /timer_settime02
-/timer_settime03
diff --git a/testcases/kernel/timers/timer_settime/Makefile b/testcases/kernel/syscalls/timer_settime/Makefile
similarity index 100%
rename from testcases/kernel/timers/timer_settime/Makefile
rename to testcases/kernel/syscalls/timer_settime/Makefile
diff --git a/testcases/kernel/timers/timer_settime/timer_settime02.c b/testcases/kernel/syscalls/timer_settime/timer_settime01.c
similarity index 98%
rename from testcases/kernel/timers/timer_settime/timer_settime02.c
rename to testcases/kernel/syscalls/timer_settime/timer_settime01.c
index 6c431c53d..fc1cf86a6 100644
--- a/testcases/kernel/timers/timer_settime/timer_settime02.c
+++ b/testcases/kernel/syscalls/timer_settime/timer_settime01.c
@@ -23,7 +23,7 @@
 #include <time.h>
 #include <signal.h>
 #include "tst_test.h"
-#include "common_timers.h"
+#include "lapi/common_timers.h"
 
 static struct timespec timenow;
 static struct itimerspec new_set, old_set;
diff --git a/testcases/kernel/timers/timer_settime/timer_settime03.c b/testcases/kernel/syscalls/timer_settime/timer_settime02.c
similarity index 99%
rename from testcases/kernel/timers/timer_settime/timer_settime03.c
rename to testcases/kernel/syscalls/timer_settime/timer_settime02.c
index bc3a0f2c8..9b410a399 100644
--- a/testcases/kernel/timers/timer_settime/timer_settime03.c
+++ b/testcases/kernel/syscalls/timer_settime/timer_settime02.c
@@ -23,7 +23,7 @@
 #include <errno.h>
 #include <time.h>
 #include "tst_test.h"
-#include "common_timers.h"
+#include "lapi/common_timers.h"
 
 static struct itimerspec new_set, old_set;
 static kernel_timer_t timer;
diff --git a/testcases/kernel/timers/Makefile b/testcases/kernel/timers/Makefile
deleted file mode 100644
index 15c164062..000000000
--- a/testcases/kernel/timers/Makefile
+++ /dev/null
@@ -1,27 +0,0 @@
-#
-#    testcases/kernel/timers Makefile.
-#
-#    Copyright (C) 2009, Cisco Systems, Inc.
-#
-#    This program is free software; you can redistribute it and/or modify
-#    it under the terms of the GNU General Public License as published by
-#    the Free Software Foundation; either version 2 of the License, or
-#    (at your option) any later version.
-#
-#    This program is distributed in the hope that it will be useful,
-#    but WITHOUT ANY WARRANTY; without even the implied warranty of
-#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-#    GNU General Public License for more details.
-#
-#    You should have received a copy of the GNU General Public License along
-#    with this program; if not, write to the Free Software Foundation, Inc.,
-#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
-#
-# Ngie Cooper, July 2009
-#
-
-top_srcdir		?= ../../..
-
-include $(top_srcdir)/include/mk/env_pre.mk
-
-include $(top_srcdir)/include/mk/generic_trunk_target.mk
diff --git a/testcases/kernel/timers/leapsec/.gitignore b/testcases/kernel/timers/leapsec/.gitignore
deleted file mode 100644
index 58787e2a2..000000000
--- a/testcases/kernel/timers/leapsec/.gitignore
+++ /dev/null
@@ -1 +0,0 @@
-/leapsec_timer
diff --git a/testcases/kernel/timers/leapsec/Makefile b/testcases/kernel/timers/leapsec/Makefile
deleted file mode 100644
index 782cdbcc9..000000000
--- a/testcases/kernel/timers/leapsec/Makefile
+++ /dev/null
@@ -1,27 +0,0 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2001
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
-
-top_srcdir		?= ../../../..
-
-include $(top_srcdir)/include/mk/testcases.mk
-
-CPPFLAGS		+= -I$(abs_srcdir)/../include
-
-LDLIBS			+= -lrt
-
-include $(top_srcdir)/include/mk/generic_leaf_target.mk
-- 
2.16.4

