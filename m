Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A934C64ED6
	for <ltp@archiver.kernel.org>; Wed,  1 Mar 2023 15:28:17 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 15CF73CDD65
	for <ltp@archiver.kernel.org>; Wed,  1 Mar 2023 16:28:15 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1B18D3CB2FA
 for <ltp@lists.linux.it>; Wed,  1 Mar 2023 09:01:45 +0100 (CET)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 3341260033B
 for <ltp@lists.linux.it>; Wed,  1 Mar 2023 09:01:40 +0100 (CET)
X-UUID: ac9fd2209ae9439c8d966bd753bd07c5-20230301
X-CPASD-INFO: e8dd1a7e03174f4fa5d0c7f339487b02@roiehF6TZZVcU3ODg6l_oIFmlGCTY4a
 CdXNUaGWSXFKVhH5xTV5nX1V9gnNXZF5dXFV3dnBQYmBhXVJ3i3-XblBgXoZgUZB3tHqehGKPZw==
X-CLOUD-ID: e8dd1a7e03174f4fa5d0c7f339487b02
X-CPASD-SUMMARY: SIP:-1, APTIP:-2.0, KEY:0.0, FROMBLOCK:1, OB:0.0, URL:-5,
 TVAL:184.
 0, ESV:0.0, ECOM:-5.0, ML:0.0, FD:0.0, CUTS:149.0, IP:-2.0, MAL:-5.0, PHF:-5.0,
 PHC:-5
 .0, SPF:4.0, EDMS:-5, IPLABEL:4480.0, FROMTO:0, AD:0, FFOB:0.0, CFOB:1.0, SPC:0,
 SIG:-
 5, AUF:2, DUF:17225, ACD:248, DCD:248, SL:0, EISP:0, AG:0, CFC:0.335,
 CFSR:0.055, UAT:0
 , RAF:0, IMG:-5.0, DFA:0, DTA:0, IBL:-2.0, ADI:-5, SBL:0, REDM:0, REIP:0, ESB:0,
 ATTNUM: 0,EAF:0,CID:-5.0,VERSION:2.3.17
X-CPASD-ID: ac9fd2209ae9439c8d966bd753bd07c5-20230301
X-CPASD-BLOCK: 1000
X-CPASD-STAGE: 1
X-UUID: ac9fd2209ae9439c8d966bd753bd07c5-20230301
X-User: gehao@kylinos.cn
Received: from localhost.localdomain [(116.128.244.169)] by mailgw
 (envelope-from <gehao@kylinos.cn>) (Generic MTA)
 with ESMTP id 1453693745; Wed, 01 Mar 2023 16:01:39 +0800
From: Hao Ge <gehao@kylinos.cn>
To: ltp@lists.linux.it
Date: Wed,  1 Mar 2023 16:01:31 +0800
Message-Id: <20230301080131.86627-1-gehao@kylinos.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Wed, 01 Mar 2023 16:28:03 +0100
Subject: [LTP] [ [PATCH]] cpuset/cpuset_memory_pressure_test: Fix free
 memory calculate
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

Currently, free has two output formats,as follows

free -m
        total        used        free      shared  buff/cache   available
Mem:   128135        3857      120633         158        3644      123219
Swap:    8191          82        8109

free -m
        total       used       free     shared    buffers     cached
Mem:   419694       9464     410230        234        435       6005
-/+ buffers/cache:       3022     416671
Swap:    2053          0       2053

We need to avoid the error of adding the available item so that free is
wrong.

Signed-off-by: Hao Ge <gehao@kylinos.cn>
---
 .../cpuset_memory_pressure_testset.sh                  | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/controllers/cpuset/cpuset_memory_pressure_test/cpuset_memory_pressure_testset.sh b/testcases/kernel/controllers/cpuset/cpuset_memory_pressure_test/cpuset_memory_pressure_testset.sh
index eddd7f6c5..d3428a9a0 100755
--- a/testcases/kernel/controllers/cpuset/cpuset_memory_pressure_test/cpuset_memory_pressure_testset.sh
+++ b/testcases/kernel/controllers/cpuset/cpuset_memory_pressure_test/cpuset_memory_pressure_testset.sh
@@ -32,8 +32,16 @@ check
 
 exit_status=0
 
+#read free layout is buff/cache or buff cache
+bc_string=$(free -g | awk '{if(NR==1) print $5}')
+
 # usable physical memory
-py_mem=$(free -m | awk '{if(NR==2) print $4 + $6 + $7}')
+if [ "$bc_string" == "buff/cache" ]
+then
+        py_mem=$(free -m | awk '{if(NR==2) print $4 + $6}')
+else
+        py_mem=$(free -m | awk '{if(NR==2) print $4 + $6 + $7}')
+fi
 
 # free swap space
 sw_mem=$(free -m | awk '{if(NR==4) print $4}')
-- 
2.25.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
