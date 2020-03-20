From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Fri, 20 Mar 2020 15:08:49 +0800
Subject: [LTP] [PATCH] clocks/invaliddates.c: Remove outdated clock time
 setting
Message-ID: <1584688129-31873-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

For CLOCK_REALTIME, attempting to set the time to a value less than
the current value of the CLOCK_MONOTONIC will trigger a EINVAL error
since linux 4.3. Remove zero and also increase threshold for delta with
personal experience.

Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
---
 .../functional/timers/clocks/invaliddates.c                | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/testcases/open_posix_testsuite/functional/timers/clocks/invaliddates.c b/testcases/open_posix_testsuite/functional/timers/clocks/invaliddates.c
index 2ebf7f0b0..face334fd 100644
--- a/testcases/open_posix_testsuite/functional/timers/clocks/invaliddates.c
+++ b/testcases/open_posix_testsuite/functional/timers/clocks/invaliddates.c
@@ -5,7 +5,7 @@
  * of this license, see the COPYING file at the top level of this
  * source tree.
  *
- * Test that the clock time can be set to 0, a large number, Y2K
+ * Test that the clock time can be set to a large number, Y2K
  * critical dates, and times around daylight savings.
  *
  * Test for CLOCK_REALTIME.  (N/A for CLOCK_MONOTONIC as that clock
@@ -16,13 +16,12 @@
 #include <stdint.h>
 #include "posixtest.h"
 
-#define NUMTESTS 6
+#define NUMTESTS 5
 
 #define ACCEPTABLESECDELTA 0
-#define ACCEPTABLENSECDELTA 5000
+#define ACCEPTABLENSECDELTA 5000000
 
 static int testtimes[NUMTESTS][2] = {
-	{0, 0},			// zero
 	{INT32_MAX, 999999999},	// large number
 	{946713600, 999999999},	// Y2K - Jan 1, 2000
 	{951811200, 999999999},	// Y2K - Feb 29, 2000
-- 
2.18.1



