Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C737FC64EC4
	for <ltp@archiver.kernel.org>; Thu,  9 Mar 2023 03:15:43 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4C6CA3CD945
	for <ltp@archiver.kernel.org>; Thu,  9 Mar 2023 04:15:41 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 63FFB3CB79F
 for <ltp@lists.linux.it>; Thu,  9 Mar 2023 04:15:27 +0100 (CET)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 512D42003AB
 for <ltp@lists.linux.it>; Thu,  9 Mar 2023 04:15:25 +0100 (CET)
X-UUID: 81605e8227834fe9be6d1b2491dac6cb-20230309
X-CPASD-INFO: 30802be1e2a346a3a59e4999428dc644@fIByUF-Uk2GRUqN_g3msbYFmaZVkZVm
 IdmxYlJFmYFSVhH5xTV5nX1V9gnNXZF5dXFV3dnBQYmBhXVJ3i3-XblBgXoZgUZB3gnJyUGKQlQ==
X-CLOUD-ID: 30802be1e2a346a3a59e4999428dc644
X-CPASD-SUMMARY: SIP:-1, APTIP:-2.0, KEY:0.0, FROMBLOCK:1, OB:0.0, URL:-5,
 TVAL:184.
 0, ESV:0.0, ECOM:-5.0, ML:0.0, FD:0.0, CUTS:161.0, IP:-2.0, MAL:-5.0, PHF:-5.0,
 PHC:-5
 .0, SPF:4.0, EDMS:-5, IPLABEL:4480.0, FROMTO:0, AD:0, FFOB:0.0, CFOB:0.0, SPC:0,
 SIG:-
 5, AUF:5, DUF:17644, ACD:255, DCD:255, SL:0, EISP:0, AG:0, CFC:0.284,
 CFSR:0.064, UAT:0
 , RAF:0, IMG:-5.0, DFA:0, DTA:0, IBL:-2.0, ADI:-5, SBL:0, REDM:0, REIP:0, ESB:0,
 ATTNUM: 0,EAF:0,CID:-5.0,VERSION:2.3.17
X-CPASD-ID: 81605e8227834fe9be6d1b2491dac6cb-20230309
X-CPASD-BLOCK: 1000
X-CPASD-STAGE: 1
X-UUID: 81605e8227834fe9be6d1b2491dac6cb-20230309
X-User: gehao@kylinos.cn
Received: from localhost.localdomain [(116.128.244.169)] by mailgw
 (envelope-from <gehao@kylinos.cn>) (Generic MTA)
 with ESMTP id 877796779; Thu, 09 Mar 2023 11:15:27 +0800
From: Hao Ge <gehao@kylinos.cn>
To: ltp@lists.linux.it
Date: Thu,  9 Mar 2023 11:15:17 +0800
Message-Id: <20230309031517.198523-1-gehao@kylinos.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] memcg_stress_test.sh: fix reserved mem calculate
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
calculate to ten percent of free memory.

Here is an example:

free -m
              total        used        free      shared  buff/cache   available
Mem:         260184        2959      255854          62        1370      236346
Swap:          4095           0        4095

Signed-off-by: Hao Ge <gehao@kylinos.cn>
---
 .../kernel/controllers/memcg/stress/memcg_stress_test.sh    | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/testcases/kernel/controllers/memcg/stress/memcg_stress_test.sh b/testcases/kernel/controllers/memcg/stress/memcg_stress_test.sh
index cb52840d7..f26a9f72a 100755
--- a/testcases/kernel/controllers/memcg/stress/memcg_stress_test.sh
+++ b/testcases/kernel/controllers/memcg/stress/memcg_stress_test.sh
@@ -40,7 +40,7 @@ setup()
 	MEM=$(( $mem_free + $swap_free / 2 ))
 	MEM=$(( $MEM / 1024 ))
 	RUN_TIME=$(( 15 * 60 ))
-	[ "$pgsize" = "4096" ] && THREAD_SPARE_MB=1 || THREAD_SPARE_MB=8
+	RESERVED_MEMORY=$(( $MEM * 10/100 ))
 
 	tst_res TINFO "Calculated available memory $MEM MB"
 }
@@ -93,12 +93,12 @@ run_stress()
 
 test1()
 {
-	run_stress 150 $(( ($MEM - 150 * $THREAD_SPARE_MB) / 150 )) 5 $RUN_TIME
+	run_stress 150 $(( ($MEM - $RESERVED_MEMORY) / 150 )) 5 $RUN_TIME
 }
 
 test2()
 {
-	run_stress 1 $(( $MEM - $THREAD_SPARE_MB)) 5 $RUN_TIME
+	run_stress 1 $(( $MEM - $RESERVED_MEMORY)) 5 $RUN_TIME
 }
 
 . cgroup_lib.sh
-- 
2.25.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
