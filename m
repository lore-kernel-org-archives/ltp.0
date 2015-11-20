From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Fri, 20 Nov 2015 13:36:34 +0800
Subject: [LTP] [PATCH v2] controllers/cpuacct: add cpuacct availability check
In-Reply-To: <20151119120501.GC28969@rei.lan>
References: <20151119120501.GC28969@rei.lan>
Message-ID: <1447997794-22234-1-git-send-email-yangx.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 testcases/kernel/controllers/cpuacct/cpuacct.sh | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/testcases/kernel/controllers/cpuacct/cpuacct.sh b/testcases/kernel/controllers/cpuacct/cpuacct.sh
index 8552b5e..8639e42 100755
--- a/testcases/kernel/controllers/cpuacct/cpuacct.sh
+++ b/testcases/kernel/controllers/cpuacct/cpuacct.sh
@@ -48,6 +48,11 @@ setup()
 {
 	tst_require_root
 
+	grep -q cpuacct /proc/cgroups 2>/dev/null
+	if [ $? -ne 0 ]; then
+		tst_brkm TCONF "cpuacct not supported on this system"
+	fi
+
 	mount_point=`grep -w cpuacct /proc/mounts | cut -f 2 | cut -d " " -f2`
 	tst_resm TINFO "cpuacct: $mount_point"
 	if [ "$mount_point" = "" ]; then
-- 
1.8.3.1

