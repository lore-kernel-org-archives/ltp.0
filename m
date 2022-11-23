Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59D28C4332F
	for <ltp@archiver.kernel.org>; Wed, 23 Nov 2022 15:01:27 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 22B743CC9F6
	for <ltp@archiver.kernel.org>; Wed, 23 Nov 2022 16:01:25 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 661B03C03AE
 for <ltp@lists.linux.it>; Wed, 23 Nov 2022 16:01:15 +0100 (CET)
Received: from mail.jv-coder.de (mail.jv-coder.de [5.9.79.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id A723B20038F
 for <ltp@lists.linux.it>; Wed, 23 Nov 2022 16:01:14 +0100 (CET)
Received: from ubuntu.localdomain (unknown [91.26.40.236])
 by mail.jv-coder.de (Postfix) with ESMTPSA id 3B03EA080F;
 Wed, 23 Nov 2022 15:01:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jv-coder.de; s=dkim;
 t=1669215672; bh=LYgjGFfjh6IoTaWJKc67zBx+texGacjCEsUkcidzM9g=;
 h=From:To:Subject:Date:Message-Id:MIME-Version;
 b=tyt5eFdAlzXGAkapGbTvekL3OYcqSMp1/gKvZ4OG6OnI3P2v+zVNzWbClGWvQ/BK4
 6p116oP1QCywAhbkwxnknkIktrVFcdFMzPsNm2lsBeq1xEKWRLsOFrAUScz19QURF2
 1ihr+AF/l2mjPZzRGekidQi7Vm+JKtlhe65LEU+w=
From: Joerg Vehlow <lkml@jv-coder.de>
To: ltp@lists.linux.it,
	luke.nowakowskikrijger@canonical.com
Date: Wed, 23 Nov 2022 16:01:04 +0100
Message-Id: <20221123150104.2378876-1-lkml@jv-coder.de>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] memcg_conctrol_test: fix if CONFIG_SWAP=n
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
Cc: Joerg Vehlow <joerg.vehlow@aox.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

From: Joerg Vehlow <joerg.vehlow@aox.de>

This allows the test to run successfully on systems without swap enabled
It restores the behaviour of the test before
a77b65bbe ("controllers: Update memcg_control_test to newer test lib and cgroup lib")

Signed-off-by: Joerg Vehlow <joerg.vehlow@aox.de>
---
 .../kernel/controllers/memcg/control/memcg_control_test.sh  | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/controllers/memcg/control/memcg_control_test.sh b/testcases/kernel/controllers/memcg/control/memcg_control_test.sh
index 093d50c2a..941d918fc 100644
--- a/testcases/kernel/controllers/memcg/control/memcg_control_test.sh
+++ b/testcases/kernel/controllers/memcg/control/memcg_control_test.sh
@@ -47,7 +47,11 @@ test1()
 	tst_res TINFO "Test #1: Checking if the memory usage limit imposed by the topmost group is enforced"
 
 	ROD echo "$ACTIVE_MEM_LIMIT" \> "$test_dir/$memory_limit"
-	ROD echo "$TOT_MEM_LIMIT" \> "$test_dir/$memsw_memory_limit"
+	
+	# If the kernel is built without swap, the $memsw_memory_limit file is missing
+	if [ -e "$test_dir/$memsw_memory_limit" ]; then
+		ROD echo "$TOT_MEM_LIMIT" \> "$test_dir/$memsw_memory_limit"
+	fi
 
 	KILLED_CNT=0
 	test_proc_kill
-- 
2.25.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
