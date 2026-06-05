Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92829CD6E75
	for <ltp@archiver.kernel.org>; Fri,  5 Jun 2026 03:19:45 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 812633CDC08
	for <ltp@archiver.kernel.org>; Fri,  5 Jun 2026 05:19:43 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1540D3CDC08
 for <ltp@lists.linux.it>; Fri,  5 Jun 2026 05:19:26 +0200 (CEST)
Received: from mail-m16.yeah.net (mail-m16.yeah.net [1.95.21.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 532AC6009EA
 for <ltp@lists.linux.it>; Fri,  5 Jun 2026 05:19:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
 s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=GD
 SAJzADRiZaaCXzEaXGiwi7hOdEy380jSyuSHaUT5k=; b=j0lmPweBIKZqcC2Ybe
 9QJXJfpDphZZDcZjoISjEKzudir6OtiTevwL6deYUo8QWoplxFyF1XpxuJqRcvRM
 6xEeVNGGV6684oeyHbmq1vl1OHuvsIxtqwXEVpwrSP/5jDcCw69ka4bOj6DCPvwI
 pZ/b4iYBDodXiiNtdx2k2dTOw=
Received: from YGJ.localdomain (unknown [])
 by gzsmtp1 (Coremail) with UTF8SMTPA id Mc8vCgAn16A3QCJqH3aiAQ--.12771S2;
 Fri, 05 Jun 2026 11:19:19 +0800 (CST)
From: yeziwen1989@yeah.net
To: ltp@lists.linux.it
Date: Fri,  5 Jun 2026 11:19:19 +0800
Message-Id: <20260605031919.5946-1-yeziwen1989@yeah.net>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-CM-TRANSID: Mc8vCgAn16A3QCJqH3aiAQ--.12771S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrtw45Jr17ZrWUGr4DCF4Durg_yoWfWFc_AF
 43Xrn7KrZFyr42k34UJwn29rsxta4xGw4rCrnFkay5Gr4UXr4kG3sY9F1DtrsrWws7uasx
 Cr4DX392gwnIqjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xR_UUUUUUUUU==
X-Originating-IP: [171.213.186.2]
X-CM-SenderInfo: 51h2x4lhqrmm2z61vtnkoqv3/1tbiNBhBpGoiQDhYPAAA3d
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] execve05: add exit call when execve failed
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
Cc: Yeguojin <yeziwen1989@yeah.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

From: Yeguojin <yeziwen1989@yeah.net>

When execve_child loses its executable permission
due to other exceptions, execve05 will degenerate
into a fork bomb, which will then exhaust system
resources and cause other system exceptions.

Signed-off-by: Yeguojin <yeziwen1989@yeah.net>
---
 testcases/kernel/syscalls/execve/execve05.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/testcases/kernel/syscalls/execve/execve05.c b/testcases/kernel/syscalls/execve/execve05.c
index 352c73c38..4b7eca9cf 100644
--- a/testcases/kernel/syscalls/execve/execve05.c
+++ b/testcases/kernel/syscalls/execve/execve05.c
@@ -39,6 +39,7 @@ static void do_child(void)
 
 	TEST(execve(TEST_APP, argv, environ));
 	tst_res(TFAIL | TTERRNO, "execve() returned unexpected errno");
+	exit(EXIT_FAILURE);
 }
 
 static void verify_execve(void)
-- 
2.34.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
