From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Thu, 19 Nov 2015 17:49:23 +0800
Subject: [LTP] [PATCH] controllers/cpuacct: add kernel version check
Message-ID: <1447926563-26726-1-git-send-email-yangx.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Cpuacct should be supported with kernel 2.6.30 or newer

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 testcases/kernel/controllers/cpuacct/cpuacct.sh | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/testcases/kernel/controllers/cpuacct/cpuacct.sh b/testcases/kernel/controllers/cpuacct/cpuacct.sh
index 8552b5e..9916367 100755
--- a/testcases/kernel/controllers/cpuacct/cpuacct.sh
+++ b/testcases/kernel/controllers/cpuacct/cpuacct.sh
@@ -48,6 +48,11 @@ setup()
 {
 	tst_require_root
 
+	tst_kvercmp 2 6 30
+	if [ $? -eq 0 ]; then
+		tst_brkm TCONF "Test should be run with kernel 2.6.30 or newer"
+	fi
+
 	mount_point=`grep -w cpuacct /proc/mounts | cut -f 2 | cut -d " " -f2`
 	tst_resm TINFO "cpuacct: $mount_point"
 	if [ "$mount_point" = "" ]; then
-- 
1.8.3.1

