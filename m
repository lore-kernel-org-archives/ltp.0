Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5439CC5AC67
	for <ltp@archiver.kernel.org>; Fri,  7 Aug 2026 01:44:55 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6BE373E7074
	for <ltp@archiver.kernel.org>; Fri,  7 Aug 2026 03:44:53 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B65713E1B18
 for <ltp@lists.linux.it>; Fri,  7 Aug 2026 03:44:37 +0200 (CEST)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id EBE3E6008D5
 for <ltp@lists.linux.it>; Fri,  7 Aug 2026 03:44:34 +0200 (CEST)
X-UUID: 83925ac2920111f1aa26b74ffac11d73-20260807
X-CTIC-Tags: HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME,
 HR_CTE_8B
 HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
 HR_SJ_DIGIT_LEN, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM
 HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT
 HR_TO_NO_NAME, IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_TRUSTED
 SA_EXISTED, SN_TRUSTED, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS
 DMARC_NOPASS, CIE_BAD, CIE_GOOD, CIE_GOOD_SPF, GTI_FG_BS
 GTI_RG_INFO, GTI_C_BU, AMN_GOOD, ABX_MISS_RDNS
X-CID-O-RULE: Release_Ham
X-CID-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12, REQID:77dfa7e5-a418-43bb-8cd2-bb61dfea6385, IP:20,
 URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
 :release,TS:20
X-CID-INFO: VERSION:1.3.12, REQID:77dfa7e5-a418-43bb-8cd2-bb61dfea6385, IP:20,
 UR
 L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
 elease,TS:20
X-CID-META: VersionHash:e7bac3a, CLOUDID:a1959387fa9e9f0da80a432af6d465c8,
 BulkI
 D:260807094427AFKKN9S5,BulkQuantity:0,Recheck:0,SF:17|19|66|78|102|127|850
 |865|898,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:ni
 l,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE
 :0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 83925ac2920111f1aa26b74ffac11d73-20260807
X-User: wangxuewen@kylinos.cn
Received: from localhost.localdomain [(223.70.159.239)] by mailgw.kylinos.cn
 (envelope-from <wangxuewen@kylinos.cn>)
 (Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
 with ESMTP id 1496715638; Fri, 07 Aug 2026 09:44:22 +0800
From: Xuewen Wang <wangxuewen@kylinos.cn>
To: ltp@lists.linux.it
Date: Fri,  7 Aug 2026 09:44:16 +0800
Message-Id: <20260807014416.1453266-1-wangxuewen@kylinos.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3] memcg/functional: fix memcg_failcnt intermittent
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
Cc: Xuewen Wang <wangxuewen@kylinos.cn>
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
Changes in v2:
- Drop "2>/dev/null" from swapoff/swapon so that a failure to disable
  swap (or a missing swapoff binary) stays visible, instead of silently
  letting the intermittent timeout recur. Per the LTP AI review, the
  redirect hid the very error this fix relies on, and
  memcg_limit_in_bytes.sh does not redirect stderr either.

Changes in v3:
- Move swapoff to do_setup() and swapon to do_cleanup() per Li Wang,
  instead of wrapping each test iteration with swapoff/swapon in do_test().
---
 .../controllers/memcg/functional/memcg_failcnt.sh  | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/testcases/kernel/controllers/memcg/functional/memcg_failcnt.sh b/testcases/kernel/controllers/memcg/functional/memcg_failcnt.sh
index 3a02d16c2..93e8d4838 100755
--- a/testcases/kernel/controllers/memcg/functional/memcg_failcnt.sh
+++ b/testcases/kernel/controllers/memcg/functional/memcg_failcnt.sh
@@ -11,6 +11,20 @@
 MEMCG_TESTFUNC=do_test
 MEMCG_SHMMAX=1
 TST_TEST_DATA="--mmap-anon --mmap-file --shm"
+TST_SETUP=do_setup
+TST_CLEANUP=do_cleanup
+
+do_setup()
+{
+	memcg_setup
+	swapoff -a
+}
+
+do_cleanup()
+{
+	swapon -a
+	memcg_cleanup
+}
 
 do_test()
 {
-- 
2.25.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
