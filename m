Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6964BC61DA4
	for <ltp@archiver.kernel.org>; Mon, 13 Mar 2023 09:51:38 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BE7F03CD5C1
	for <ltp@archiver.kernel.org>; Mon, 13 Mar 2023 10:51:36 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 777783CAE6B
 for <ltp@lists.linux.it>; Mon, 13 Mar 2023 10:51:22 +0100 (CET)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id B84E76006D4
 for <ltp@lists.linux.it>; Mon, 13 Mar 2023 10:51:18 +0100 (CET)
X-UUID: 4faa214fe0e942efa10c521d29f29f96-20230313
X-CID-UNFAMILIAR: 1
X-CID-O-RULE: Release_Ham
X-CID-RULE: Release_HamU
X-CID-O-INFO: VERSION:1.1.20, REQID:70c87b02-05fe-4bf9-b338-535643f6f1c3, IP:5,
 U
 RL:0,TC:0,Content:0,EDM:0,RT:0,SF:18,FILE:0,BULK:0,RULE:Release_Ham,ACTION
 :release,TS:23
X-CID-INFO: VERSION:1.1.20, REQID:70c87b02-05fe-4bf9-b338-535643f6f1c3, IP:5,
 URL
 :0,TC:0,Content:0,EDM:0,RT:0,SF:18,FILE:0,BULK:0,RULE:Release_HamU,ACTION:
 release,TS:23
X-CID-META: VersionHash:25b5999, CLOUDID:eb1514b3-beed-4dfc-bd9c-e1b22fa6ccc4,
 B
 ulkID:230313175111KGQNENL8,BulkQuantity:0,Recheck:0,SF:38|23|16|19|43|102,
 TC:nil,Content:0,EDM:-3,IP:-2,URL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,CO
 L:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0
X-UUID: 4faa214fe0e942efa10c521d29f29f96-20230313
X-User: gehao@kylinos.cn
Received: from localhost.localdomain [(116.128.244.169)] by mailgw
 (envelope-from <gehao@kylinos.cn>) (Generic MTA)
 with ESMTP id 513340505; Mon, 13 Mar 2023 17:51:08 +0800
From: Hao Ge <gehao@kylinos.cn>
To: liwang@redhat.com,
	ltp@lists.linux.it
Date: Mon, 13 Mar 2023 17:50:49 +0800
Message-Id: <20230313095049.53761-1-gehao@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <c39b6d7.3f25.186da11eb00.Coremail.gehao618@163.com>
References: <c39b6d7.3f25.186da11eb00.Coremail.gehao618@163.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH V3] memcg_stress_test.sh: Fix reserved mem calculate
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Unsubscribe: <https://lists.linux.it/options/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=unsubscribe>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Cc: Hao Ge <gehao@kylinos.cn>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

When running this test case on a machine with large memory,
and without swap or swap is too small,existing reserved
memory is too small for a machine with large memory,and
will cause forking a subprocess to run a command will fail
due to memory is exhausted,so optimize reserved memory
calculate .

Signed-off-by: Hao Ge <gehao@kylinos.cn>
---
 .../memcg/stress/memcg_stress_test.sh         | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/testcases/kernel/controllers/memcg/stress/memcg_stress_test.sh b/testcases/kernel/controllers/memcg/stress/memcg_stress_test.sh
index cb52840d7..2c0488170 100755
--- a/testcases/kernel/controllers/memcg/stress/memcg_stress_test.sh
+++ b/testcases/kernel/controllers/memcg/stress/memcg_stress_test.sh
@@ -34,13 +34,20 @@ setup()
 	echo 3 > /proc/sys/vm/drop_caches
 	sleep 2
 	local mem_free=`cat /proc/meminfo | grep MemFree | awk '{ print $2 }'`
+	local mem_available=`cat /proc/meminfo | grep MemAvailable | awk '{ print $2 }'`
 	local swap_free=`cat /proc/meminfo | grep SwapFree | awk '{ print $2 }'`
-	local pgsize=`tst_getconf PAGESIZE`
-
-	MEM=$(( $mem_free + $swap_free / 2 ))
+	mem_min=`cat /proc/sys/vm/min_free_kbytes`
+
+	#Apply a margin because we cannot get below "min" watermark
+	mem_min=$(( $mem_min + $mem_min/10 ))
+	#we need calculate RESERVED_MEN , if have enough swap ,RESERVED_MEM =0
+	#else RESERVED_MEN = mem_min + mem_min/10
+	[ $swap_free -gt $mem_min ] && RESERVED_MEM=0 || RESERVED_MEM=$mem_min
+	# Use the lower value of free and available to calculate MEM
+	[ $mem_free -lt $mem_available ] && MEM=$mem_free || MEM=$mem_available
+	MEM=$(( $MEM - $RESERVED_MEM ))
 	MEM=$(( $MEM / 1024 ))
 	RUN_TIME=$(( 15 * 60 ))
-	[ "$pgsize" = "4096" ] && THREAD_SPARE_MB=1 || THREAD_SPARE_MB=8
 
 	tst_res TINFO "Calculated available memory $MEM MB"
 }
@@ -93,12 +100,12 @@ run_stress()
 
 test1()
 {
-	run_stress 150 $(( ($MEM - 150 * $THREAD_SPARE_MB) / 150 )) 5 $RUN_TIME
+	run_stress 150 $(( $MEM  / 150 )) 5 $RUN_TIME
 }
 
 test2()
 {
-	run_stress 1 $(( $MEM - $THREAD_SPARE_MB)) 5 $RUN_TIME
+	run_stress 1 $MEM 5 $RUN_TIME
 }
 
 . cgroup_lib.sh
-- 
2.25.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
