Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D510CD6E5D
	for <ltp@archiver.kernel.org>; Fri,  5 Jun 2026 05:45:20 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AE4403E2001
	for <ltp@archiver.kernel.org>; Fri,  5 Jun 2026 07:45:18 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id ADA1E3CE442
 for <ltp@lists.linux.it>; Fri,  5 Jun 2026 07:45:01 +0200 (CEST)
Received: from mail-m16.yeah.net (mail-m16.yeah.net [1.95.21.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 730551000A16
 for <ltp@lists.linux.it>; Fri,  5 Jun 2026 07:44:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
 s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=bc
 xMt0T+NIjYHD5N61M0smRge0vKuV0dobsAMsThRUk=; b=Wf6t23OEYPFFa6e/gL
 kEd1U1jtpOmECr/ckWkzPONilzc4miBaUWsTyrNjn8ErsNiSI/dSIg6NtEOh7TTU
 EPdoyRoLUUkmAvia67SbUIt/VCvsJ2EnKyFhhokd7/XMxh0F9C49Hmi3Snjp+XAE
 xNIjXwr+vz8aOPowBc4iHEyzg=
Received: from YGJ.localdomain (unknown [])
 by gzsmtp2 (Coremail) with UTF8SMTPA id Ms8vCgBnfvFVYiJq43SuAQ--.62395S2;
 Fri, 05 Jun 2026 13:44:54 +0800 (CST)
From: yeziwen1989@yeah.net
To: ltp@lists.linux.it
Date: Fri,  5 Jun 2026 13:44:53 +0800
Message-Id: <20260605054453.64067-1-yeziwen1989@yeah.net>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-CM-TRANSID: Ms8vCgBnfvFVYiJq43SuAQ--.62395S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrtw45Jr17ZrWUGr4DCF4Durg_yoWfWFc_AF
 43Xr97KrZFyr42ya4UJwn29rsxta4xCw48CrsFkay5Gr4UXr4kC3sY9F1DtrsrWws7Zasx
 Cr4DX392vwnIqjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xR_UUUUUUUUU==
X-Originating-IP: [171.213.186.2]
X-CM-SenderInfo: 51h2x4lhqrmm2z61vtnkoqv3/1tbiNhfQNGoiYlfY2AAA34
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] [v2] execve05: add exit call when execve failed
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
index 352c73c38..e68aa18c4 100644
--- a/testcases/kernel/syscalls/execve/execve05.c
+++ b/testcases/kernel/syscalls/execve/execve05.c
@@ -39,6 +39,7 @@ static void do_child(void)
 
 	TEST(execve(TEST_APP, argv, environ));
 	tst_res(TFAIL | TTERRNO, "execve() returned unexpected errno");
+	exit(EXIT_SUCCESS);
 }
 
 static void verify_execve(void)
-- 
2.34.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
