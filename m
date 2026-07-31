Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BACCC55167
	for <ltp@archiver.kernel.org>; Fri, 31 Jul 2026 01:50:28 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 44ED73E91BF
	for <ltp@archiver.kernel.org>; Fri, 31 Jul 2026 03:50:27 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 140D73E49EE
 for <ltp@lists.linux.it>; Fri, 31 Jul 2026 03:50:12 +0200 (CEST)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id B728D600868
 for <ltp@lists.linux.it>; Fri, 31 Jul 2026 03:50:09 +0200 (CEST)
X-UUID: 22dcd1328c8211f1aa26b74ffac11d73-20260731
X-CTIC-Tags: HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME,
 HR_CTE_8B
 HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
 HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE
 HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT, HR_TO_NO_NAME
 IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_TRUSTED, SA_EXISTED
 SN_EXISTED, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS, CIE_BAD
 CIE_GOOD, CIE_GOOD_SPF, GTI_FG_BS, GTI_RG_INFO, GTI_C_BU
 AMN_GOOD, ABX_MISS_RDNS
X-CID-O-RULE: Release_Ham
X-CID-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12, REQID:7eb9e494-1deb-4c9e-80e8-f42fddcf3524, IP:20,
 URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
 :release,TS:20
X-CID-INFO: VERSION:1.3.12, REQID:7eb9e494-1deb-4c9e-80e8-f42fddcf3524, IP:20,
 UR
 L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
 elease,TS:20
X-CID-META: VersionHash:e7bac3a, CLOUDID:a0a678ee45c7a5a8901f77b1616b41c3,
 BulkI
 D:260731095001SVFRX8OP,BulkQuantity:0,Recheck:0,SF:17|19|66|78|102|127|850
 |865|898,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:ni
 l,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE
 :0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_FSD,TF_CID_SPAM_SNR,TF_CID_SPAM_FAS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 22dcd1328c8211f1aa26b74ffac11d73-20260731
X-User: wangxuewen@kylinos.cn
Received: from localhost.localdomain [(223.70.159.239)] by mailgw.kylinos.cn
 (envelope-from <wangxuewen@kylinos.cn>)
 (Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
 with ESMTP id 1489118647; Fri, 31 Jul 2026 09:49:58 +0800
From: Xuewen Wang <wangxuewen@kylinos.cn>
To: ltp@lists.linux.it
Date: Fri, 31 Jul 2026 09:49:53 +0800
Message-Id: <20260731014953.2756261-1-wangxuewen@kylinos.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] memcg/functional: fix memcg_failcnt intermittent
 timeout by disabling swap
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
Cc: liwang@redhat.com, Xuewen Wang <wangxuewen@kylinos.cn>,
 rpalethorpe@suse.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

memcg_failcnt.sh tests the memory.failcnt counter by allocating
reclaimable memory (mmap-anon/mmap-file/shm) beyond a tiny cgroup
limit (1 page). It relies on the process being OOM-killed so that
signal_memcg_process()'s wait loop exits.

With swap enabled the kernel usually still OOM-kills the process,
but on arm64 reclaim (swap out) sometimes succeeds instead:
usage_in_bytes stays at the limit and the process keeps running,
so the wait loop times out (TBROK) intermittently.

Example failure on arm64 (kernel 6.6):
  memcg_failcnt 2 TBROK: timed out on memory.usage_in_bytes 4096 0 8192

Disable swap around the allocation and re-enable it afterwards,
mirroring what memcg_limit_in_bytes.sh already does for the same
reclaimable memory types.

Signed-off-by: Xuewen Wang <wangxuewen@kylinos.cn>
---
 .../controllers/memcg/functional/memcg_failcnt.sh     | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/testcases/kernel/controllers/memcg/functional/memcg_failcnt.sh b/testcases/kernel/controllers/memcg/functional/memcg_failcnt.sh
index 3a02d16c2..07d913147 100755
--- a/testcases/kernel/controllers/memcg/functional/memcg_failcnt.sh
+++ b/testcases/kernel/controllers/memcg/functional/memcg_failcnt.sh
@@ -11,11 +11,20 @@
 MEMCG_TESTFUNC=do_test
 MEMCG_SHMMAX=1
 TST_TEST_DATA="--mmap-anon --mmap-file --shm"
+TST_CLEANUP=do_cleanup
+
+do_cleanup()
+{
+	memcg_cleanup
+	swapon -a 2>/dev/null
+}
 
 do_test()
 {
 	ROD echo $MEMORY_LIMIT \> memory.limit_in_bytes
 
+	swapoff -a 2>/dev/null
+
 	start_memcg_process $2 -s ${MEMORY_TO_ALLOCATE}
 	ROD echo $MEMCG_PROCESS_PID \> tasks
 
@@ -24,6 +33,8 @@ do_test()
 
 	stop_memcg_process
 
+	swapon -a 2>/dev/null
+
 	failcnt=$(cat memory.failcnt)
 	if [ $failcnt -gt 0 ]; then
 		tst_res TPASS "memory.failcnt is $failcnt, > 0 as expected"
-- 
2.25.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
