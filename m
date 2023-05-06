Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3874C77B75
	for <ltp@archiver.kernel.org>; Sat,  6 May 2023 09:27:43 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 097773C9954
	for <ltp@archiver.kernel.org>; Sat,  6 May 2023 11:27:41 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B5F4F3C9954
 for <ltp@lists.linux.it>; Sat,  6 May 2023 11:27:27 +0200 (CEST)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 28C7F60069B
 for <ltp@lists.linux.it>; Sat,  6 May 2023 11:27:24 +0200 (CEST)
X-UUID: 383ac6c31d2343b28747fc96a2024ccd-20230506
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.22, REQID:419b4f05-6865-489b-8cfb-27dd29831559, IP:10,
 URL:0,TC:0,Content:0,EDM:25,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACT
 ION:release,TS:20
X-CID-INFO: VERSION:1.1.22, REQID:419b4f05-6865-489b-8cfb-27dd29831559, IP:10,
 UR
 L:0,TC:0,Content:0,EDM:25,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
 N:release,TS:20
X-CID-META: VersionHash:120426c, CLOUDID:35c3f26a-2f20-4998-991c-3b78627e4938,
 B
 ulkID:230506172708GW3SOA4M,BulkQuantity:0,Recheck:0,SF:24|17|19|44|102,TC:
 nil,Content:0,EDM:5,IP:-2,URL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,
 OSI:0,OSA:0,AV:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-UUID: 383ac6c31d2343b28747fc96a2024ccd-20230506
Received: from mail.kylinos.cn [(39.156.73.10)] by mailgw
 (envelope-from <zenghao@kylinos.cn>) (Generic MTA)
 with ESMTP id 1390641662; Sat, 06 May 2023 17:27:05 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
 by mail.kylinos.cn (NSMail) with SMTP id 3CAEBE0084A4;
 Sat,  6 May 2023 17:27:05 +0800 (CST)
X-ns-mid: postfix-64561D69-11182142
Received: from zdzh5-QiTianM428-A376.. (unknown [172.20.12.253])
 by mail.kylinos.cn (NSMail) with ESMTPA id A5680E0084A4;
 Sat,  6 May 2023 17:27:04 +0800 (CST)
From: Hao Zeng <zenghao@kylinos.cn>
To: pvorel@suse.cz
Date: Sat,  6 May 2023 17:27:02 +0800
Message-Id: <20230506092702.203395-1-zenghao@kylinos.cn>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] testcases:Fix the failure of shell script to get
 path
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
Cc: Hao Zeng <zenghao@kylinos.cn>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

For example:
in the file testcases/kernel/controllers/cpuset/cpuset_funcs.sh,
if the path is obtained by
find "$CPUSET" -type d | sort | sed -n '2,$p' | tac | while read subdir,
the escaped characters will be lost,and by adding the -r option,
the escaped characters will be kept as they are without escaping
The errors are as follows:
/opt/ltp/testcases/bin/cpuset_funcs.sh:line178:
/dev/cpuset/machine.slice/machine-qemux2d157x2dzhx2dsxf.scope/vcpu7/tasks:
The file or directory is not available
rmdir: delete
'/dev/cpuset/machine.slice/machine-qemux2d157x2dzhx2dsxf.scope/vcpu7'
Failure: The file or directory is not available
cpuset_memory_pressure 1 TFAIL: Couldn't remove subdir -
/opt/ltp/testcases/bin/cpuset_funcs.sh:line178:
/dev/cpuset/machine.slice/machine-qemux2d157x2dzhx2dsxf.scope/vcpu7/tasks:
The file or directory is not available
rmdir: delete
'/dev/cpuset/machine.slice/machine-qemux2d157x2dzhx2dsxf.scope/vcpu7'
Failure: The file or directory is not available
cpuset_memory_pressure 1 TFAIL: Couldn't remove subdir -

Signed-off-by: Hao Zeng <zenghao@kylinos.cn>
Suggested-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/kernel/controllers/cpuset/cpuset_funcs.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/controllers/cpuset/cpuset_funcs.sh b/testcases/kernel/controllers/cpuset/cpuset_funcs.sh
index 87ba7da1f..0cfa0c17e 100755
--- a/testcases/kernel/controllers/cpuset/cpuset_funcs.sh
+++ b/testcases/kernel/controllers/cpuset/cpuset_funcs.sh
@@ -184,7 +184,7 @@ cleanup()
 	echo $CHILDREN_VALUE > $CLONE_CHILDREN
 	echo $SCHED_LB_VALUE > $SCHED_LB
 
-	find "$CPUSET" -type d | sort | sed -n '2,$p' | tac | while read subdir
+	find "$CPUSET" -type d | sort | sed -n '2,$p' | tac | while read -r subdir
 	do
 		while read pid
 		do
-- 
2.37.2


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
