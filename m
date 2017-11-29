From: Wang Long <wanglong19@meituan.com>
Date: Wed, 29 Nov 2017 03:17:41 -0500
Subject: [LTP] [PATCH 2/2] Fix the way to check if the kernel has blkio
 cgroup enabled
In-Reply-To: <1511943461-3746-1-git-send-email-wanglong19@meituan.com>
References: <1511943461-3746-1-git-send-email-wanglong19@meituan.com>
Message-ID: <1511943461-3746-3-git-send-email-wanglong19@meituan.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This patch simple rename blockio to blkio.

Signed-off-by: Wang Long <wanglong19@meituan.com>
---
 testcases/kernel/controllers/test_controllers.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/testcases/kernel/controllers/test_controllers.sh b/testcases/kernel/controllers/test_controllers.sh
index 7aa974f..a5629a1 100755
--- a/testcases/kernel/controllers/test_controllers.sh
+++ b/testcases/kernel/controllers/test_controllers.sh
@@ -43,8 +43,8 @@ then
 	CPU_CONTROLLER_VALUE=`grep -w cpu /proc/cgroups | cut -f4`;
 	MEM_CONTROLLER=`grep -w memory /proc/cgroups | cut -f1`;
 	MEM_CONTROLLER_VALUE=`grep -w memory /proc/cgroups | cut -f4`;
-	IOTHROTTLE_CONTROLLER=`grep -w blockio /proc/cgroups | cut -f1`;
-	IOTHROTTLE_CONTROLLER_VALUE=`grep -w blockio /proc/cgroups | cut -f4`;
+	BLKIO_CONTROLLER=`grep -w blkio /proc/cgroups | cut -f1`;
+	BLKIO_CONTROLLER_VALUE=`grep -w blkio /proc/cgroups | cut -f4`;
 	FREEZER=`grep -w freezer /proc/cgroups | cut -f1`;
 	FREEZER_VALUE=`grep -w freezer /proc/cgroups | cut -f4`;
 	CPUACCOUNT_CONTROLLER=`grep -w cpuacct /proc/cgroups | cut -f1`
@@ -82,7 +82,7 @@ then
 		echo "Skipping all memory controller testcases....";
 	fi
 
-	if [ "$IOTHROTTLE_CONTROLLER" = "blockio" ] && [ "$IOTHROTTLE_CONTROLLER_VALUE" = "1" ]
+	if [ "$BLKIO_CONTROLLER" = "blkio" ] && [ "$BLKIO_CONTROLLER_VALUE" = "1" ]
 	then
 		$LTPROOT/testcases/bin/run_io_throttle_test.sh;
 	else
-- 
1.8.3.1

