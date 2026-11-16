Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C689606A31F
	for <ltp@archiver.kernel.org>; Mon, 16 Nov 2026 01:33:07 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4E08F3EB432
	for <ltp@archiver.kernel.org>; Mon, 16 Nov 2026 02:33:05 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BFAA73E69ED
 for <ltp@lists.linux.it>; Mon, 16 Nov 2026 02:32:45 +0100 (CET)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 4AE401A00782
 for <ltp@lists.linux.it>; Mon, 16 Nov 2026 02:32:26 +0100 (CET)
X-UUID: 8552fa50e15d11f19a56ed5b684f684d-20261116
X-CID-O-RULE: Release_Ham
X-CID-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19, REQID:c4601b1c-cb1f-44d2-a098-9639aa9d0860, IP:10,
 URL:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
 N:release,TS:35
X-CID-INFO: VERSION:1.3.19, REQID:c4601b1c-cb1f-44d2-a098-9639aa9d0860, IP:10,
 UR
 L:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:35
X-CID-META: VersionHash:7db8b62, CLOUDID:4c5eeba28b52a54d8cb2ce37e7697e47,
 BulkI
 D:26111609192621343ED7,BulkQuantity:1,SF:19|66|72|78|102|127|153|865|898,T
 C:nil,Content:0|15|50|99,EDM:5,IP:-2,URL:0,File:nil,RT:nil,Bulk:40,QS:nil,
 BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FSD
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 8552fa50e15d11f19a56ed5b684f684d-20261116
X-User: yumiao@kylinos.cn
Received: from kylinos.cn [(114.244.3.119)] by mailgw.kylinos.cn
 (envelope-from <yumiao@kylinos.cn>)
 (Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
 with ESMTP id 263855768; Mon, 16 Nov 2026 09:32:01 +0800
From: Yu Miao <yumiao@kylinos.cn>
To: ltp@lists.linux.it
Date: Mon, 16 Nov 2026 09:31:47 +0800
Message-ID: <20261116013147.69993-1-yumiao@kylinos.cn>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] memcg_lib.sh: poll for expected values in
 check_mem_stat()
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Reading memory.stat does not always return up-to-date values: the
kernel only flushes the pending stats updates synchronously when they
exceed a threshold (MEMCG_CHARGE_BATCH * num_online_cpus()), otherwise
the updates are applied by the periodic async flusher, so the values
can be stale for up to 2 seconds.

The tests only touch 65 pages (260KiB), which may generate fewer
stat updates than the threshold on machines with multiple CPUs, so
the checks right after the memory has been touched may read stale
values and fail, e.g. on 7.3.0 with 4 CPUs:

    memcg_stat_rss 1 TFAIL: rss is 0, 266240 expected

Poll for the expected value with a 3s timeout instead, which follows
the polling pattern already used by signal_memcg_process() in this
file.

Signed-off-by: Yu Miao <yumiao@kylinos.cn>
---
 .../controllers/memcg/functional/memcg_lib.sh | 33 ++++++++++++-------
 1 file changed, 21 insertions(+), 12 deletions(-)

diff --git a/testcases/kernel/controllers/memcg/functional/memcg_lib.sh b/testcases/kernel/controllers/memcg/functional/memcg_lib.sh
index 5efede9..6960d72 100755
--- a/testcases/kernel/controllers/memcg/functional/memcg_lib.sh
+++ b/testcases/kernel/controllers/memcg/functional/memcg_lib.sh
@@ -160,21 +160,30 @@ shmmax_cleanup()
 check_mem_stat()
 {
 	local item_size
+	local cms_iter
 
-	if [ -e $1 ]; then
-		item_size=$(cat $1)
-	else
-		item_size=$(grep -w $1 memory.stat | cut -d " " -f 2)
-	fi
-
-	if [ "$3" ]; then
-		if [ $item_size -ge $2 ] && [ $item_size -le $3 ]; then
-			tst_res TPASS "$1 is ${2}-${3} as expected"
+	for cms_iter in $(seq 30); do
+		if [ -e $1 ]; then
+			item_size=$(cat $1)
 		else
-			tst_res TFAIL "$1 is $item_size, ${2}-${3} expected"
+			item_size=$(grep -w $1 memory.stat | cut -d " " -f 2)
+		fi
+
+		if [ "$3" ]; then
+			if [ $item_size -ge $2 ] && [ $item_size -le $3 ]; then
+				tst_res TPASS "$1 is ${2}-${3} as expected"
+				return
+			fi
+		elif [ "$2" = "$item_size" ]; then
+			tst_res TPASS "$1 is $2 as expected"
+			return
 		fi
-	elif [ "$2" = "$item_size" ]; then
-		tst_res TPASS "$1 is $2 as expected"
+
+		tst_sleep 100ms
+	done
+
+	if [ "$3" ]; then
+		tst_res TFAIL "$1 is $item_size, ${2}-${3} expected"
 	else
 		tst_res TFAIL "$1 is $item_size, $2 expected"
 	fi
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
