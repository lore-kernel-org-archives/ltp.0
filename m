Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <wangxg.fnst@cn.fujitsu.com>) id 1YqC69-00010z-33
	for ltp-list@lists.sourceforge.net; Thu, 07 May 2015 03:03:41 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1YqC67-0003Ne-6E
	for ltp-list@lists.sourceforge.net; Thu, 07 May 2015 03:03:41 +0000
From: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
Date: Thu, 7 May 2015 10:54:45 +0800
Message-ID: <1430967285-15095-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH] device-drivers/zram: add kernel version check
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

zram device attributes max_comp_streams and comp_algorithm are introduced
since kernel v3.15, and mem_limit is introduced since kernel v3.18, we
need to add these check.

Signed-off-by: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
---
 testcases/kernel/device-drivers/zram/zram_lib.sh | 32 +++++++++++++++++++++---
 1 file changed, 29 insertions(+), 3 deletions(-)

diff --git a/testcases/kernel/device-drivers/zram/zram_lib.sh b/testcases/kernel/device-drivers/zram/zram_lib.sh
index e41d8c7..d3e62e0 100755
--- a/testcases/kernel/device-drivers/zram/zram_lib.sh
+++ b/testcases/kernel/device-drivers/zram/zram_lib.sh
@@ -62,7 +62,15 @@ zram_load()
 
 zram_max_streams()
 {
-	tst_resm TINFO "set max_comp_streams to zram device(s)"
+	tst_kvercmp 3 15 0
+	if [ $? -eq 0 ]; then
+		tst_resm TCONF "device attribute max_comp_streams is"\
+			"introduced since kernel v3.15, the running kernel"\
+			"does not support it"
+		return
+	else
+		tst_resm TINFO "set max_comp_streams to zram device(s)"
+	fi
 
 	local i=0
 	for max_s in $zram_max_streams; do
@@ -83,7 +91,16 @@ zram_max_streams()
 
 zram_compress_alg()
 {
-	tst_resm TINFO "test that we can set compression algorithm"
+	tst_kvercmp 3 15 0
+	if [ $? -eq 0 ]; then
+		tst_resm TCONF "device attribute comp_algorithm is"\
+			"introduced since kernel v3.15, the running kernel"\
+			"does not support it"
+		return
+	else
+		tst_resm TINFO "test that we can set compression algorithm"
+	fi
+
 	local algs=$(cat /sys/block/zram0/comp_algorithm)
 	tst_resm TINFO "supported algs: $algs"
 	local i=0
@@ -116,7 +133,16 @@ zram_set_disksizes()
 
 zram_set_memlimit()
 {
-	tst_resm TINFO "set memory limit to zram device(s)"
+	tst_kvercmp 3 18 0
+	if [ $? -eq 0 ]; then
+		tst_resm TCONF "device attribute mem_limit is"\
+			"introduced since kernel v3.18, the running kernel"\
+			"does not support it"
+		return
+	else
+		tst_resm TINFO "set memory limit to zram device(s)"
+	fi
+
 	local i=0
 	for ds in $zram_mem_limits; do
 		local sys_path="/sys/block/zram${i}/mem_limit"
-- 
1.8.3.1


------------------------------------------------------------------------------
One dashboard for servers and applications across Physical-Virtual-Cloud 
Widest out-of-the-box monitoring support with 50+ applications
Performance metrics, stats and reports that give you Actionable Insights
Deep dive visibility with transaction tracing using APM Insight.
http://ad.doubleclick.net/ddm/clk/290420510;117567292;y
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
