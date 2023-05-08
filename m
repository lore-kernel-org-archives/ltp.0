Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C387AC77B75
	for <ltp@archiver.kernel.org>; Mon,  8 May 2023 01:39:57 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6BF1E3C02D4
	for <ltp@archiver.kernel.org>; Mon,  8 May 2023 03:39:54 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 50E593C0189
 for <ltp@lists.linux.it>; Mon,  8 May 2023 03:39:42 +0200 (CEST)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 0418A600085
 for <ltp@lists.linux.it>; Mon,  8 May 2023 03:39:34 +0200 (CEST)
X-UUID: 7c85f617685446eb99e55387266d3d82-20230508
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.22, REQID:c1302663-6dde-4f30-9a08-4309a0b00f67, IP:10,
 URL:0,TC:0,Content:0,EDM:25,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACT
 ION:release,TS:20
X-CID-INFO: VERSION:1.1.22, REQID:c1302663-6dde-4f30-9a08-4309a0b00f67, IP:10,
 UR
 L:0,TC:0,Content:0,EDM:25,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
 N:release,TS:20
X-CID-META: VersionHash:120426c, CLOUDID:58690531-6935-4eab-a959-f84f8da15543,
 B
 ulkID:230508093919I8USPRS9,BulkQuantity:0,Recheck:0,SF:24|17|19|44|102,TC:
 nil,Content:0,EDM:5,IP:-2,URL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,
 OSI:0,OSA:0,AV:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-UUID: 7c85f617685446eb99e55387266d3d82-20230508
Received: from mail.kylinos.cn [(39.156.73.10)] by mailgw
 (envelope-from <zenghao@kylinos.cn>) (Generic MTA)
 with ESMTP id 546343616; Mon, 08 May 2023 09:39:17 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
 by mail.kylinos.cn (NSMail) with SMTP id DB80EE0084A4;
 Mon,  8 May 2023 09:39:16 +0800 (CST)
X-ns-mid: postfix-645852C4-80096215
Received: from zdzh5-QiTianM428-A376.. (unknown [172.20.12.253])
 by mail.kylinos.cn (NSMail) with ESMTPA id 57315E0084A4;
 Mon,  8 May 2023 09:39:16 +0800 (CST)
From: Hao Zeng <zenghao@kylinos.cn>
To: pvorel@suse.cz
Date: Mon,  8 May 2023 09:39:14 +0800
Message-Id: <20230508013914.245451-1-zenghao@kylinos.cn>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3] testcases:Fix the failure of shell script to get
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
 testcases/kernel/controllers/cpuctl_fj/run_cpuctl_test_fj.sh | 2 +-
 testcases/kernel/controllers/cpuset/cpuset_funcs.sh          | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/controllers/cpuctl_fj/run_cpuctl_test_fj.sh b/testcases/kernel/controllers/cpuctl_fj/run_cpuctl_test_fj.sh
index ab73c801b..5cb6bb566 100755
--- a/testcases/kernel/controllers/cpuctl_fj/run_cpuctl_test_fj.sh
+++ b/testcases/kernel/controllers/cpuctl_fj/run_cpuctl_test_fj.sh
@@ -63,7 +63,7 @@ cleanup()
 		return 0
 	}
 
-	find $CPUCTL -type d | sort | sed -n '2,$p' | tac | while read tmpdir
+	find $CPUCTL -type d | sort | sed -n '2,$p' | tac | while read -r tmpdir
 	do
 		while read tmppid
 		do
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
